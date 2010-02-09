package no.pstop.webapp;

import grails.test.ControllerUnitTestCase;

class TireOccurrenceControllerTests extends ControllerUnitTestCase {

	protected void setUp() {
		super.setUp();
	}

	protected void tearDown() {
		super.tearDown();
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testCreate() {
		mockDomain TireOccurrence
		def model = controller.create()
		assertNotNull model.tireOccurrenceInstance
	}
	
	void testSaveWithValidTireOccurrence() {
		mockDomain TireOccurrence
		def tire = new Tire()
		
		controller.params.tire = tire
		controller.params.price = 60.5
		controller.params.numberInStock = 0
		controller.params.numberOfReserved = 0
		controller.params.numberOfOrdered = 0
		controller.params.registrationDate = new Date()
		controller.params.numberOfAvailable = 0
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()
		
		assertEquals('redirect action', "show", redirectArgs.action)
		assertEquals('redirect id', 1, controller.redirectArgs.id)
	}
	
	void testSaveWithInvalidTireOccurrence() {
		mockDomain TireOccurrence
		def tire = new Tire()
		
		controller.params.tire = tire
		//Unvalid price
		controller.params.price = -10
		controller.params.numberInStock = 0
		controller.params.registrationDate = new Date()
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()
		
		assertEquals('redirect action', "create", controller.modelAndView.view)
		assertNotNull('TireOccurrence should not be null', controller.modelAndView.model.tireOccurrenceInstance)
	}
	
	void testShowWithValidId() {
		def tire = new Tire()
		def tireOccurrence = new TireOccurrence(id:1,tire:tire,price:60.5,numberInStock:1,registrationDate:new Date())
		mockDomain TireOccurrence, [tireOccurrence]
		controller.params.id = 1
		def model = controller.show()
		assertEquals tireOccurrence, model.tireOccurrenceInstance
	}
	
	void testShowWithInvalidId() {
		def tire = new Tire()
		def tireOccurrence = new TireOccurrence(id:1,tire:tire,price:60.5,numberInStock:1,registrationDate:new Date())
		mockDomain TireOccurrence, [tireOccurrence]
		controller.params.id = 2
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		def tire = new Tire()
		def expectedTireOccurrence = new TireOccurrence(id:1,tire:tire,price:60.5,numberInStock:1,registrationDate:new Date())
		mockDomain(TireOccurrence, [expectedTireOccurrence])
		controller.params.id = 1
		Map model = controller.edit()
		assertEquals('expected Tire', expectedTireOccurrence, model.tireOccurrenceInstance)
	}
	
	void testEditWithInvalidId() {
		mockDomain(TireOccurrence)
		controller.params.id = 999 // no Tire with id 999 exists
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		assertEquals('redirect action', "list", redirectArgs.action)
	}
	
	void testUpdateWithValidId() {
		def tire = new Tire()
		def expectedTireOccurrence = new TireOccurrence(id:1,tire:tire,price:60.5,numberInStock:1,registrationDate:new Date())
		mockDomain(TireOccurrence, [expectedTireOccurrence])
		
		// mock out save and hasErrors behavior for happy path
		expectedTireOccurrence.metaClass.save = {-> return true }
		expectedTireOccurrence.metaClass.hasErrors = {-> return false }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals('redirect action', "show", redirectArgs.action)
		assertEquals('redirect id', 1, redirectArgs.id)
	}
	
	void testUpdateWithValidIdButErrors() {
		def tire = new Tire()
		def expectedTireOccurrence = new TireOccurrence(id:1,tire:tire,price:60.5,numberInStock:1,registrationDate:new Date())
		mockDomain(TireOccurrence, [expectedTireOccurrence])
		
		// mock out save and hasErrors behavior for happy path
		expectedTireOccurrence.metaClass.save = {-> return false }
		expectedTireOccurrence.metaClass.hasErrors = {-> return true }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals('redirect action', "edit", controller.modelAndView.view)
		assertNotNull('TireOccurence should not be null', controller.modelAndView.model.tireOccurrenceInstance)
	}
	
	void testUpdateWithInvalidId() {
		mockDomain(TireOccurrence)
		
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals('redirect action', "list", redirectArgs.action)
	}
	
	void testDeleteWithValidId() {
		def tire = new Tire()
		def tireOccurrence = new TireOccurrence(id:1,tire:tire,price:60.5,numberInStock:1,registrationDate:new Date())
		mockDomain(TireOccurrence, [tireOccurrence])
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		assertEquals('redirect action', "list", redirectArgs.action)
	}
	
	void testDeleteWithInvalidId() {
		mockDomain(TireOccurrence)
		controller.params.id = 999 // no object with id 999 exists
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		assertEquals('redirect action', "list", redirectArgs.action)
	}
}
