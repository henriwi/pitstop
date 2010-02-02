package no.pstop.webapp

class TireController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tireInstanceList: Tire.list(params), tireInstanceTotal: Tire.count()]
    }

    def create = {
        def tireInstance = new Tire()
        tireInstance.properties = params
        return [tireInstance: tireInstance]
    }

    def save = {
        def tireInstance = new Tire(params)
        if (tireInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'tire.label', default: 'Dekk'), tireInstance.partNr])}"
            redirect(action: "show", id: tireInstance.id)
        }
        else {
            render(view: "create", model: [tireInstance: tireInstance])
        }
    }

    def show = {
        def tireInstance = Tire.get(params.id)
        if (!tireInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.partNr])}"
            redirect(action: "list")
        }
        else {
            [tireInstance: tireInstance]
        }
    }

    def edit = {
        def tireInstance = Tire.get(params.id)
        if (!tireInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.partNr])}"
            redirect(action: "list")
        }
        else {
            return [tireInstance: tireInstance]
        }
    }

    def update = {
        def tireInstance = Tire.get(params.id)
        if (tireInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tireInstance.version > version) {
                    
                    tireInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tire.label', default: 'Dekk')] as Object[], "Another user has updated this Tire while you were editing")
                    render(view: "edit", model: [tireInstance: tireInstance])
                    return
                }
            }
            tireInstance.properties = params
            if (!tireInstance.hasErrors() && tireInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tire.label', default: 'Dekk'), tireInstance.partNr])}"
                redirect(action: "show", id: tireInstance.id)
            }
            else {
                render(view: "edit", model: [tireInstance: tireInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.partNr])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def tireInstance = Tire.get(params.id)
        if (tireInstance) {
            try {
                tireInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tire.label', default: 'Dekk'), params.partNr])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tire.label', default: 'Dekk'), params.partNr])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.partNr])}"
            redirect(action: "list")
        }
    }
}
