package no.pstop.webapp;

import grails.test.*;

class CustomerControllerTests extends ControllerUnitTestCase {
	def customer
	
	protected void setUp() {
		super.setUp();
		customer = new Customer(firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
				postalCode: "0195", city: "Radiator By", email: "felger@dekk.no", company: "Dekkilicious", notice: "God kunde")
		mockDomain Customer
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
		assertNotNull model.customerInstance
	}
}
