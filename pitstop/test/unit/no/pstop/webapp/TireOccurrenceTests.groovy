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
		
		assertFalse "Test failed, expected invalid price", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError('price')
		assertNotNull "Expecting to find error in field price", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberInStock(){
		tireOccurrence.numberInStock = -5
		
		assertFalse "Test failed, expected invalid numberInStock" , tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError('numberInStock')
		assertNotNull "Expecting to find error in field numberInStock", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberOfReserved(){
		tireOccurrence.numberOfReserved = -2
		
		assertFalse "Test failed, expected invalid numberOfReserved", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("numberOfReserved")
		assertNotNull "Expecting to find error in field numberOfReserved", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberOfOrdered(){
		tireOccurrence.numberOfOrdered = -6
		
		assertFalse "Test failed, expected invalid numberOfOrdered", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("numberOfOrdered")
		assertNotNull "Expecting to find error in field numberOfOrdered", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidTire(){
		tireOccurrence.tire = null
		
		assertFalse "Test failed, expected invalid tire", tireOccurrence.validate()
		//def badField = tireOccurrence.errors.getFieldError("tire")
		//assertNotNull "Expecting to find error in field tire", badField
	}
	/*
	void testGenerateTireOccurrenceWithEmptyDate(){
		tireOccurrence.registrationDate = null
		
		assertFalse "Test failed, expected invalid registrationDate", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("registrationDate")
		assertNotNull "Expecting to find error in field registrationDate", badField
	}*/
	
	void testGenerateTireOccurrenceWithInvalidDiscount(){
		tireOccurrence.discount = -10
		
		assertFalse "Test failed, expected invalid discount", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("discount")
		assertNotNull "Expecting to find error in field discount", badField
	}
	
	void testGenerateTireOccurrenceWithInvalidEnvironmentalFee(){
		tireOccurrence.environmentalFee = -10
		
		assertFalse "Test failed, expected invalid environmentalFee", tireOccurrence.validate()
		def badField = tireOccurrence.errors.getFieldError("environmentalFee")
		assertNotNull "Expecting to find error in field environmentalFee", badField
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
