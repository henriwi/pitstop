package no.pstop.webapp;

import grails.test.*;
import java.util.Date;
import java.util.LinkedHashMap;

class TireOccurrenceControllerTests extends ControllerUnitTestCase {
	def tire, tireOccurrence
	
	protected void setUp() {
		super.setUp();
		tire = new Tire(width: 190, profile: 60, construction: "R", diameter: 17, partNr: "123AB",
				loadIndex: 165, speedIndex: "H", pattern: "m12", tireType: "Sommer", brand: "Nokian", tireName: "T-Zero", 
				retailPrice: 1095, notice:"Demodekk")
		mockDomain TireOccurrence
		tireOccurrence = new TireOccurrence(id:1,tire:tire,price:89.89,numberInStock:4,numberOfReserved:3,
				numberOfOrdered:8,discount:20,environmentalFee:10,registrationDate: new Date())
	}
	
	protected void tearDown() {
		super.tearDown();
	}
	
	private setParams(Tire tire, Double price, Integer numberInStock, Date registrationDate, Integer discount, 
	Integer environmentalFee) {
		controller.params.tire = tire
		controller.params.price = price
		controller.params.numberInStock = numberInStock
		controller.params.registrationDate = registrationDate
		controller.params.discount = discount
		controller.params.environmentalFee = environmentalFee
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testList(){
		def tireOccurrence2 = new TireOccurrence(id:2,tire:tire,price:65.5,numberInStock:2,registrationDate:new Date(),
				discount:25,environmentalFee:15)
		def tireOccurrenceList = [tireOccurrence, tireOccurrence2];
		mockDomain TireOccurrence, tireOccurrenceList
		
		def model = controller.list()
		assertEquals tireOccurrenceList, model.tireOccurrenceInstanceList
		assertEquals 2, model.tireOccurrenceInstanceTotal
	}
	
	void testCreate() {
		def model = controller.create()
		assertNotNull model.tireOccurrenceInstance
	}
	
	void testSaveWithValidTireOccurrence() {
		println "Valid"
		setParams(tire, 60.5, 1, new Date(), 20, 10)
		controller.metaClass.message = {args -> println "message: ${args}"}
		def mock = mockFor(TireOccurrence)
		mock.demand.merge() {tireOccurrence}
		controller.save()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testSaveWithInvalidTireOccurrence() {
		println "Invalid"
		setParams(tire, -10, 1, new Date(), 20, 10)
		controller.metaClass.message = {args -> println "message: ${args}"}
		tireOccurrence.price = -10
		controller.save()
		
		assertEquals "redirect action", "create", controller.modelAndView.viewName
		assertNotNull "TireOccurrence should not be null", controller.modelAndView.model.linkedHashMap.tireOccurrenceInstance
	}
	
	void testShowWithValidId() {
		mockDomain TireOccurrence, [tireOccurrence]
		controller.params.id = 1
		def model = controller.show()
		assertEquals tireOccurrence, model.tireOccurrenceInstance
	}
	
	void testShowWithInvalidId() {
		mockDomain TireOccurrence, [tireOccurrence]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain(TireOccurrence, [tireOccurrence])
		controller.params.id = 1
		Map model = controller.edit()
		assertEquals "expected Tire", tireOccurrence, model.tireOccurrenceInstance
	}
	
	void testEditWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testUpdateWithValidId() {
		mockDomain(TireOccurrence, [tireOccurrence])
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testUpdateWithValidIdButErrors() {
		mockDomain(TireOccurrence, [tireOccurrence])
		
		tireOccurrence.metaClass.hasErrors = {-> return true }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "edit", controller.modelAndView.viewName
		assertNotNull "TireOccurence should not be null", controller.modelAndView.model.linkedHashMap.tireOccurrenceInstance
	}
	
	void testUpdateWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithValidId() {
		mockDomain(TireOccurrence, [tireOccurrence])
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
}
