package no.pstop.webapp

import grails.converters.JSON;

import java.util.Date;

class SupplierOrderController {
	def orderService
	def logService
	static final regexFastSearch = /(\d{3})(\d{2})(\d{1})(s|v|S|V)/
	static final maxNumberOfSupplierOrders = 50

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : maxNumberOfSupplierOrders, 100)
				
		if(!params.sort) {
			params.sort = "id"
			params.order = "desc"
		}
				
        [supplierOrderInstanceList: SupplierOrder.list(params), supplierOrderInstanceTotal: SupplierOrder.count()]
    }

    def create = {
		session["order"] = new SupplierOrder()
		session["orderLines"] = []
    }

    def save = {
		setOrderValues()
		def supplierOrderInstance = session["order"]
        supplierOrderInstance?.orderDate = new Date()
		
		println "validte fra test: " + supplierOrderInstance.validate()
		supplierOrderInstance.errors.each {println it }
		
		if(!supplierOrderInstance.validate() || session["orderLines"]?.size() == 0) {
			if(session["orderLines"]?.size() == 0) {
				supplierOrderInstance.errors.reject('supplierOrder.supplierOrderLine.empty.error')
			}
			render(view: "create", model:[order: supplierOrderInstance])
		}
		else {
			try {
				orderService.saveSupplierOrder(supplierOrderInstance, session)	
				flash.message = "${message(code: 'supplierOrder.created.message', args:[supplierOrderInstance?.id])}"
				redirect(action: "pendingSupplierOrders")
			}
			catch(result) {
				flash.message = "${message(code: 'supplierOrder.exception.error')}"
				redirect(action: "create")
			}
		}
    }

    def show = {
        def supplierOrderInstance = SupplierOrder.get(params.id)
        if (!supplierOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), params.id])}"
            redirect(action: "list")
        }
        else {
            [supplierOrderInstance: supplierOrderInstance]
        }
    }

    def delete = {
        def supplierOrderInstance = SupplierOrder.get(params.id)
        if (supplierOrderInstance) {
            try {
                supplierOrderInstance.delete(flush: true)
                render(view: "deleteSupplierOrderConfirmation")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
				supplierOrderInstance.errors.reject('supplierOrder.delete.error.message')
                render(view: "show", model: [supplierOrderInstance: supplierOrderInstance])
            }
        }
        else {
			supplierOrderInstance.errors.reject('supplierOrder.delete.error.message')
			render(view: "show", model: [supplierOrderInstance: supplierOrderInstance])
        }
    }
	
	def addToOrder = {
		setOrderValues()
    	def orderLines = session["orderLines"]
		def tire = Tire.get(params.tire_id)
		
		def orderLine = new SupplierOrderLine(tire: tire, price: params.price, discount: params.discount, 
		environmentalFee: params.environmentalFee, numberOfOrderedTires: params.numberOfOrderedTires, 
		numberOfReceivedTires: 0)
		
		def errorOrderLine
		if(isValidOrderLine(orderLine)) {
			orderLines << orderLine
		}
		else {
			errorOrderLine = createErrorOrderLine(errorOrderLine, tire, params)
		}
		
		session["orderLines"] = orderLines
		render(view: "create", model:[orderLines: orderLines, order: session["order"], errorOrderLine: errorOrderLine])
	}
	
	private isValidOrderLine(orderLine) {
		orderLine.validate() || orderLine.errors.getFieldErrorCount() == 1
	}
	
	private createErrorOrderLine(errorOrderLine, tire, params) {
		errorOrderLine = new SupplierOrderLine(tire: tire, price: params.price, discount: params.discount, 
		environmentalFee: params.environmentalFee, numberOfOrderedTires: params.numberOfOrderedTires, 
		numberOfReceivedTires: 0)
		
		errorOrderLine.validate()
		return errorOrderLine
	}
	
    private setOrderValues() {
		session["order"]?.supplier = params.supplier
		session["order"]?.notice = params.notice
    }
	
	def deleteFromOrder = {
    	def orderLines = session["orderLines"]
			
        int orderLineIndex = params._action_deleteFromOrder.trim().toInteger()
		orderLines.remove(orderLineIndex)
		
		session["orderLines"] = orderLines
		render(view: "create", model:[orderLines: orderLines, order: session["order"]])
	}
	
	def receiveOrder = {
		def supplierOrder = SupplierOrder.get(params.id)
		supplierOrder.supplierOrderLines.each {
			if(!it.receivedDate) {
				params.numberOfReceived = it.numberOfOrderedTires - it.numberOfReceivedTires	
				receiveOrderLine(it, params)
			}
		}
		
		logService.saveLog(session, "${message(code: 'supplierOrder.log.received.message', args: [supplierOrder?.id])}")
		render(view:"receiveOrderConfirmation")
	}
	
	def receiveOrderLine = {
		def supplierOrderLineInstance = SupplierOrderLine.get(params.supplierOrderLineId)
		receiveOrderLine(supplierOrderLineInstance, params)
        flash.message = "${message(code: 'supplierOrder.orderLine.received.message')}"
		redirect(controller: "tire", action: "show", id: supplierOrderLineInstance?.tire?.id)
	}
	
	private receiveOrderLine(supplierOrderLineInstance, params) {
		def tire = supplierOrderLineInstance?.tire
		
		int numberOfReceived = params.numberOfReceived.toInteger()
		supplierOrderLineInstance?.numberOfReceivedTires += numberOfReceived
		tire?.numberInStock += numberOfReceived
		
		if(supplierOrderLineInstance?.numberOfOrderedTires == supplierOrderLineInstance?.numberOfReceivedTires) {
			supplierOrderLineInstance?.receivedDate = new Date()
		}
		
		supplierOrderLineInstance.save(flush: true)
		supplierOrderLineInstance.errors.each {
		}
	}
	
	private isSpecialFastSearchQuery(String query) {
		query ==~ regexFastSearch
	}
	
	def pendingSupplierOrders = {
		def pendingSupplierOrders = pendingSupplierOrders(params)
		[supplierOrders: pendingSupplierOrders]
	}
	
	private pendingSupplierOrders(params) {
		def pendingSupplierOrdersList = []
		def supplierOrders = SupplierOrder.list(params).each { 
			boolean pending = false
			it.supplierOrderLines.each {
				if (!it.receivedDate) {
					pending = true
				}
			}
			if (pending) {
				pendingSupplierOrdersList << it
			}
		}
		return pendingSupplierOrdersList
	}
}
