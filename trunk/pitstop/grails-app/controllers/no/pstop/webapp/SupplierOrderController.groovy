package no.pstop.webapp

import java.util.Date;

class SupplierOrderController {
	def orderService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [supplierOrderInstanceList: SupplierOrder.list(params), supplierOrderInstanceTotal: SupplierOrder.count()]
    }

    def create = {
		session["order"] = new SupplierOrder()
		session["orderLines"] = []
    }

    def save = {
		def supplierOrderInstance = session["order"]
        supplierOrderInstance?.orderDate = new Date()
		
		try {
			orderService.saveSupplierOrder(supplierOrderInstance, session)
			redirect(action: "show", id: supplierOrderInstance.id)
		}
		catch(result) {
			flash.message = "Kunne ikke lagre ordren." + result
			redirect(action: "create")
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

    def edit = {
        def supplierOrderInstance = SupplierOrder.get(params.id)
        if (!supplierOrderInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [supplierOrderInstance: supplierOrderInstance]
        }
    }

    def update = {
        def supplierOrderInstance = SupplierOrder.get(params.id)
        if (supplierOrderInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (supplierOrderInstance.version > version) {
                    
                    supplierOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'supplierOrder.label', default: 'SupplierOrder')] as Object[], "Another user has updated this SupplierOrder while you were editing")
                    render(view: "edit", model: [supplierOrderInstance: supplierOrderInstance])
                    return
                }
            }
            supplierOrderInstance.properties = params
            if (!supplierOrderInstance.hasErrors() && supplierOrderInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), supplierOrderInstance.id])}"
                redirect(action: "show", id: supplierOrderInstance.id)
            }
            else {
                render(view: "edit", model: [supplierOrderInstance: supplierOrderInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def supplierOrderInstance = SupplierOrder.get(params.id)
        if (supplierOrderInstance) {
            try {
                supplierOrderInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def addToOrder = {
		setOrderValues()
    	def orderLines = session["orderLines"]
		def tire = Tire.get(params.tireId)
		
		def orderLine = new SupplierOrderLine(tire: tire, price: params.price, discount: params.discount, 
		environmentalFee: params.environmentalFee, numberOfOrderedTires: params.numberOfOrderedTires)
		
		orderLines << orderLine
		session["orderLines"] = orderLines
		render(view: "create", model:[orderLines: orderLines, order: session["order"]])
	}

    private setOrderValues() {
    	session["order"]?.orderNumber = params.orderNumber
		session["order"]?.supplier = params.supplier
		session["order"]?.notice = params.notice
    }
	
	def deleteFromOrder = {
    	def orderLines = session["orderLines"]
			
        int orderLineIndex = params.orderLineIndex.toInteger()
		orderLines.remove(orderLineIndex)
		
		session["orderLines"] = orderLines
		render(view: "create", model:[orderLines: orderLines, order: session["order"]])
	}
	
	def recieveOrder = {
		def supplierOrderLineInstance = SupplierOrderLine.get(params.supplierOrderLineId)
		def tire = supplierOrderLineInstance?.tire
		
		int numberOfRecieved = params.numberOfRecieved.toInteger()
		supplierOrderLineInstance?.numberOfOrderedTires -= numberOfRecieved
		tire?.numberInStock += numberOfRecieved
		
		if(supplierOrderLineInstance?.numberOfOrderedTires == 0) {
			supplierOrderLineInstance?.receivedDate = new Date()
		}
		
		supplierOrderLineInstance.save(flush: true)
		redirect(controller: "tire", action: "show", id: tire?.id)
	}
}
