package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

@Secured(['ROLE_ADMIN','ROLE_USER'])                   
class TireOccurrenceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		if(TireOccurrence.count() == 0){
				flash.message = "Fant ingen dekk på lager."
		}
        [tireOccurrenceInstanceList: TireOccurrence.list(params), tireOccurrenceInstanceTotal: TireOccurrence.count()]
    }

    def create = {
        def tireOccurrenceInstance = new TireOccurrence()
        tireOccurrenceInstance.properties = params
        return [tireOccurrenceInstance: tireOccurrenceInstance]
    }

    def save = {
		def tireOccurrenceInstance = new TireOccurrence(params)
		if(!tireOccurrenceInstance.validate()){
			render(view: "create", model: [tireOccurrenceInstance: tireOccurrenceInstance])
		}
		else{
			tireOccurrenceInstance = tireOccurrenceInstance.merge(flush: true)
			flash.message = "${message(code: 'tireOccurrence.created.message', args: [message(code: 'tireOccurrence.label'), tireOccurrenceInstance.id])}"
			redirect(action: "show", id: tireOccurrenceInstance.id)
		}
    }

    def show = {
        def tireOccurrenceInstance = TireOccurrence.get(params.id)
        if (!tireOccurrenceInstance) {
            flash.message = "${message(code: 'tireOccurrence.not.found.message', args: [message(code: 'tireOccurrence.label', default: 'Dekkforekomst'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tireOccurrenceInstance: tireOccurrenceInstance]
        }
    }

    def edit = {
        def tireOccurrenceInstance = TireOccurrence.get(params.id)
        if (!tireOccurrenceInstance) {
            flash.message = "${message(code: 'tireOccurrence.not.found.message', args: [message(code: 'tireOccurrence.label', default: 'Dekkforekomst'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [tireOccurrenceInstance: tireOccurrenceInstance]
        }
    }

    def update = {
        def tireOccurrenceInstance = TireOccurrence.get(params.id)
        if (tireOccurrenceInstance) {
            tireOccurrenceInstance.properties = params
            if (!tireOccurrenceInstance.hasErrors() && tireOccurrenceInstance.save(flush: true)) {
                flash.message = "${message(code: 'tireOccurrence.updated.message', args: [message(code: 'tireOccurrence.label', default: 'Dekkforekomst'), tireOccurrenceInstance.tire])}"
                redirect(action: "show", id: tireOccurrenceInstance.id)
            }
            else {
                render(view: "edit", model: [tireOccurrenceInstance: tireOccurrenceInstance])
            }
        }
        else {
            flash.message = "${message(code: 'tireOccurrence.not.found.message', args: [message(code: 'tireOccurrence.label', default: 'Dekkforekomst'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(['ROLE_ADMIN'])
    def delete = {
        def tireOccurrenceInstance = TireOccurrence.get(params.id)
        if (tireOccurrenceInstance) {
            try {
                tireOccurrenceInstance.delete(flush: true)
                flash.message = "${message(code: 'tireOccurrence.deleted.message', args: [message(code: 'tireOccurrence.label', default: 'Dekkforekomst'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'tireOccurrence.not.deleted.message', args: [message(code: 'tireOccurrence.label', default: 'Dekkforekomst'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'tireOccurrence.not.found.message', args: [message(code: 'tireOccurrence.label', default: 'Dekkforekomst'), params.id])}"
            redirect(action: "list")
        }
    }
}
