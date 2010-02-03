package no.pstop.webapp

import grails.test.*

class TireOccurrenceTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }
	
	void testSomething() {
		
	}
	
	void testGenerateTireOccurrence() {
		/*def tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		 loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")*/
		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:89.89,numberInStock:4,numberOfReserved:3,
		numberOfOrdered:8,date:new Date(), numberOfAvailable:1 )
		
		
		assertEquals 89.89, tireOccurrence.price
		assertEquals 4, tireOccurrence.numberInStock
		assertEquals 3, tireOccurrence.numberOfReserved
		assertEquals 8, tireOccurrence.numberOfOrdered
		assertEquals new Date(), tireOccurrence.date
		assertEquals 1, tireOccurrence.numberOfAvailable
	}
}
