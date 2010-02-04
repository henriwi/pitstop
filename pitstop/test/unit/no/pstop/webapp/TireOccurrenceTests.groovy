package no.pstop.webapp

import java.text.SimpleDateFormat
import grails.test.*

class TireOccurrenceTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }
	
	void testGenerateTireOccurrence() {
		/*def tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		 loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")*/
		
		def date = new SimpleDateFormat("MM/dd/yyyy")
		
		//def template = '<g ateFormat format="dd-MM-yyyy" date="${myDate}" />'
		//def d = new Date()

		def tireOccurrence = new TireOccurrence(tire:new Tire(),price:89.89,numberInStock:4,numberOfReserved:3,
				numberOfOrdered:8,date: date.parse("10/1/2008"), numberOfAvailable:1 )
		
		assertEquals 89.89, tireOccurrence.price
		assertEquals 4, tireOccurrence.numberInStock
		assertEquals 3, tireOccurrence.numberOfReserved
		assertEquals 8, tireOccurrence.numberOfOrdered
		//assertOutputEquals( '01-01-2008', template, [myDate ] )
		//assertEquals "10/1/2008", tireOccurrence.date
		assertEquals 1, tireOccurrence.numberOfAvailable
	}
}
