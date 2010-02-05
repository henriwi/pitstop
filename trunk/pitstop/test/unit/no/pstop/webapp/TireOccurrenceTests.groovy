package no.pstop.webapp

import java.text.SimpleDateFormat
import grails.test.*

class TireOccurrenceTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
			
		mockForConstraintsTests TireOccurrence
    }

    protected void tearDown() {
        super.tearDown()
    }
	
	void testGenerateTireOccurrence() {
		def df = new SimpleDateFormat("MM/dd/yyyy")
		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:89.89,numberInStock:4,numberOfReserved:3,
				numberOfOrdered:8,date: df.parse("10/01/2008"), numberOfAvailable:1 )
		
		assertEquals 89.89, tireOccurrence.price
		assertEquals 4, tireOccurrence.numberInStock
		assertEquals 3, tireOccurrence.numberOfReserved
		assertEquals 8, tireOccurrence.numberOfOrdered
		assertEquals "10/01/2008", tireOccurrence.date.format("MM/dd/yyyy")
		assertEquals 1, tireOccurrence.numberOfAvailable
	}
	
	void testGenerateTireOccurrenceWithInvalidPrice(){
		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:-3,numberInStock:4,numberOfReserved:3,
				numberOfOrdered:8,date:new Date(), numberOfAvailable:1 )
		
		assertFalse "Ingen validering, feil pris input", tireOccurrence.validate()
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberInStock(){
		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:1.0,numberInStock:-5,numberOfReserved:3,
				numberOfOrdered:8,date:new Date(), numberOfAvailable:1 )
		
		assertFalse "ingen validering, feil input" , tireOccurrence.validate()
	}
	
	void testGenerateTireOccurrenceWithInvalidNumberOfReserved(){
		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:1.0,numberInStock:4,numberOfReserved:-3,
				numberOfOrdered:8,date:new Date(), numberOfAvailable:1 )
		
		assertFalse "Ingen validering, feil numberOfReserved input", tireOccurrence.validate()
	}
	
	void testGenerateTireOccurenceWithInvalidNumberOfOrdered(){
		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:1.0,numberInStock:4,numberOfReserved:4,
				numberOfOrdered:-6,date:new Date(), numberOfAvailable:1 )
		
		assertFalse "Ingen validering, feil input numberOfOrdered", tireOccurrence.validate()
	}
	
	void testGenenerateTireOccurenceWithInvalidNumberOfAvailable(){
		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:1.0,numberInStock:4,numberOfReserved:4,
				numberOfOrdered:10,date:new Date(), numberOfAvailable:-3 )
		
		assertFalse "Ingen validering, feil input numberOfAvaiable", tireOccurrence.validate()
	}
}
