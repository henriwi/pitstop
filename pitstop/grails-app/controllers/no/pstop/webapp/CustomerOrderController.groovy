package no.pstop.webapp

import java.util.Date;
import java.util.Iterator;
import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class CustomerOrderController {
	static final maxNumberOfCustomerOrders = 50
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def orderService
	def logService
		
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		params.max = Math.min(params.max ? params.int('max') : maxNumberOfCustomerOrders, 100)
		
		if(!params.sort) {
			params.sort = "id"
			params.order = "desc"
		}
				
        [customerOrderInstanceList: CustomerOrder.list(params), customerOrderInstanceTotal: CustomerOrder.count()]
    }

    def create = {
		session["order"] = new CustomerOrder()
		session["order"]?.customer = Customer.get(params.id)
		session["orderLines"] = []
		return [order: session["order"]]
    }

    def save = {
    	def customer = session["order"]?.customer
		def customerOrderInstance = session["order"]
		customerOrderInstance.orderDate = new Date()
		customerOrderInstance.customer = customer
		
		if(!customerOrderInstance.validate() || session["orderLines"]?.size() == 0) {
			if(session["orderLines"]?.size() == 0) {
				customerOrderInstance.errors.reject('customerOrder.supplierOrderLine.empty.error')
			}
			render(view: "create", model:[order: customerOrderInstance])
		}
		else {
			try {
				orderService.saveCustomerOrder(customerOrderInstance, session)
				flash.message = "${message(code: 'customerOrder.created.message', args: [customerOrderInstance?.id])}"
				redirect(action: "show", controller: "customer", id: customer?.id)
			}
			catch(result) {
				flash.message = "${message(code: 'customerOrder.exception.error')}"
				redirect(action: "create")
			}
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

	@Secured(['ROLE_ADMIN'])
    def delete = {
        def customerOrderInstance = CustomerOrder.get(params.id)
        if (customerOrderInstance) {
            try {
                customerOrderInstance.delete(flush: true)
				if(params.requestFromShowCustomerView) {
					flash.message = "${message(code: 'customerorder.deleted.message', args: [params.id])}"
					redirect(controller: "customer", action: "show", id: params.customerId)
				}
				else if(params.requestFromModalBox) {
					render(view: "deleteCustomerOrderConfirmation")
				}
				else {
					flash.message = "${message(code: 'customerorder.deleted.message', args: [params.id])}"
					redirect(action: "list")
				}
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'customerOrder.not.found.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), params.id])}"
            redirect(action: "list")
        }
    }

    private setNoticeAndCustomer() {
		session["order"]?.notice = params.notice
		if(!session["order"]?.customer) {
			session["order"]?.customer = Customer.get(params.customer_id)
		}
    }
    
    def addToOrder = {
		setNoticeAndCustomer()
		
		def order = session["order"]
		def orderLines = session["orderLines"]
		def tire = Tire.get(params.tire_id)

		def customerOrderLine = new CustomerOrderLine(price: params.price, 
		numberOfReservedTires: params.numberOfReservedTires, tire: tire)

		def errorOrderLine
		if(isValidOrderLine(customerOrderLine)) {
			orderLines << customerOrderLine
		}
		else {
			errorOrderLine = createErrorOrderLine(errorOrderLine, tire, params)
		}
		
		writeSession(session, order, orderLines)
        render(view: "create", model: [order: session["order"], orderLines: session["orderLines"], errorOrderLine: errorOrderLine])
    }
		
	private isValidOrderLine(customerOrderLine) {
		customerOrderLine.validate() || customerOrderLine.errors.getFieldErrorCount() == 1
	}
	
	private createErrorOrderLine(errorOrderLine, tire, params) {
		errorOrderLine = new CustomerOrderLine(price: params.price, 
		numberOfReservedTires: params.numberOfReservedTires, tire: tire)
		errorOrderLine.validate()
		return errorOrderLine
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
		performOrderDelivery(order)

		logService.saveLog(session, "${message(code: 'customerOrder.log.received.message', args: [order?.id])}")
		
		flash.message = "${message(code: 'customerOrder.delivered.message', args: [params.id])}"
		redirect(controller: "customer", action: "show", id: order?.customer?.id)
	}
	
	def deliverOrderFromModalbox = {
		def order = CustomerOrder.get(params.id)
		performOrderDelivery(order)

		logService.saveLog(session, "${message(code: 'customerOrder.log.received.message', args: [order?.id])}")
		
		render(view:"deliverOrderConfirmation")
	}
	
	private performOrderDelivery(order) {
		order?.deliveredDate = new Date()
		order?.customerOrderLines.each {
			it.tire.numberInStock -= it.numberOfReservedTires
		}
	}
	
	def pendingCustomerOrders = {
		def customerOrderWithoutDeliveredDate = CustomerOrder.findAllByDeliveredDateIsNull()
		[customerOrderWithoutDeliveredDateInstanceList: customerOrderWithoutDeliveredDate]
	}
}
