package no.pstop.webapp

class TireController {
	static final regexFastSearch = /(\d{3})(\d{2})(\d{1})(s|v|S|V)/
	static final numberOfTireOccurrences = 7
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		def tireList
		def tireCount
		if(isFastSearchQuery(params.q)) {
			if(isSpecialFastSearchQuery(params.q)) {
				def query = params.q =~ regexFastSearch
				tireList = 	Tire.fastSearch(query)
				tireCount =  tireList.count()
			}
			else {
				tireList = Tire.search("*" + params.q + "*").results
				tireCount =  tireList.count()
			}
		} 
		else if(isNormalSearchQuery(params.type)) {
			if(isNormalSearchWithoutInput()) {
				tireList = Tire.search("*").results
			}
			else{
				tireList = Tire.normalSearch(params.width, params.profile, params.speedIndex, params.tireType, params.brand)
			}
			tireCount =  tireList.count()
		}
		else {
			tireList = Tire.list(params)
			tireCount =  tireList.count()
		}
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[tireInstanceList: tireList, tireInstanceTotal: tireCount]
	}
	
	private isFastSearchQuery(String query){
		query && params.type == 'fast'
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
		//params.speedIndex != "" &&
		//params.tireType != "" &&
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
				params.max = numberOfTireOccurrences
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
	
	def normalSearch = {
		redirect(action: "list", params:[width: params.width, profile: params.profile, speedIndex: params.speedIndex, tireType: params.tireType, brand: params.brand, type: 'normal'])
	}
}
