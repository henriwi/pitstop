package no.pstop.webapp

class CustomerOrderLineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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
        return [customerOrderLineInstance: customerOrderLineInstance]
    }

    def save = {
        def customerOrderLineInstance = new CustomerOrderLine(params)
        if (customerOrderLineInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'customerOrderLine.label', default: 'CustomerOrderLine'), customerOrderLineInstance.id])}"
            redirect(action: "show", id: customerOrderLineInstance.id)
        }
        else {
            render(view: "create", model: [customerOrderLineInstance: customerOrderLineInstance])
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
