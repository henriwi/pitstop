package no.pstop.webapp

class TireController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		def tireList
		def tireCount
		if(params.q && params.type == 'fast') {
			if(params.q ==~ /\d{6}[s|v|S|V]/){
				def query = params.q =~ /(\d{3})(\d{2})(\d{1})(s|v|S|V)/
				
				tireList = Tire.search()
				{
					must(term('width', query[0][1]))
					must(term('profile', query[0][2]))
					must(wildcard('diameter', "*" + query[0][3]))
					must(prefix('tireType', query[0][4].toString().toLowerCase()))
				}.results
			
				tireCount = Tire.count()
			}
			else
			{
				tireList = Tire.search("*" + params.q + "*").results
				tireCount = Tire.count()
			}
		} 
		else {
			tireList = Tire.list(params)
			tireCount = Tire.count()
		}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tireInstanceList: tireList, tireInstanceTotal: tireCount]
    }

    def create = {
        def tireInstance = new Tire()
        tireInstance.properties = params
        return [tireInstance: tireInstance]
    }

    def save = {
        def tireInstance = new Tire(params)
        if (tireInstance.save(flush: true)) {
            flash.message = "${message(code: 'tire.created.message', args: [message(code: 'tire.label', default: 'Dekk'), tireInstance.partNr])}"
            redirect(action: "show", id: tireInstance.id)
        }
        else {
            render(view: "create", model: [tireInstance: tireInstance])
        }
    }

    def show = {
        def tireInstance = Tire.get(params.id)
        if (!tireInstance) {
            flash.message = "${message(code: 'tire.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.id])}"
            redirect(action: "list")
        }
        else {
			def tireOccurrenceInstanceList = TireOccurrence.findAllByTire(Tire.get(params.id))
			[tireOccurrenceInstanceList: tireOccurrenceInstanceList,tireInstance: tireInstance]
        }
    }

    def edit = {
        def tireInstance = Tire.get(params.id)
        if (!tireInstance) {
            flash.message = "${message(code: 'tire.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.partNr])}"
            redirect(action: "list")
        }
        else {
			return [tireInstance: tireInstance]
        }
    }

    def update = {
        def tireInstance = Tire.get(params.id)
        if (tireInstance) {
            tireInstance.properties = params
            if (!tireInstance.hasErrors() && tireInstance.save(flush: true)) {
                flash.message = "${message(code: 'tire.updated.message', args: [message(code: 'tire.label', default: 'Dekk'), tireInstance.partNr])}"
                redirect(action: "show", id: tireInstance.id)
            }
            else {
                render(view: "edit", model: [tireInstance: tireInstance])
            }
        }
        else {
            flash.message = "${message(code: 'tire.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def tireInstance = Tire.get(params.id)
        if (tireInstance) {
            try {
                tireInstance.delete(flush: true)
                flash.message = "${message(code: 'tire.deleted.message', args: [message(code: 'tire.label', default: 'Dekk'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'tire.not.deleted.message', args: [message(code: 'tire.label', default: 'Dekk'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'tire.not.found.message', args: [message(code: 'tire.label', default: 'Dekk'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def search = {
		def tireInstance = new Tire()
		tireInstance.properties = params
		return [tireInstance: tireInstance]
	}
	
	def fastSearch = {
		redirect(action: "list", params:[q: params.txtFastSearch, type: 'fast'])
	}
}
