package no.pstop.webapp

import java.util.Date;

import org.springframework.ui.Model;
import grails.test.*

class TireHotelOccurrenceControllerTests extends ControllerUnitTestCase {
	def customer, tireHotelOccurrence
	
    protected void setUp() {
        super.setUp()
		mockDomain Customer
		customer = new Customer(firstName:"Jan Roar", lastName:"Hansen",phoneNumber:"99887766", address:"Vollensvingen 2", postalCode:"0899",
				city:"Vollen", email:"roar@gmail.com", company:"StoreDekk", notice:"En god betaler" )
		mockDomain TireHotelOccurrence
		tireHotelOccurrence = new TireHotelOccurrence(id:1,tireLocation:"1a", registrationNumber:"DE12345", carType:"Audi", 
				customer:customer, tireType: "Sommer", inDate:new Date(), outDate:new Date() + 100, notice:"Notice" )
    }
	
	private setParams(String tireLocation, String registrationNumber, String carType, Customer customer, String tireType, Date inDate, Date outDate, String notice){
		controller.params.tireLocation = tireLocation
		controller.params.registrationNumber = registrationNumber
		controller.params.carType = carType
		controller.params.customer = customer
		controller.params.tireType = tireType
		controller.params.inDate = inDate
		controller.params.outDate = outDate
		controller.params.notice = notice
	}
	
    protected void tearDown() {
        super.tearDown()
    }

	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testCreate() {
		def model = controller.create()
		assertNotNull model.tireHotelOccurrenceInstance
	}
	
	void testSaveWithValidTireHotelOccurrence(){
		setParams("1a", "DE12345", "Audi", null, "Sommer", new Date(), new Date() + 100, "Notice")
		mockDomain Customer, [customer]
		controller.params.customerId = 1
		controller.metaClass.message = {args -> println "message: ${args}"}
		def mock = mockFor(TireHotelOccurrence)
		mock.demand.merge() {tireHotelOccurrence}
		controller.save()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "Redirect id", 1, controller.redirectArgs.id
	}
	
	void testSaveWithInvalidTireHotelOccurrence(){
		setParams("a1", "DE12345", "?", null, "Sommer", new Date(), new Date() + 100, "Notice")
		controller.params.customerId = 999
		controller.metaClass.message = {args -> println "message: ${args}"}
		tireHotelOccurrence.carType = "?"
		controller.save()
		
		assertEquals "render action", "create", controller.modelAndView.viewName
		assertNotNull "TireHotelOccurrence should not be null", controller.modelAndView.model.linkedHashMap.tireHotelOccurrenceInstance
	}
	
	void testShowWithValidId() {
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		controller.params.id = 1
		def model = controller.show()
		assertEquals tireHotelOccurrence, model.tireHotelOccurrenceInstance
	}
	
	void testShowWithInvalidId() {
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		controller.params.id = 1
		def model = controller.edit()
		assertEquals tireHotelOccurrence, model.tireHotelOccurrenceInstance
	}
	
	void testEditWithInvalidId() {
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testUpdateWithValidIdButErrors(){
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		tireHotelOccurrence.metaClass.hasErrors = {-> return true }
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "render action", "edit", controller.modelAndView.viewName
		assertNotNull "TireHotelOccurrence should not be null", controller.modelAndView.model.linkedHashMap.tireHotelOccurrenceInstance
	}
	
	void testUpdateWithValidId() {
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]

		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testUpdateWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testUpdateWithDeliveryParam() {
		tireHotelOccurrence.outDate = null
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		controller.params.id = 1
		controller.params.delivered = "abc"
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertNotNull "Date should not be null", tireHotelOccurrence.outDate
	}
	
	void testDeleteWithValidId() {
		mockDomain(TireHotelOccurrence, [tireHotelOccurrence])
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testSearch() {
		controller.params.search = "Sommer"
		controller.search()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
		assertEquals "query params should be equal", controller.params.search, controller.redirectArgs.params.q
	}
	
	void testChangeWithValidId(){
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		controller.params.id = 1
		def model = controller.change()
		assertEquals "returned model should be as expected", tireHotelOccurrence, model.tireHotelOccurrenceInstance
	}
	
	void testChangeWithInvalidId(){
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"}
		controller.change()
		assertEquals "redirect action", "list", controller.redirectArgs.action 
	}
	
	/*
	void testUpdateChangeWithValidParams(){
		setParams "1a", "DE12345", "Audi", customer, "Vinter (pigg)", null, null, "Notice"
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		
		def newTireHotelOccurrence = new TireHotelOccurrence(tireLocation:"1a", registrationNumber:"DE12345", carType:"Audi", 
				customer:customer, tireType: "Vinter (pigg)", inDate:new Date(), outDate:null, notice:"Notice")
		
		def mock = mockFor(TireHotelOccurrence)
		mock.demand.merge() {newTireHotelOccurrence}
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"}
		
		controller.updateChange()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "Id should be the same", 2, controller.redirectArgs.id
	}
	*/
	
	void testUpdateChangeWithValidParamsButErrors(){
		setParams "1a", "DE12345", "Audi", customer, "Vinter (pigg)", null, null, "Notice"
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		
		def newTireHotelOccurrence = new TireHotelOccurrence(tireLocation:"1a", registrationNumber:"DE12345", carType:"Audi", 
		customer:customer, tireType: "Vinter (pigg)", inDate:new Date(), outDate:null, notice:"Notice")
		
		def mock = mockFor(TireHotelOccurrence)
		mock.demand.merge() {newTireHotelOccurrence}
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"}
		tireHotelOccurrence.metaClass.hasErrors = {-> return true}
		
		controller.updateChange()
		
		assertEquals "render action", "edit", controller.modelAndView.viewName
		assertNotNull "TireHotelOccurrence should not be null", controller.modelAndView.model.linkedHashMap.tireHotelOccurrenceInstance
	}
	
	void testUpdateChangeWithInvalidId(){
		setParams "1a", "DE12345", "Audi", customer, "Vinter (pigg)", null, null, "Notice"
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		
		def newTireHotelOccurrence = new TireHotelOccurrence(tireLocation:"1a", registrationNumber:"DE12345", carType:"Audi", 
		customer:customer, tireType: "Vinter (pigg)", inDate:new Date(), outDate:null, notice:"Notice")
		
		def mock = mockFor(TireHotelOccurrence)
		mock.demand.merge() {newTireHotelOccurrence}
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"}
		
		controller.updateChange()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	/*
	void testUpdateChangeWithValidIdButInvalidParams(){
		setParams "1a", "DE12345", "?", customer, "?", null, null, "Notice"
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		
		def newTireHotelOccurrence = new TireHotelOccurrence(tireLocation:"1a", registrationNumber:"DE12345", carType:"?", 
		customer:customer, tireType: "Sommer", inDate:new Date(), outDate:null, notice:"Notice")
		
		def mock = mockFor(TireHotelOccurrence)
		mock.demand.merge() {newTireHotelOccurrence}
		controller.params.id = 1
		
		controller.updateChange()
		
		assertEquals "render action", "edit", controller.modelAndView.viewName
		assertNotNull "TireHotelOccurrence should not be null", controller.modelAndView.model.linkedHashMap.tireHotelOccurrenceInstance
	}
	*/
}
