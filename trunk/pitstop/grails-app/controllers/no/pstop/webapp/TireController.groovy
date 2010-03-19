package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

@Secured(['ROLE_ADMIN','ROLE_USER'])
class TireController {
	static final regexFastSearch = /(\d{3})(\d{2})(\d{1})(s|v|S|V)/
	static final maxNumberOfTireOccurrences = 10
	static final maxNumberOfTires = 10
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		if(!params.max)
		params.max = maxNumberOfTires
		
		if(!params.offset)
		params.offset = 0
		
		def tireList
		def tireCount
		
		if(isFastSearchQuery(params.q, params.type)) {
			if(isSpecialFastSearchQuery(params.q)) {
				def query = params.q =~ regexFastSearch
				tireList = 	Tire.fastSearch(query, params.max, params.offset)
				tireCount = Tire.fastSearch(query, Tire.count(), 0).size()
			}
			else {
				tireList = Tire.search("*" + params.q + "*", [max:params.max, offset:params.offset], escape: true).results
				tireCount = Tire.search("*" + params.q + "*", [max:Tire.count(), offset:params.offset], escape: true).results.size()
			}
		} 
		else if(isNormalSearchQuery(params.type) && !isNormalSearchWithoutInput()) {
			tireList = Tire.normalSearch(params.width, params.profile, params.diameter, 
			params.speedIndex, params.tireType, , params.brand, params.max.toInteger(), params.offset.toInteger())
			
			tireCount = Tire.normalSearch(params.width, params.profile, params.diameter, 
			params.speedIndex, params.tireType, , params.brand, Tire.count(), 0).size()
		}
		else if(params.sort == "numberOfAvailable"){
			params.max = Math.min(params.max ? params.int('max') : maxNumberOfTires, 100)
			
			tireList = Tire.executeQuery("select  distinct tire, tire.numberOfAvailable = (to.numberInStock - to.numberOfReserved) " +
					"from Tire tire left outer join tire.tireOccurrences to order by (to.numberInStock - to.numberOfReserved)  " + params.order)
					
			tireCount = Tire.count()
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : maxNumberOfTires, 100)
			tireList = Tire.list(params)
			tireCount = Tire.count()
		}
		if(tireCount == 0){
			flash.message = "${message(code: 'tire.show.foundNoTireType.message')}"
			redirect(action: "search")
		}

		
		[tireInstanceList: tireList, tireInstanceTotal: tireCount]
	}
	
	private isFastSearchQuery(String query, String type){
		query && type.equals("fast")
	}
	
	private isSpecialFastSearchQuery(String query){
		query ==~ regexFastSearch
	}
	
	private isNormalSearchQuery(String type){
		type == 'normal'
	}
	
	private isNormalSearchWithoutInput(){
		if(params.width == "" &&
		params.profile == "" &&
		params.diameter == "" &&
		(params.speedIndex == "" || params.speedIndex == "Alle") &&
		(params.tireType == "" || params.tireType == "Alle") &&
		params.brand == "")
			return true
		else return false
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
			if(!params.max)
			params.max = maxNumberOfTireOccurrences
			if(!params.offset)
			params.offset = 0
			def tireOccurrenceInstanceList = TireOccurrence.findAllByTire(Tire.get(params.id), [max:params.max, offset:params.offset, sort:"registrationDate", order:"desc"])
			def tireOccurrenceInstanceTotalList = TireOccurrence.findAllByTire(Tire.get(params.id))
			[tireOccurrenceInstanceList: tireOccurrenceInstanceList,tireInstance: tireInstance, tireOccurrenceInstanceTotalList: tireOccurrenceInstanceTotalList]
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
	@Secured(['ROLE_ADMIN'])     
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
		if(params.txtFastSearch.trim() != ""){
			redirect(action: "list", params:[q: params.txtFastSearch, type: 'fast'])
		}
		else{
			flash.message = "${message(code: 'search.missingSearchString.message')}"
			redirect(action: "search")
		}
	}
	
	def normalSearch = {
		redirect(action: "list", params:[width: params.width, profile: params.profile, diameter: params.diameter, speedIndex: params.speedIndex, tireType: params.tireType, brand: params.brand, type: 'normal'])
	}
}
