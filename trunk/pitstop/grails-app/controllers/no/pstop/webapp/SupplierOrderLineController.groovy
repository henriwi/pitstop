package no.pstop.webapp

class SupplierOrderLineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [supplierOrderLineInstanceList: SupplierOrderLine.list(params), supplierOrderLineInstanceTotal: SupplierOrderLine.count()]
    }

    def create = {
        def supplierOrderLineInstance = new SupplierOrderLine()
        supplierOrderLineInstance.properties = params
        return [supplierOrderLineInstance: supplierOrderLineInstance]
    }

    def save = {
        def supplierOrderLineInstance = new SupplierOrderLine(params)
        if (supplierOrderLineInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), supplierOrderLineInstance.id])}"
            redirect(action: "show", id: supplierOrderLineInstance.id)
        }
        else {
            render(view: "create", model: [supplierOrderLineInstance: supplierOrderLineInstance])
        }
    }

    def show = {
        def supplierOrderLineInstance = SupplierOrderLine.get(params.id)
        if (!supplierOrderLineInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), params.id])}"
            redirect(action: "list")
        }
        else {
            [supplierOrderLineInstance: supplierOrderLineInstance]
        }
    }

    def edit = {
        def supplierOrderLineInstance = SupplierOrderLine.get(params.id)
        if (!supplierOrderLineInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [supplierOrderLineInstance: supplierOrderLineInstance]
        }
    }

    def update = {
        def supplierOrderLineInstance = SupplierOrderLine.get(params.id)
        if (supplierOrderLineInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (supplierOrderLineInstance.version > version) {
                    
                    supplierOrderLineInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine')] as Object[], "Another user has updated this SupplierOrderLine while you were editing")
                    render(view: "edit", model: [supplierOrderLineInstance: supplierOrderLineInstance])
                    return
                }
            }
            supplierOrderLineInstance.properties = params
            if (!supplierOrderLineInstance.hasErrors() && supplierOrderLineInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), supplierOrderLineInstance.id])}"
                redirect(action: "show", id: supplierOrderLineInstance.id)
            }
            else {
                render(view: "edit", model: [supplierOrderLineInstance: supplierOrderLineInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def supplierOrderLineInstance = SupplierOrderLine.get(params.id)
        if (supplierOrderLineInstance) {
            try {
                supplierOrderLineInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine'), params.id])}"
            redirect(action: "list")
        }
    }
}
