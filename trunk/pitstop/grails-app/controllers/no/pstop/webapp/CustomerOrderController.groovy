package no.pstop.webapp
import grails.converters.deep.JSON;

import java.util.Date;
import java.util.Iterator;

class CustomerOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def customerOrderService
		
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
		session["orderLineList"] = []
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
			customerOrderService.saveOrder(customerOrderInstance, session)
			redirect(action: "show", controller: "customerOrder", id: customerOrderInstance.id)
		}
		catch(result) {
			flash.message = "Kunne ikke lagre ordren."
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
			def orderLineList = session["orderLineList"]
			def tire = session["tire"]
			
			orderLineList = addToOrderLine(params, tire, orderLineList)
			
			writeSession(session, order, orderLineList)
            render(view: "create", model: [tire: session["tire"], order: session["order"], orderLine: session["orderLineList"]])
    }
		
	private addToOrderLine(params, tire, orderLineList) {
		def customerOrderLine = new CustomerOrderLine()
		customerOrderLine.price = params.price.toDouble()
		customerOrderLine.numberOfReservedTires = params.numberOfReservedTires.toInteger()
		customerOrderLine.tire = tire
		
		orderLineList << customerOrderLine
		return orderLineList
	}
		
	private writeSession(session, order = session["order"], orderLineList) {
		session["order"] = order
		session["orderLineList"] = orderLineList 
	}
		
	def deleteFromOrder = {
		def orderLineList = session["orderLineList"]
		
		removeFromOrderLine(params, orderLineList)
		
		writeSession(session, orderLineList)
		render(view: "create", model: [order: session["order"], orderLine: session["orderLineList"]])
	}

	private removeFromOrderLine(params, orderLineList) {
		int orderLineId = params.orderLineId.toInteger()
		int i = 0;
		for (Iterator iterator = orderLineList.iterator(); iterator.hasNext();) {
			def orderLine = iterator.next()
			if(i == orderLineId) {
				iterator.remove()
				break
			}
			i++
		}
	}
	
	def addEmptyTireOccurrence = {
		def order = session["order"]
		def tireList = session["tireList"]
		def orderLineList = session["orderLineList"]
		
		int numberOfReserved = params.numberOfReserved.toInteger()
		def tire = Tire.get(params.tireId)
		def tireOccurrence = new TireOccurrence(tire: tire, price: tire?.retailPrice, numberInStock: numberOfReserved, 
		numberOfReserved: numberOfReserved, registrationDate: new Date(), discount: 0, environmentalFee: 0, 
		inStock: false)
		tireOccurrence = tireOccurrence.merge(flush: true)

		params.numberOfOrdered = [numberOfReserved]
		params.price = [tireOccurrence?.price]
		params.tireOccurrenceId = [tireOccurrence?.id]
		
		orderLineList = addToOrderLine(1, params, session.order, session.orderLineList)
		tireList = updateTireListAndResetTireId(orderLineList, tireList, params)
		writeSession(session, order, tireList, orderLineList)
		render(view: "create", model: [order: session["order"], orderLine: session["orderLineList"], tireList: session["tireList"]])
	}
}
