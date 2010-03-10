package no.pstop.webapp

class TireHotelOccurrenceController {
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		def tireHotelOccurrenceList
		def tireHotelOccurrenceCount
		
		if(params.q){
			tireHotelOccurrenceList = TireHotelOccurrence.search("*" + params.q + "*", escape: true).results
			tireHotelOccurrenceCount = tireHotelOccurrenceList.size()
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			tireHotelOccurrenceList = TireHotelOccurrence.list(params)
			tireHotelOccurrenceCount = TireHotelOccurrence.count()
		}
		if(tireHotelOccurrenceCount == 0){
			flash.message = "Fant ingen dekktyper."
		}
		[tireHotelOccurrenceInstanceList: tireHotelOccurrenceList, tireHotelOccurrenceInstanceTotal: tireHotelOccurrenceCount]
	}
	
	def create = {
		def tireHotelOccurrenceInstance = new TireHotelOccurrence()
		tireHotelOccurrenceInstance.properties = params
		return [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance]
	}
	
	def save = {
		def tireHotelOccurrenceInstance = new TireHotelOccurrence(params)
		tireHotelOccurrenceInstance = tireHotelOccurrenceInstance.merge()
		if (tireHotelOccurrenceInstance.save(flush: true)) {
			flash.message = "${message(code: 'tireHotelOccurrence.created.message', args: [message(code: 'tireHotelOccurrence.label'), tireHotelOccurrenceInstance.id])}"
			redirect(action: "show", id: tireHotelOccurrenceInstance.id)
		}
		else {
			render(view: "create", model: [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance])
		}
	}
	
	def show = {
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		if (!tireHotelOccurrenceInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), params.id])}"
			redirect(action: "list")
		}
		else {
			[tireHotelOccurrenceInstance: tireHotelOccurrenceInstance]
		}
	}
	
	def edit = {
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		if (!tireHotelOccurrenceInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance]
		}
	}
	
	def update = {
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		if (tireHotelOccurrenceInstance) {
			tireHotelOccurrenceInstance.properties = params
			if (!tireHotelOccurrenceInstance.hasErrors() && tireHotelOccurrenceInstance.save(flush: true)) {
				flash.message = "${message(code: 'tireHotelOccurrence.updated.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), tireHotelOccurrenceInstance.id])}"
				redirect(action: "show", id: tireHotelOccurrenceInstance.id)
			}
			else {
				render(view: "edit", model: [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), params.id])}"
			redirect(action: "list")
		}
	}
	
	def delete = {
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		if (tireHotelOccurrenceInstance) {
			try {
				tireHotelOccurrenceInstance.delete(flush: true)
				flash.message = "${message(code: 'tireHotelOccurrence.deleted.message', args: [message(code: 'tireHotelOccurrence.label'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'tireHotelOccurrence.not.deleted.message', args: [message(code: 'tireHotelOccurrence.label'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), params.id])}"
			redirect(action: "list")
		}
	}
	
	def search = {
		redirect(action: "list", params:[q: params.search])
	}
	
	def change = {
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		if (!tireHotelOccurrenceInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance]
		}
	}
	
	def updateChange = {
		def newTireHotelOccurrenceInstance = new TireHotelOccurrence(params)
		newTireHotelOccurrenceInstance.inDate = new Date()
		newTireHotelOccurrenceInstance = newTireHotelOccurrenceInstance.merge()
		
		if(!newTireHotelOccurrenceInstance.hasErrors() && newTireHotelOccurrenceInstance.save(flush: true)){
			def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
			if(tireHotelOccurrenceInstance){
				tireHotelOccurrenceInstance.outDate = new Date()
				if(!tireHotelOccurrenceInstance.hasErrors() && tireHotelOccurrenceInstance.save(flush: true)){
					flash.message = "${message(code: 'tireHotelOccurrence.updateChange.message', args: [message(code: 'tireHotelOccurrence.label'), params.id])}"
					redirect(action: "show", id: newTireHotelOccurrenceInstance.id)
				}
				else{
					render(view: "edit", model: [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance])
				}
			}
			else{
				flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), params.id])}"
				redirect(action: "list")
			}
		}
		else{
			render(view: "edit", model: [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance])
		}
	}
}
