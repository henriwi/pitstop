package no.pstop.webapp

class SupplierOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [supplierOrderInstanceList: SupplierOrder.list(params), supplierOrderInstanceTotal: SupplierOrder.count()]
    }

    def create = {
        def supplierOrderInstance = new SupplierOrder()
        supplierOrderInstance.properties = params
        return [supplierOrderInstance: supplierOrderInstance]
    }

    def save = {
        def supplierOrderInstance = new SupplierOrder(params)
        if (supplierOrderInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'supplierOrder.label', default: 'SupplierOrder'), supplierOrderInstance.id])}"
            redirect(action: "show", id: supplierOrderInstance.id)
        }
        else {
            render(view: "create", model: [supplierOrderInstance: supplierOrderInstance])
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
}
