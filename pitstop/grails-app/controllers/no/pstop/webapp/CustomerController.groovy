package no.pstop.webapp

import grails.converters.JSON

class CustomerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count()]
    }

    def create = {
        def customerInstance = new Customer()
        customerInstance.properties = params
        return [customerInstance: customerInstance]
    }

    def save = {
        def customerInstance = new Customer(params)
        if (customerInstance.save(flush: true)) {
            flash.message = "${message(code: 'customer.created.message', args: [message(code: 'customer.label' ), customerInstance.firstName, customerInstance.lastName])}"
            redirect(action: "show", id: customerInstance.id)
        }
        else {
            render(view: "create", model: [customerInstance: customerInstance])
        }
    }

    def show = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [customerInstance: customerInstance]
        }
    }

    def edit = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerInstance: customerInstance]
        }
    }

    def update = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            customerInstance.properties = params
            if (!customerInstance.hasErrors() && customerInstance.save(flush: true)) {
                flash.message = "${message(code: 'customer.updated.message', args: [message(code: 'customer.label'), customerInstance.firstName, customerInstance.lastName])}"
                redirect(action: "show", id: customerInstance.id)
            }
            else {
                render(view: "edit", model: [customerInstance: customerInstance])
            }
        }
        else {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            try {
                customerInstance.delete(flush: true)
                flash.message = "${message(code: 'customer.deleted.message', args: [message(code: 'customer.label'), customerInstance.firstName, customerInstance.lastName])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'customer.not.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def autoComplete = {
		def customers = Customer.list()
		
		customers = customers.collect {
			[id: it.id, name: it.firstName]
		}
		def jsonCustomer = [
		    result: customers
		]
		render jsonCustomer as JSON
	}
}
