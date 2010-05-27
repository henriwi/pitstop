package no.pstop.webapp

import java.text.DecimalFormat;

import grails.converters.JSON

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN','ROLE_USER'])
class TireController {
	static final regexFastSearch = /(\d{3})(\d{2})(\d{1})(s|v|S|V)/
	static final maxNumberOfTires = 50
	def logService
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		setMaxAndOffsetParams(params)
		
		def tireList
		def tireCount
		
		if(isFastSearchQuery(params.q, params.type)) {
			if(isSpecialFastSearchQuery(params.q)) {
				def query = params.q =~ regexFastSearch
				tireList = 	Tire.fastSearch(query, params.max, params.offset ,params.s)
				tireCount = Tire.fastSearch(query, Tire.count(), 0, params.s).size()
				
				flash.message = "${message(code: 'customer.search.result', args: [message(code: 'tire.label'), params.q])}"
							}
			else {
				tireList = performFastSearch(params)
				tireCount = performFastSearchCount(params)
				flash.message = "${message(code: 'customer.search.result', args: [message(code: 'tire.label'), params.q])}"
				
			}
		} 
		else if(isNormalSearchQuery(params.type) && !isNormalSearchWithoutInput()) {
			tireList = performNormalSearch(params)
			tireCount = performNormalSearchCount(params)
			flash.message = "${message(code: 'tire.show.NormalSearch.message')}"
						
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : maxNumberOfTires, 100)
			tireList = Tire.createCriteria().list(params) {
				eq('enabled', (params.s && params.s == "false") ? false : true)
			}
			tireCount = Tire.count()
		}
		if(tireCount == 0){
			flash.message = "${message(code: 'tire.show.foundNoTireType.message')}"
		}
		
		[tireInstanceList: tireList, tireInstanceTotal: tireCount]
	}

	private setMaxAndOffsetParams(params) {
		if(!params.max)
			params.max = maxNumberOfTires
		
		if(!params.offset)
			params.offset = 0
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
	
	private performFastSearch(params) {
		Tire.search([max:params.max, offset:params.offset]){
			must(queryString("*" + params.q + "*"))
			must(term("enabled", params.s))
		}.results

	}
	
	private performFastSearchCount(params) {
		Tire.search([max:Tire.count(), offset:params.offset]){
			must(queryString("*" + params.q + "*"))
			must(term("enabled", params.s))
		}.results.size()
	}
	
	private performNormalSearch(params) {
		println params
		Tire.normalSearch(params.width, params.profile, params.diameter, 
			params.speedIndex, params.tireType, , params.brand, params.s, params.int('max'), params.int('offset'))
	}
	
	private performNormalSearchCount(params) {
		Tire.normalSearch(params.width, params.profile, params.diameter, 
			params.speedIndex, params.tireType, , params.brand, params.s, Tire.count(), 0).size()
	}
	
	def search = {
		def tireInstance = new Tire()
		tireInstance.properties = params
		return [tireInstance: tireInstance]
	}
	
	def fastSearch = {
		redirect(action: "list", params: [q: params.txtFastSearch, type: 'fast', s: "true"])
	}
	
	def normalSearch = {
		redirect(action: "list", params:[type: 'normal', s: (params.deactive) ? "false" : "true", width: params.width, profile: params.profile, diameter: params.diameter, speedIndex: params.speedIndex, tireType: params.tireType, brand: params.brand])
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
				logService.saveLog(session, "${message(code: 'log.tire.edited.message', args: [tireInstance])}")
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
	
	def disableAndEnable = {
		def tire = Tire.get(params.id)
		tire.enabled = tire.enabled ? false : true 
		redirect(action: "list")
	}
	
	def disableAndEnableForShow = {
		def tire = Tire.get(params.id)
		tire.enabled = tire.enabled ? false : true 
		redirect(action: "show", id: params.id)
	}
	
	def tireAutoComplete = {
		def tires
		
		if(isSpecialFastSearchQuery(params.query)) {
			def query = params.query =~ regexFastSearch
			tires = Tire.fastSearch(query, Tire.count(), 0, "true")
		}
		else {
			tires = Tire.search{
				queryString("*" + params.query + "*")
			}.results
		}
		
		tires = tires.collect {
			[id: it.id, name: it.toString()]
		}
		
		def jsonTires = [
			tires: tires
		]
		
		render jsonTires as JSON
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
	
	def getListPriceFromSelectedTire = {
		def formatter = new DecimalFormat("#.##");
		def tire = Tire.get(params.tireId)
		render formatter.format(tire?.retailPrice)
	}
	
	def getHighestPriceFromSelectedTire = {
		def formatter = new DecimalFormat("#.##");
		def tire = Tire.get(params.tireId)
		render formatter.format(tire?.highestPrice())
	}
	
	def getAveragePriceFromSelectedTire = {
		def formatter = new DecimalFormat("#.##");
		def tire = Tire.get(params.tireId)
		render formatter.format(tire?.averagePrice())
	}
}
