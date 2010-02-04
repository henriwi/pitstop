package no.pstop.webapp

import grails.test.*

class TireControllerTests extends ControllerUnitTestCase {
	protected void setUp() {
		super.setUp()
		controller
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testIndexRedirect() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testCreate(){
		//mockController TireController
	}
}
