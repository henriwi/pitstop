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
		session["order"]?.customer = Customer.get(params.id)
		session["orderLines"] = []
		return [order: session["order"]]
    }

    def save = {
    	def customer = session["order"]?.customer
    	println params
		println customer
		def customerOrderInstance = session["order"]
		customerOrderInstance.orderDate = new Date()
		customerOrderInstance.customer = customer
		
		try {
			orderService.saveCustomerOrder(customerOrderInstance, session)
			redirect(action: "show", controller: "customer", id: customer?.id)
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
		setCustomerAndNotice()
		def tire = Tire.get(params.tireId)
		session["tire"] = tire
		
		render(view: "create", model: [tire: session["tire"], order: session["order"], orderLines: session["orderLines"], tireList: session["tireList"]])
    }

    private setCustomerAndNotice() {
		//if(params.customerId) {
			session["customer"] = Customer.get(params.customerId)
		//}
		//println params
		//if(params.notice) 
			session["order"]?.notice = params.notice
		//
    }
    
    def addToOrder = {
		setCustomerAndNotice()
		def order = session["order"]
		def orderLines = session["orderLines"]
		println params
		def tire = Tire.get(params.tire_id)
		
		orderLines = addToOrderLine(params, tire, orderLines)
		
		writeSession(session, order, orderLines)
        render(view: "create", model: [tire: session["tire"], order: session["order"], orderLines: session["orderLines"]])
    }
		
	private addToOrderLine(params, tire, orderLines) {
		def customerOrderLine = new CustomerOrderLine(price: params.price, 
		numberOfReservedTires: params.numberOfReservedTires, tire: tire)
		
		//if(customerOrderLine.validate()) {
			orderLines << customerOrderLine
		//}
		
		return orderLines
	}
		
	private writeSession(session, order = session["order"], orderLines) {
		session["order"] = order
		session["orderLines"] = orderLines 
	}
		
	def deleteFromOrder = {
		def orderLines = session["orderLines"]
		
		int orderLineIndex = params._action_deleteFromOrder.trim().toInteger()
		orderLines.remove(orderLineIndex)
		
		writeSession(session, orderLines)
		render(view: "create", model: [order: session["order"], orderLines: session["orderLines"]])
	}
	
	def deliverOrder = {
		def order = CustomerOrder.get(params.id)
		order.customerOrderLines.each {
			if(!it.deliveredDate) {
				it.deliveredDate = new Date()
			}
		}
		redirect(controller: "customer", action: "show", id:1)
	}
	
	def deliverOrderLine = {
		def orderLine = CustomerOrderLine.get(params.id)
		orderLine.deliveredDate = new Date()
		redirect(controller: "customer", action: "show", id:1)
	}
}
