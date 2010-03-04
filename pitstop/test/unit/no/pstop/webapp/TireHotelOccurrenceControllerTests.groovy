package no.pstop.webapp

import java.util.Date;

import org.springframework.ui.Model;
import grails.test.*

class TireHotelOccurrenceControllerTests extends ControllerUnitTestCase {
	def customer, tireHotelOccurrence
	
    protected void setUp() {
        super.setUp()
		customer = new Customer(firstName:"Jan Roar", lastName:"Hansen",phoneNumber:"99887766", address:"Vollensvingen 2", postalCode:"0899",
				city:"Vollen", email:"roar@gmail.com", company:"StoreDekk", notice:"En god betaler" )
		mockDomain TireHotelOccurrence
		tireHotelOccurrence = new TireHotelOccurrence(tireLocation:"a1", registrationNumber:"DA12345", carType:"Audi Allround 3.0T", 
				customer:customer, tireType: "Sommer", inDate:new Date(), outDate:new Date()+100, notice:"sam" )
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
		setParams("1a", "DE12345", "Audi", customer, "Sommer", new Date(), new Date() + 100, "Notice")
		controller.metaClass.message = {args -> println "message: ${args}"}
		controller.save()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "Redirect id", 1, controller.redirectArgs.id
	}
	
	void testSaveWithInvalidTireHotelOccurrence(){
		setParams("a1", "DE12345", "?", customer, "Sommer", new Date(), new Date() + 100, "Notice")
		controller.metaClass.message = {args -> println "message: ${args}"}
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
	
	/*void testUpdateWithValidId(){
		mockDomain TireHotelOccurrence, [tireHotelOccurrence]
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "Redirect id", 1, controller.redirectArgs.id
	}*/
	
}
