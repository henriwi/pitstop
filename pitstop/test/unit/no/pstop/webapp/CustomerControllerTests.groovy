package no.pstop.webapp;

import grails.test.*;

class CustomerControllerTests extends ControllerUnitTestCase {
	def c1
	
	protected void setUp() {
		super.setUp();
		mockDomain Customer
		
		c1 = new Customer(firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
				postalCode: "0195", city: "Radiator By", email: "felger@dekk.no", company: "Dekkilicious", notice: "God kunde")
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	private setParams(String firstName, String lastName, String phoneNumber, String address, String postalCode,
	String city, String email, String company, String notice) {
		controller.params.firstName = firstName
		controller.params.lastName = lastName
		controller.params.phoneNumber = phoneNumber
		controller.params.address = address
		controller.params.postalCode = postalCode
		controller.params.city = city
		controller.params.email = email
		controller.params.company = company
		controller.params.notice = notice
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testCreate() {
		def model = controller.create()
		assertNotNull model.customerInstance
	}
	
	void testSaveWithValidCustomer() {
		setParams("Per", "Hansen", "23749216", "Holbergsplass", "0623", "Oslo", "oslo@hio.no", "HIO", "ingen merknader")
		controller.metaClass.message = {args -> println "message: ${args}" } 
		controller.save()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testSaveWithInvalidEmail() {
		setParams("Per", "Hansen", "23749216", "Holbergsplass", "0623", "Oslo", "feilemailadresse.no", "HIO", "ingen merknader")
		controller.metaClass.message = {args -> println "message: ${args}" } 
		controller.save()
		
		assertEquals "redirect action", "create", controller.modelAndView.viewName
		assertNotNull "Customer should not be null", controller.modelAndView.model.linkedHashMap.customerInstance
	}
	
	void testShowWithValidId() {
		mockDomain Customer, [c1]
		controller.params.id = 1
		def model = controller.show()
		
		assertEquals c1, model.customerInstance
	}
	
	void testShowWithInvalidId() {
		mockDomain Customer, [c1]
		controller.params.id = 999
		controller.metaClass.message = { args -> println "message: ${args}" }
		controller.show()
		
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain Customer, [c1]
		controller.params.id = 1
		def model = controller.edit()
		
		assertEquals "model.customerInstance", c1, model.customerInstance
	}
	
	void testEditWithInvalidId() {
		mockDomain Customer, [c1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		
		assertEquals "redirect action", "list", redirectArgs.action
	}
	
	void testUpdateWithValidId() {
		mockDomain Customer, [c1]
		c1.metaClass.save = {-> return true }
		c1.metaClass.hasErrors = {-> return false }
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testUpdateWithValidIdButErrors() {
		mockDomain Customer, [c1]
		c1.metaClass.save = {-> return false }
		c1.metaClass.hasErrors = {-> return true }
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "edit", controller.modelAndView.viewName
		assertNotNull "Customer should not be null", controller.modelAndView.model.linkedHashMap.customerInstance
	}
	
	void testUpdateWithInvalidId() {
		mockDomain Customer, [c1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithValidId() {
		mockDomain Customer, [c1]
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}" }
		controller.delete()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithInvalidId() {
		mockDomain Customer, [c1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}" }
		controller.delete()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
}
