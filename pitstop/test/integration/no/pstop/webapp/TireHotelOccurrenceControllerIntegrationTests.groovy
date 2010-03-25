package no.pstop.webapp
import java.util.Date;
import groovy.util.GroovyTestCase;
import grails.test.*

class TireHotelOccurrenceControllerIntegrationTests extends GroovyTestCase {
	TireHotelOccurrence tireHotelOccurrence1, tireHotelOccurrence2, tireHotelOccurrence3
	Customer customer
	def controller
	
    protected void setUp() {
        super.setUp()

        customer = new Customer(firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
		postalCode: "0195", city: "Radiator By", email: "felger@dekk.no", company: "Dekkilicious", notice: "God kunde").save(flush: true)

		tireHotelOccurrence1 = new TireHotelOccurrence(tireLocation: "1A", registrationNumber: "DE 832154", carType: "Audi A3", 
		customer: customer, tireType: "Sommer", inDate: new Date(), outDate: new Date(), notice: "ingen").save(flush: true)
		tireHotelOccurrence2 = new TireHotelOccurrence(tireLocation: "2A", registrationNumber: "DF 123456", carType: "Opel", 
		customer: customer, tireType: "Vinter (pigg)", inDate: new Date(), outDate: null, notice: "Bra dekk").save(flush: true)
		tireHotelOccurrence3 = new TireHotelOccurrence(tireLocation: "3B", registrationNumber: "BR 168043", carType: "Mercedes", 
		customer: customer, tireType: "Sommer", inDate: new Date(), outDate: null, notice: "").save(flush: true)
		
		controller = new TireHotelOccurrenceController()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testListWithSearchQuery() {
		controller.params.q = "Sommer"
		def expectedList = [tireHotelOccurrence3]
		def model = controller.list()
			
		assertEquals "Expected list should be the same as the returned", expectedList.toString(), model.tireHotelOccurrenceInstanceList.toString()
		assertEquals "Number of expected should be the same as returned", expectedList.size(), model.tireHotelOccurrenceInstanceTotal
    }
	
	void testListWithoutSearchQuery() {
		def expectedList = [tireHotelOccurrence2, tireHotelOccurrence3]
		def model = controller.list()
		
		assertEquals "Expected list should be the same as the returned", expectedList.toString(), model.tireHotelOccurrenceInstanceList.toString()
		assertEquals "Number of expected should be the same as returned", expectedList.size(), model.tireHotelOccurrenceInstanceTotal
	}
}
