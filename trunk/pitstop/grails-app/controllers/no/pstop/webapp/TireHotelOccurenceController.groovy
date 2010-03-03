package no.pstop.webapp

class TireHotelOccurenceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tireHotelOccurenceInstanceList: TireHotelOccurence.list(params), tireHotelOccurenceInstanceTotal: TireHotelOccurence.count()]
    }

    def create = {
        def tireHotelOccurenceInstance = new TireHotelOccurence()
        tireHotelOccurenceInstance.properties = params
        return [tireHotelOccurenceInstance: tireHotelOccurenceInstance]
    }

    def save = {
        def tireHotelOccurenceInstance = new TireHotelOccurence(params)
        if (tireHotelOccurenceInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), tireHotelOccurenceInstance.id])}"
            redirect(action: "show", id: tireHotelOccurenceInstance.id)
        }
        else {
            render(view: "create", model: [tireHotelOccurenceInstance: tireHotelOccurenceInstance])
        }
    }

    def show = {
        def tireHotelOccurenceInstance = TireHotelOccurence.get(params.id)
        if (!tireHotelOccurenceInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tireHotelOccurenceInstance: tireHotelOccurenceInstance]
        }
    }

    def edit = {
        def tireHotelOccurenceInstance = TireHotelOccurence.get(params.id)
        if (!tireHotelOccurenceInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [tireHotelOccurenceInstance: tireHotelOccurenceInstance]
        }
    }

    def update = {
        def tireHotelOccurenceInstance = TireHotelOccurence.get(params.id)
        if (tireHotelOccurenceInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tireHotelOccurenceInstance.version > version) {
                    
                    tireHotelOccurenceInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence')] as Object[], "Another user has updated this TireHotelOccurence while you were editing")
                    render(view: "edit", model: [tireHotelOccurenceInstance: tireHotelOccurenceInstance])
                    return
                }
            }
            tireHotelOccurenceInstance.properties = params
            if (!tireHotelOccurenceInstance.hasErrors() && tireHotelOccurenceInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), tireHotelOccurenceInstance.id])}"
                redirect(action: "show", id: tireHotelOccurenceInstance.id)
            }
            else {
                render(view: "edit", model: [tireHotelOccurenceInstance: tireHotelOccurenceInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def tireHotelOccurenceInstance = TireHotelOccurence.get(params.id)
        if (tireHotelOccurenceInstance) {
            try {
                tireHotelOccurenceInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence'), params.id])}"
            redirect(action: "list")
        }
    }
}
