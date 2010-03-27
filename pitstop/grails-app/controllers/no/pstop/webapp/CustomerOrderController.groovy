package no.pstop.webapp
import java.util.Iterator;
class CustomerOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		def customerOrderList
		def customerOrderCount
		
		if(params.q){
			customerOrderList = CustomerOrder.search("*" + params.q + "*", escape: true).results
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
		session["order"] = new CustomerOrder(orderDate: new Date())
		session["orderLineList"] = []
		session["tireList"] = Tire.list()
		session["customer"] = new Customer()
		
		return [tireList: session["tireList"]]
    }

    def save = {
		def customerOrderInstance = new CustomerOrder(params)
		
		if(!customerOrderInstance.validate()) {
			render(view: "create", model: [customerOrderInstance: customerOrderInstance])
		}
		else {
			customerOrderInstance = customerOrderInstance.merge(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'customerOrder.label', default: 'CustomerOrder'), customerOrderInstance.id])}"
            redirect(action: "show", id: customerOrderInstance.id)
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

    def showTireOccurrences = {
		setCustomer()
		render(view: "create", model: [order: session["order"], orderLine: session["orderLineList"], tireList: session["tireList"]])
    }

    private setCustomer() {
    	session["order"]?.customer = Customer.get(params.customerId)
    }
    
    def addToOrder = {
			setCustomer()
			def order = session["order"]
			def tireList = session["tireList"]
			def orderLineList = session["orderLineList"]
			
			int numberOfTireOccurrences = params.numberOfTireOccurrences?.toInteger()
			orderLineList = addToOrderLine(numberOfTireOccurrences, params, order, orderLineList)
			
			tireList = updateTireListAndResetTireId(orderLineList, tireList, params)
			
			writeSession(session, order, tireList, orderLineList)
            render(view: "create", model: [order: session["order"], orderLine: session["orderLineList"], tireList: session["tireList"]])
    }
		
	private updateTireListAndResetTireId(orderLineList, tireList, params) {
		if(orderLineList) {
			def tireListId = orderLineList?.tireOccurrence?.tire?.id
			tireList = Tire.findAllByIdNotInList(tireListId)
		}
		else {
			tireList = Tire.list()
		}
		params.tireId = 0
		return tireList
	}
		
	private writeSession(session, order = session["order"], tireList, orderLineList) {
		session["order"] = order
		session["tireList"] = tireList 
		session["orderLineList"] = orderLineList 
	}
		
	private addToOrderLine(int numberOfTireOccurrences, params, order, orderLineList) {
		for (int i = 0; i < numberOfTireOccurrences; i++) {
			if (params.numberOfOrdered[i]?.toInteger() > 0/* && params.price[i] != ""*/) {
				def customerOrderLine = new CustomerOrderLine()
				customerOrderLine.tireOccurrence = TireOccurrence.get(params.tireOccurrenceId[i])
				customerOrderLine.customerOrder = order
				customerOrderLine.numberOfOrderedTireOccurrences = Integer.parseInt(params.numberOfOrdered[i])
				customerOrderLine.price = Double.parseDouble(params.price[i])
				customerOrderLine.deliveryDate = new Date()
				orderLineList << customerOrderLine
			}
		}
		return orderLineList
	}
	
	def deleteFromOrder = {
		def orderLineList = session["orderLineList"]
		def tireList = session["tireList"]
		
		def tireOccurrence = TireOccurrence.get(params.removeTireOccurrenceId)
		
		removeFromOrderLine(orderLineList, tireOccurrence)
		
		tireList = updateTireListAndResetTireId(orderLineList, tireList, params)
		
		writeSession(session, tireList, orderLineList)
		render(view: "create", model: [order: session["order"], orderLine: session["orderLineList"], tireList: session["tireList"]])
	}
	
	private removeFromOrderLine(orderLineList, tireOccurrence) {
		for (Iterator iterator = orderLineList.iterator(); iterator.hasNext();) {
			def orderLine = iterator.next()
			if(orderLine?.tireOccurrence?.id == tireOccurrence?.id)
				iterator.remove()
		}
	}
}
