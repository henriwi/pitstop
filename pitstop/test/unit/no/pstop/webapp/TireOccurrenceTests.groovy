package no.pstop.webapp

import java.text.SimpleDateFormat
import grails.test.*

class TireOccurrenceTests extends GrailsUnitTestCase {
	def tireOccurrence
	def dateFormat
	
    protected void setUp() {
        super.setUp()
			
		mockForConstraintsTests TireOccurrence
		tireOccurrence = new TireOccurrence(tire:new Tire(),price:89.89,numberInStock:4,numberOfReserved:3,
				numberOfOrdered:8,discount:20,environmentalFee:10,registrationDate: new Date())
		dateFormat = new SimpleDateFormat("dd.MM.yyyy")
    }

    protected void tearDown() {
        super.tearDown()
    }	
	
	void testGenerateTireOccurrence() {
		tireOccurrence.registrationDate = dateFormat.parse("10.01.2008")
		
		assertEquals 89.89, tireOccurrence.price
		assertEquals 4, tireOccurrence.numberInStock
		assertEquals 3, tireOccurrence.numberOfReserved
		assertEquals 8, tireOccurrence.numberOfOrdered
		assertEquals 20, tireOccurrence.discount
		assertEquals 10, tireOccurrence.environmentalFee
		assertEquals "10.01.2008", tireOccurrence.registrationDate.format("dd.MM.yyyy") 
	}
	
	void testGenerateTireOccurrenceWithInvalidPrice(){
		tireOccurrence.price = -3
		
		assertFalse "Test feilet, forventet ugyldig price", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError('price')
		assertNotNull "Jeg forventer å finne en feil i feltet price", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberInStock(){
		tireOccurrence.numberInStock = -5
		
		assertFalse "Test feilet, forventet ugyldig numberInStock" , tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError('numberInStock')
		assertNotNull "Jeg forventer å finne en feil i feltet numberInStock", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberOfReserved(){
		tireOccurrence.numberOfReserved = -2
		
		assertFalse "Test feilet, forventet ugyldig numberOfReserved", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("numberOfReserved")
		assertNotNull "Jeg forventer å finne en feil i feltet numberOfReserved", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberOfOrdered(){
		tireOccurrence.numberOfOrdered = -6
		
		assertFalse "Test feilet, forventet ugyldig numberOfOrdered", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("numberOfOrdered")
		assertNotNull "Jeg forventer å finne en feil i feltet numberOfOrdered", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidTire(){
		tireOccurrence.tire = null
		
		assertFalse "Test feilet, forventet ugyldig tire", tireOccurrence.validate()
		//def badField = tireOccurrence.errors.getFieldError("tire")
		//assertNotNull "Jeg forventer å finne en feil i feltet tire", badField
	}
	
//	void testGenerateTireOccurrenceWithEmptyDate(){
//		tireOccurrence.registrationDate = null
//		
//		assertFalse "Test feilet, forventet tom registrationDate", tireOccurrence.validate()
//		def badField = tireOccurrence.errors.getFieldError("registrationDate")
//		assertNotNull "Jeg forventer å finne en feil i feltet registrationDate", badField
//	}
	
	void testGenerateTireOccurrenceWithInvalidDiscount(){
		tireOccurrence.discount = -10
		
		assertFalse "Test feilet, forventet ugyldig discount", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("discount")
		assertNotNull "Jeg forventer å finne en feil i feltet discount", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidEnvironmentalFee(){
		tireOccurrence.environmentalFee = -10
		
		assertFalse "Test feilet, forventet ugyldig environmentalFee", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("environmentalFee")
		assertNotNull "Jeg forventer å finne en feil i feltet environmentalFee", badField
	}
	
	void testNumberOfAvailable(){
		Integer numberOfAvailable = tireOccurrence.numberInStock - tireOccurrence.numberOfReserved
		assertEquals numberOfAvailable, tireOccurrence.numberOfAvailable()
	}
	
	void testSum(){
		Double sum = (tireOccurrence.price * ((100 - tireOccurrence.discount)/100) + tireOccurrence.environmentalFee) * tireOccurrence.tax
		assertEquals sum, tireOccurrence.sum()
	}
}
