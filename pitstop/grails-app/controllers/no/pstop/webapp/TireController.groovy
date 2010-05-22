package no.pstop.webapp

import java.text.DecimalFormat;

import grails.converters.JSON

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

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
		
		if( params.deactive) {
			params.s = "false"
		}
		else  {
			params.s = "true"
		}
		
		if(!params.max)
		params.max = maxNumberOfTires
		
		if(!params.offset)
		params.offset = 0
		
		def tireList
		def tireCount
		
		if(isFastSearchQuery(params.q, params.type)) {
			if(isSpecialFastSearchQuery(params.q)) {
				def query = params.q =~ regexFastSearch
				tireList = 	Tire.fastSearch(query, params.max, params.offset ,params.s)
				tireCount = Tire.fastSearch(query, Tire.count(), 0, params.s).size()
			}
			else {
				tireList = Tire.search([max:params.max, offset:params.offset]){
					must(queryString("*" + params.q + "*"))
					must(term("enabled", params.s))
					}.results
				
				
				tireCount = Tire.search([max:Tire.count(), offset:params.offset]){
					must(queryString("*" + params.q + "*"))
					must(term("enabled", params.s))
				}.results.size()
				
			//	tireCount = Tire.search("*" + params.q + "*", [max:Tire.count(), offset:params.offset]).results.size()
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
			
			tireList = Tire.executeQuery("select distinct tire, tire.numberOfAvailable = (to.numberInStock - to.numberOfReserved) " +
					"from Tire tire left outer join tire.tireOccurrences to order by (to.numberInStock - to.numberOfReserved) " + params.order)
					
			tireCount = Tire.count()
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : maxNumberOfTires, 100)
			tireList = Tire.list(params)
			tireCount = Tire.count()
		}
		if(tireCount == 0){
			// TODO
			/*
			 * Ikke redirecte til search dersom det ikke er noen dekk på lager. Dette gjelder
			 * kun når man kommer fra list. Skal ikke gjelde dersom man søker og det ikke er
			 * noen dekk på lager.
			 */
			flash.message = "${message(code: 'tire.show.foundNoTireType.message')}"
			//redirect(action: "search")
		}
		checkIfParamsSisTrueOrFalse(params, tireList)
		
		[tireInstanceList: tireList, tireInstanceTotal: tireCount, radioButton: params.tireRadioButton]
	}
	private checkIfParamsSisTrueOrFalse(params, tireList) {
		def tire
		
		if(params.s == "false") {
			params.s = "false"
			for (Iterator iterator = tireList.iterator(); iterator.hasNext();) {
				tire = iterator.next()
				if(tire.enabled) {
					iterator.remove()
				}
			}
		}
		else {
			params.s = "true"
			for (Iterator iterator = tireList.iterator(); iterator.hasNext();) {
				tire = iterator.next()
				if(!tire.enabled) {
					iterator.remove()
				}
			}
		}
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
			flash.message = "${message(code: 'tire.created.message', args: [message(code: 'tire.label'), tireInstance.tireShowToString()])}"
			redirect(action: "show", id: tireInstance.id)
		}
		else {
			render(view: "create", model: [tireInstance: tireInstance])
		}
	}
	
	def show = {
		def tireInstance = Tire.get(params.id)
		if (!tireInstance) {
			flash.message = "${message(code: 'tire.not.found.message', args: [message(code: 'tire.label'), params.id])}"
			redirect(action: "list")
		}
		else {
			if(!params.max) {
				params.max = maxNumberOfTireOccurrences
			}
			if(!params.offset) {
				params.offset = 0
			}
			
			def supplierOrderLines = SupplierOrderLine.findAllByTireAndReceivedDateIsNull(tireInstance)
			def customerOrders = getPendingCustomerOrders(tireInstance) 
			
			[supplierOrderLines: supplierOrderLines, customerOrders: customerOrders, tireInstance: tireInstance]
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
				flash.message = "${message(code: 'tire.updated.message', args: [message(code: 'tire.label', default: 'Dekk'), tireInstance.tireShowToString()])}"
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
			redirect(action: "list", params: [q: params.txtFastSearch, type: 'fast'])
		}
		else{
			flash.message = "${message(code: 'search.missingSearchString.message')}"
			redirect(action: "search")
		}
	}
	
	//TODO Bør refaktureres slik at denne metoden slås sammen med fastSearch?
	def fastSearchForListView = {
		if(params.txtFastSearch.trim() != ""){
			redirect(action: "list", params:[q: params.txtFastSearch, type: 'fast', s: params.s, active: params.active, deactive: params.deactive])
		}
		else{
			redirect(action: "list", params:[q: params.search, s: params.s, active: params.active, deactive: params.deactive])
			
		}
	}
	
	def normalSearch = {
		redirect(action: "list", params:[width: params.width, profile: params.profile, diameter: params.diameter, speedIndex: params.speedIndex, tireType: params.tireType, brand: params.brand, type: 'normal', active: params.active, deactive: params.deactive ])
	}
	
	
	def disableAndEnable = {
		def tire = Tire.get(params.id)
		tire.enabled = tire.enabled ? false : true 
		redirect(action: "list")
	}
	
	def tireAutoComplete = {
		def tires
		
		if(isSpecialFastSearchQuery(params.query)) {
			def query = params.query =~ regexFastSearch
			tires = Tire.fastSearch(query, Tire.count(), 0, "false")
		}
		else {
			tires = Tire.search{
				queryString("*" + params.query + "*")
			}.results
		}
		
		tires = tires.collect {
			[name: it.toString(), highest: it.highestPrice(), id: it.id]
		}
		
		def jsonTires = [
			tires: tires
		]
		
		render jsonTires as JSON
		//def persons = Tire.list()//Tire.findAllByNameLike("%${params.query}%")
		
		//Create XML response 
		/*render(contentType: "text/xml") { 
			results() { 
				persons.each { 
					person -> result(){ 
						name(person.width) //Optional id which will be available in onItemSelect 
						id(person.id) 
						} 
					} 
				} 
			}*/ 
	}
	
	def pendingSupplierOrders = {
		def pendingSupplierOrders = pendingSupplierOrders()
		[supplierOrders: pendingSupplierOrders]
	}
	
	private pendingSupplierOrders() {
		def pendingSupplierOrdersList = []
		def supplierOrders = SupplierOrder.list().each { 
			boolean pending = false
			it.supplierOrderLines.each {
				if (!it.receivedDate) {
					pending = true
				}
			}
			if (pending) {
				pendingSupplierOrdersList << it
			}
		}
		return pendingSupplierOrdersList
	}
	
	private getPendingCustomerOrders(tire) {
		def customerOrderLines = CustomerOrderLine.findAllByTire(tire)
		def pendingCustomerOrders = []
		
		customerOrderLines?.customerOrder?.each { 
			if(!it.deliveredDate) {
				pendingCustomerOrders << it
			}
		}
		
		return pendingCustomerOrders
	}
	
	def saveNumberInStock = {
		def tireInstance = Tire.get(params.id)
		tireInstance?.numberInStock = params.numberInStock?.toInteger()
		tireInstance?.save(flush: true)
		render "Joa"
	}
	
	def getListPriceFromSelectedTire = {
		def formatter = new DecimalFormat("#.00");
		def tire = Tire.get(params.tireId)
		render formatter.format(tire?.retailPrice)
	}
	
	def getHighestPriceFromSelectedTire = {
		def formatter = new DecimalFormat("#.00");
		def tire = Tire.get(params.tireId)
		render formatter.format(tire?.highestPrice())
	}
	
	def getAveragePriceFromSelectedTire = {
		def formatter = new DecimalFormat("#.00");
		def tire = Tire.get(params.tireId)
		render formatter.format(tire?.averagePrice())
	}
}
