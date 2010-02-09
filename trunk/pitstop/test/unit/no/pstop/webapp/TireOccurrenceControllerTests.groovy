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
	

}
