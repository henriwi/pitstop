package no.pstop.webapp

import java.text.SimpleDateFormat;
import java.util.Date
import junit.framework.Assert
import grails.test.*

class TireHotelOccurenceTests extends GrailsUnitTestCase {
	def tireHotelOccurence
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests TireHotelOccurence
		tireHotelOccurence = new TireHotelOccurence(tireLocation: "A1", registrationNumber: "DB-53809",
				carType: "Audi A4", customer: new Customer(), tireType: "Sommer", inDate: new Date(),
				outDate: new Date()+100, notice: "")
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGenerateTireHotelOccurence() {
		def df = new SimpleDateFormat("dd.MM.yyyy")
		tireHotelOccurence.inDate = df.parse("02.03.2010")
		tireHotelOccurence.outDate = df.parse("12.03.2010")
		
		assertEquals "A1", tireHotelOccurence.tireLocation
		assertEquals "DB-53809", tireHotelOccurence.registrationNumber
		assertEquals "Audi A4", tireHotelOccurence.carType
		assertEquals "Sommer", tireHotelOccurence.tireType
		assertEquals "02.03.2010", tireHotelOccurence.inDate.format("dd.MM.yyyy")
		assertEquals "12.03.2010", tireHotelOccurence.outDate.format("dd.MM.yyyy")
		assertEquals "", tireHotelOccurence.notice
    }
		
	void testGenerateTireHotelOccurrenceWithEmptyTireLocation() {
		tireHotelOccurence.tireLocation = ""
		
		assertFalse "Test failed, expecting empty tireLocation", tireHotelOccurence.validate()
		def badField = tireHotelOccurence.errors.getFieldError('tireLocation')
		assertNotNull "I'm expecting to find error in tireLocation", badField
	}
	
	void testGenerateTireHotelOccurrenceWithInvalidTireLocation() {
		tireHotelOccurence.tireLocation = "-3"
		
		assertFalse "Test failed, expecting invalid tireLocation", tireHotelOccurence.validate()
		def badField = tireHotelOccurence.errors.getFieldError('tireLocation')
		assertNotNull "I'm expecting to find error in tireLocation", badField
	}
}
