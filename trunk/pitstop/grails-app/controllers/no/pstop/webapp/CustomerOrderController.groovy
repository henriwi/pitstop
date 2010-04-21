package no.pstop.webapp
import grails.converters.deep.JSON;

import java.util.Date;
import java.util.Iterator;

class CustomerOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def orderService
		
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		def customerOrderList
		def customerOrderCount
		
		if(params.q){
			customerOrderList = CustomerOrder.search("*" + params.q + "*").results
			customerOrderCount = customerOrderList.size()
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			customerOrderList = CustomerOrder.list(params)
			customerOrderCount = CustomerOrder.count()
		}	
			
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [customerOrderInstanceList: customerOrderList, customerOrderInstanceTotal: customerOrderCount]
    }

    def create = {
		session["order"] = new CustomerOrder()
		session["orderLines"] = []
		//session["tire"]// = Tire.list()
		session["customer"] = Customer.get(params.customerId)
		
		//return [tireList: session["tireList"]]
    }

    def save = {
    	def customer = session["customer"]
		def customerOrderInstance = session["order"]
		customerOrderInstance.orderDate = new Date()
		customerOrderInstance.customer = customer
		
		try {
			orderService.saveCustomerOrder(customerOrderInstance, session)
			redirect(action: "show", controller: "customerOrder", id: customerOrderInstance.id)
		}
		catch(result) {
			flash.message = "Kunne ikke lagre ordren." + result
			redirect(action: "create")
		}
    }

    def show = {
        def customerOrderInstance = CustomerOrder.get(params.id)
        if (!customerOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
            redirect(action: "list")
        }
        else {
            [customerOrderInstance: customerOrderInstance]
        }
    }

    def edit = {
        def customerOrderInstance = CustomerOrder.get(params.id)
        if (!customerOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerOrderInstance: customerOrderInstance]
        }
    }

    def update = {
        def customerOrderInstance = CustomerOrder.get(params.id)
        if (customerOrderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (customerOrderInstance.version > version) {
                    
                    customerOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'customerOrder.label', default: 'CustomerOrder')] as Object[], "Another user has updated this CustomerOrder while you were editing")
                    render(view: "edit", model: [customerOrderInstance: customerOrderInstance])
                    return
                }
            }
            customerOrderInstance.properties = params
            if (!customerOrderInstance.hasErrors() && customerOrderInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), customerOrderInstance.id])}"
                redirect(action: "show", id: customerOrderInstance.id)
            }
            else {
                render(view: "edit", model: [customerOrderInstance: customerOrderInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def customerOrderInstance = CustomerOrder.get(params.id)
        if (customerOrderInstance) {
            try {
                customerOrderInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
            redirect(action: "list")
        }
    }

    def showTireInfo = {
		setCustomer()
		def tire = Tire.get(params.tireId)
		session["tire"] = tire
		
		render(view: "create", model: [tire: session["tire"], order: session["order"], orderLine: session["orderLineList"], tireList: session["tireList"]])
    }

    private setCustomer() {
		if(params.customerId)
			session["customer"] = Customer.get(params.customerId)
    }
    
    def addToOrder = {
			setCustomer()
			def order = session["order"]
			def orderLines = session["orderLines"]
			def tire = session["tire"]
			
			orderLines = addToOrderLine(params, tire, orderLines)
			
			writeSession(session, order, orderLines)
            render(view: "create", model: [tire: session["tire"], order: session["order"], orderLines: session["orderLines"]])
    }
		
	private addToOrderLine(params, tire, orderLines) {
		def customerOrderLine = new CustomerOrderLine()
		customerOrderLine.price = params.price.toDouble()
		customerOrderLine.numberOfReservedTires = params.numberOfReservedTires.toInteger()
		customerOrderLine.tire = tire
		
		orderLines << customerOrderLine
		return orderLines
	}
		
	private writeSession(session, order = session["order"], orderLines) {
		session["order"] = order
		session["orderLines"] = orderLines 
	}
		
	def deleteFromOrder = {
		def orderLines = session["orderLines"]
		
		int orderLineIndex = params.orderLineIndex.toInteger()
		orderLines.remove(orderLineIndex)
		
		writeSession(session, orderLines)
		render(view: "create", model: [order: session["order"], orderLines: session["orderLines"]])
	}
}