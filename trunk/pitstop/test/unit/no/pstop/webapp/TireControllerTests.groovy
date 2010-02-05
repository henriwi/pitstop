package no.pstop.webapp

import grails.test.*

class TireControllerTests extends ControllerUnitTestCase {
	protected void setUp() {
		super.setUp()
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}

	void testCreate() {
		mockDomain Tire
		def model = controller.create()
		//assertEquals new Tire(), model.tireInstance
	}
	
	void testShowWithValidId() {
		def tire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		mockDomain Tire, [tire]
		controller.params.id = 1
		def model = controller.show()
		assertEquals tire, model.tireInstance
	}
	
	void testShowWithInvalidId() {
		def tire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		mockDomain Tire, [tire]
		controller.params.id = 2
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testSave() {
		
	}
}
