package no.pstop.webapp

import java.util.Date;
import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

@Secured(['ROLE_ADMIN','ROLE_USER'])
class CustomerOrderLineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def customerOrderService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [customerOrderLineInstanceList: CustomerOrderLine.list(params), customerOrderLineInstanceTotal: CustomerOrderLine.count()]
    }

    def create = {
        def customerOrderLineInstance = new CustomerOrderLine()
        customerOrderLineInstance.properties = params
        def tireOccurrenceInstanceList = TireOccurrence.findAllByTire(Tire.get(params.tireId))
        return [customerOrderLineInstance: customerOrderLineInstance, tireOccurrenceInstanceList:tireOccurrenceInstanceList]
    }

    def save = {
		def customerOrderInstance = session["order"]
		customerOrderInstance.orderDate = new Date()
		customerOrderInstance.notice = ""
		
		def result = customerOrderService.saveOrder(customerOrderInstance, session)
		if(result) {
			redirect(action: "show", controller: "customerOrder", id: customerOrderInstance.id)
		}
		else {
			flash.message = "Kunne ikke lagre ordren."
			redirect(action: "create", controller: "customerOrder")
		}
    }

    def show = {
        def customerOrderLineInstance = CustomerOrderLine.get(params.id)
        if (!customerOrderLineInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), params.id])}"
            redirect(action: "list")
        }
        else {
            [customerOrderLineInstance: customerOrderLineInstance]
        }
    }

    def edit = {
        def customerOrderLineInstance = CustomerOrderLine.get(params.id)
        if (!customerOrderLineInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerOrderLineInstance: customerOrderLineInstance]
        }
    }

    def update = {
        def customerOrderLineInstance = CustomerOrderLine.get(params.id)
        if (customerOrderLineInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (customerOrderLineInstance.version > version) {
                    
                    customerOrderLineInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine')] as Object[], "Another user has updated this CustomerOrderLine while you were editing")
                    render(view: "edit", model: [customerOrderLineInstance: customerOrderLineInstance])
                    return
                }
            }
            customerOrderLineInstance.properties = params
            if (!customerOrderLineInstance.hasErrors() && customerOrderLineInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), customerOrderLineInstance.id])}"
                redirect(action: "show", id: customerOrderLineInstance.id)
            }
            else {
                render(view: "edit", model: [customerOrderLineInstance: customerOrderLineInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def customerOrderLineInstance = CustomerOrderLine.get(params.id)
        if (customerOrderLineInstance) {
            try {
                customerOrderLineInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), params.id])}"
            redirect(action: "list")
        }
    }
}