package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;
import grails.converters.JSON

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class CustomerController {
	static final maxNumberOfTireHotelOccurrences = 10
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

	def list = {
		def customerList
		def customerCount
		
		if(params.q){
			customerList = Customer.search("*" + params.q + "*", escape: true).results
			customerCount = customerList.size()
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			customerList = Customer.list(params)
			customerCount = Customer.count()
		}
		
		if(customerCount == 0 ) {
			flash.message = "Fant ingen kunder."
		}
		
		[customerInstanceList: customerList, customerInstanceTotal: customerCount]
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
			if(!params.max)
				params.max = maxNumberOfTireHotelOccurrences
			if(!params.offset)
				params.offset = 0
        	def tireHotelOccurrenceInstanceList = TireHotelOccurrence.findAllByCustomer(Customer.get(params.id), [max:params.max, offset:params.offset])
        	def customerOrderInstanceList = CustomerOrder.findAllByCustomer(Customer.get(params.id), [max:params.max, offset:params.offset]) // TODO Fikse sortering , sort:params.sort, order:params.order 
        	def tireHotelOccurrenceInstanceTotalList = TireHotelOccurrence.findAllByCustomer(Customer.get(params.id))
			[tireHotelOccurrenceInstanceList: tireHotelOccurrenceInstanceList, customerInstance: customerInstance, tireHotelOccurrenceInstanceTotalList: tireHotelOccurrenceInstanceTotalList,
			 	customerOrderInstanceList: customerOrderInstanceList]
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

	@Secured(['ROLE_ADMIN'])
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

	def customerAutoComplete = {
		println params
		def customers = Customer.findAllByFirstNameLikeOrLastNameLikeOrPhoneNumberLike("%${params.query}%", "%${params.query}%", "%${params.query}%")
		
		customers = customers.collect {
			[id: it.id, name:it.autoCompleteToString()]
		}
		def jsonCustomer = [
				customers: customers
				]
		render jsonCustomer as JSON
	}
	def search = {
		redirect(action: "list", params:[q: params.search])
	}
}
