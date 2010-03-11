package no.pstop.webapp;

import grails.test.*;

class CustomerControllerTests extends ControllerUnitTestCase {
	def customer1
	
	protected void setUp() {
		super.setUp();
		mockDomain Customer
		
		customer1 = new Customer(firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
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
	
	void testList() {
		def customer2 = new Customer(firstName: "Dekk Bernt", lastName: "Dekkesen", phoneNumber: "23555095", address: "Dekkveien 2",
				postalCode: "0194", city: "Radiator By", email: "felger@dekk.com", company: "Dekkilicious", notice: "God kunde")
		def customerList = [customer1, customer2];
		mockDomain Customer, customerList
		
		def model = controller.list()
		assertEquals customerList, model.customerInstanceList
		assertEquals 2, model.customerInstanceTotal
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
		def tireHotelOccurrence1 = new TireHotelOccurrence(customer: customer1, tireLocation: 1, registrationNumber: "DB12345", inDate: new Date())
		def tireHotelOccurrence2 = new TireHotelOccurrence(customer: customer1, tireLocation: 2, registrationNumber: "DB54321", inDate: new Date())
		
		def tireHotelOccurrenceList = [tireHotelOccurrence1, tireHotelOccurrence2]
		def tireHotelOccurrenceTotalList = [tireHotelOccurrence1, tireHotelOccurrence2]
		
		mockDomain Customer, [customer1]
		mockDomain TireHotelOccurrence, [tireHotelOccurrence1, tireHotelOccurrence2]
		
		controller.params.id = 1
		def model = controller.show()
		assertEquals c1, model.customerInstance
		assertEquals "tireHotelOccurrenceList should e equal", tireHotelOccurrenceList, model.tireHotelOccurrenceInstanceList
		assertEquals "tireHotelOccurrenceTotalList should e equal", tireHotelOccurrenceTotalList, model.tireHotelOccurrenceInstanceTotalList
	}
	
	void testShowWithInvalidId() {
		mockDomain Customer, [customer1]
		controller.params.id = 999
		controller.metaClass.message = { args -> println "message: ${args}" }
		controller.show()
		
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain Customer, [customer1]
		controller.params.id = 1
		def model = controller.edit()
		
		assertEquals "model.customerInstance", customer1, model.customerInstance
	}
	
	void testEditWithInvalidId() {
		mockDomain Customer, [customer1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		
		assertEquals "redirect action", "list", redirectArgs.action
	}
	
	void testUpdateWithValidId() {
		mockDomain Customer, [customer1]
		customer1.metaClass.save = {-> return true }
		customer1.metaClass.hasErrors = {-> return false }
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testUpdateWithValidIdButErrors() {
		mockDomain Customer, [customer1]
		customer1.metaClass.save = {-> return false }
		customer1.metaClass.hasErrors = {-> return true }
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "edit", controller.modelAndView.viewName
		assertNotNull "Customer should not be null", controller.modelAndView.model.linkedHashMap.customerInstance
	}
	
	void testUpdateWithInvalidId() {
		mockDomain Customer, [customer1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithValidId() {
		mockDomain Customer, [customer1]
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}" }
		controller.delete()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithInvalidId() {
		mockDomain Customer, [customer1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}" }
		controller.delete()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testSearch() {
		controller.params.search = "Dekkesen"
		controller.search()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
		assertEquals "query params should be equal", controller.params.search, controller.redirectArgs.params.q
	}
}
