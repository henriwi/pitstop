package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

@Secured(['ROLE_USER','ROLE_ADMIN'])
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
			flash.message = "${message(code: 'tireHotelOccurrence.no.occurrences.message')}";
		}
		[tireHotelOccurrenceInstanceList: tireHotelOccurrenceList, tireHotelOccurrenceInstanceTotal: tireHotelOccurrenceCount]
	}
	
	def create = {
		def tireHotelOccurrenceInstance = new TireHotelOccurrence()
		tireHotelOccurrenceInstance.properties = params
		return [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance]
	}
	
	def save = {
		def customer = Customer.get(params.addCustomerAutoComplete_id)
		def tireHotelOccurrenceInstance = new TireHotelOccurrence(tireLocation: params.tireLocation, registrationNumber: params.registrationNumber, 
				carType: params.carType, customer: customer, tireType: params.tireType, inDate: params.inDate, outDate: null, notice: params.notice)
		if(!tireHotelOccurrenceInstance.validate()){
			render(view: "create", model: [tireHotelOccurrenceInstance: tireHotelOccurrenceInstance])
		}
		else{
			tireHotelOccurrenceInstance = tireHotelOccurrenceInstance.merge(flush: true)
			flash.message = "${message(code: 'tireHotelOccurrence.created.message', args: [message(code: 'tireHotelOccurrence.label'), tireHotelOccurrenceInstance.tireLocation, tireHotelOccurrenceInstance.id])}"
			redirect(action: "show", id: tireHotelOccurrenceInstance.id)
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

		params.delivered ? tireHotelOccurrenceInstance.outDate = new Date() : null
		
		if (tireHotelOccurrenceInstance) {
			tireHotelOccurrenceInstance.properties = params
			if (!tireHotelOccurrenceInstance.hasErrors() && tireHotelOccurrenceInstance.save(flush: true)) {
				flash.message = "${message(code: 'tireHotelOccurrence.updated.message', args: [message(code: 'tireHotelOccurrence.label'), tireHotelOccurrenceInstance.tireLocation, tireHotelOccurrenceInstance.id])}"
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

	@Secured(['ROLE_ADMIN'])
	def delete = {
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		if (tireHotelOccurrenceInstance) {
			try {
				tireHotelOccurrenceInstance.delete(flush: true)
				flash.message = "${message(code: 'tireHotelOccurrence.deleted.message', args: [message(code: 'tireHotelOccurrence.label'), tireHotelOccurrenceInstance.tireLocation, tireHotelOccurrenceInstance.registrationNumber])}"
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
		println params 
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
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		def newTireHotelOccurrenceInstance = new TireHotelOccurrence(params)
		newTireHotelOccurrenceInstance.inDate = new Date()
		def customerInstance = Customer.get(params.customer.id)
		//newTireHotelOccurrenceInstance = newTireHotelOccurrenceInstance.merge(validate: false)

		if(newTireHotelOccurrenceInstance.merge(flush: true)){
			if(tireHotelOccurrenceInstance){
				tireHotelOccurrenceInstance.outDate = new Date()
				if(!tireHotelOccurrenceInstance.hasErrors() && tireHotelOccurrenceInstance.save(flush: true)){
					if(params.requestFromShowCustomerView){
						println tireHotelOccurrenceInstance.tireType
						println newTireHotelOccurrenceInstance.tireType
						flash.message = "${message(code: 'tireHotelOccurrence.changeSeason.message', args: [message(code: 'tireHotelOccurrence.label'), tireHotelOccurrenceInstance.tireLocation, tireHotelOccurrenceInstance.id, customerInstance.firstName, customerInstance.lastName, tireHotelOccurrenceInstance.tireType, newTireHotelOccurrenceInstance.tireType])}"
						redirect(controller: "customer", action: "show", id: customerInstance.id)
						
					}
					else{
						flash.message = "${message(code: 'tireHotelOccurrence.changeSeason.message', args: [message(code: 'tireHotelOccurrence.label'),tireHotelOccurrenceInstance.tireLocation, tireHotelOccurrenceInstance.id, customerInstance.firstName, customerInstance.lastName, tireHotelOccurrenceInstance.tireType, newTireHotelOccurrenceInstance.tireType])}"
						redirect(action: "list")//, id: newTireHotelOccurrenceInstance.id)
					}
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
	
	def deliverTireHotelOccurenceFromCustomerView = {
		def tireHotelOccurrenceInstance = TireHotelOccurrence.get(params.id)
		def customerInstance = Customer.get(params.customerId)
   
		params.delivered ? tireHotelOccurrenceInstance.outDate = new Date() : null
		
		if (tireHotelOccurrenceInstance) {
			tireHotelOccurrenceInstance.properties = params
			if (!tireHotelOccurrenceInstance.hasErrors() && tireHotelOccurrenceInstance.save(flush: true)) {
				flash.message = "${message(code: 'tireHotelOccurrence.deliver.message', args: [message(code: 'tireHotelOccurrence.label'), tireHotelOccurrenceInstance.tireLocation, tireHotelOccurrenceInstance.id, customerInstance.firstName, customerInstance.lastName])}"
				redirect(controller: "customer", action: "show", id: customerInstance.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurrence'), params.id])}"
			redirect(controller: "customer", action: "show", id: customerInstance.id)
		}
	}
}
