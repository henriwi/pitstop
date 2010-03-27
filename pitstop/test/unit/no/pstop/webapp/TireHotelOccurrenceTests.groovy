package no.pstop.webapp

import java.text.SimpleDateFormat;
import java.util.Date
import junit.framework.Assert
import grails.test.*

class TireHotelOccurrenceTests extends GrailsUnitTestCase {
	def tireHotelOccurrence
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests TireHotelOccurrence
		tireHotelOccurrence = new TireHotelOccurrence(tireLocation: "A1", registrationNumber: "DB-53809",
				carType: "Audi A4", customer: new Customer(), tireType: "Sommer", inDate: new Date(),
				outDate: new Date()+100, notice: "")
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGenerateTireHotelOccurrence() {
		def df = new SimpleDateFormat("dd.MM.yyyy")
		tireHotelOccurrence.inDate = df.parse("02.03.2010")
		tireHotelOccurrence.outDate = df.parse("12.03.2010")
		
		assertEquals "A1", tireHotelOccurrence.tireLocation
		assertEquals "DB-53809", tireHotelOccurrence.registrationNumber
		assertEquals "Audi A4", tireHotelOccurrence.carType
		assertEquals "Sommer", tireHotelOccurrence.tireType
		assertEquals "02.03.2010", tireHotelOccurrence.inDate.format("dd.MM.yyyy")
		assertEquals "12.03.2010", tireHotelOccurrence.outDate.format("dd.MM.yyyy")
		assertEquals "", tireHotelOccurrence.notice
    }
		
	void testGenerateTireHotelOccurrenceWithEmptyTireLocation() {
		tireHotelOccurrence.tireLocation = ""
		
		assertFalse "Test failed, expecting empty tireLocation", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError('tireLocation')
		assertNotNull "I'm expecting to find error in tireLocation", badField
	}
	
	void testGenerateTireHotelOccurrenceWithInvalidTireLocation() {
		tireHotelOccurrence.tireLocation = "-3"
		
		assertFalse "Test failed, expecting invalid tireLocation", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError('tireLocation')
		assertNotNull "I'm expecting to find error in tireLocation", badField
	}
	
	void testGenerateTireHotelOccurrenceWithInvalidRegistationNumber() {
		tireHotelOccurrence.registrationNumber = "?"
		
		assertFalse "Test failed, expecting invalid registrationNumber", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError('registrationNumber')
		assertNotNull "I'm expecting to find error in registrationNumber", badField
	}
	
	void testGenerateTireHotelOccurrenceWithInvalidCarType() {
		tireHotelOccurrence.carType = "?"
		
		assertFalse "Test failed, expecting invalid carType", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError('carType')
		assertNotNull "I'm expecting to find error in carType", badField
	}
	
	void testGenerateTireHotelOccurrenceWithInvalidCustomer() {
		tireHotelOccurrence.customer = null
		
		assertFalse "Test failed, expecting invalid customer", tireHotelOccurrence.validate()
	}
	
	void testGenerateTireHotelOccurrenceWithInvalidTireType() {
		tireHotelOccurrence.tireType = "?"
		
		assertFalse "Test failed, expecting invalid tireType", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError('tireType')
		assertNotNull "I'm expecting to find error in tireType", badField
	}
	
	/*
	void testGenerateTireHotelOccurrenceWithInvalidInDate() {
		tireHotelOccurrence.inDate = "" 
		
		assertFalse "Test failed, expecting invalid inDate", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError('inDate')
		assertNotNull "I'm expecting to find error in inDate", badField
	}
	
	void testGenerateTireHotelOccurrenceWithInvalidOutDate() {
		tireHotelOccurrence.outDate = null
		
		assertFalse "Test failed, expecting invalid outDate", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError('outDate')
		assertNotNull "I'm expecting to find error in outDate", badField
	}
	*/
	
	void testGenerateTireHotelOccurrenceWithInvalidNotice() {
		
		for(int i = 0; i < 2000; i++)
		{
			tireHotelOccurrence.notice += "A"
		}
		
		assertFalse "Test failed, expecting invalid notice", tireHotelOccurrence.validate()
		def badField = tireHotelOccurrence.errors.getFieldError("notice")
		assertNotNull "I'm expecting to find error in notice", badField
	}
	
	void testShowNoticeWith20FirstLettersWhenNoticeIsUnder20Letters() {
		tireHotelOccurrence.notice = "Notice"
		assertEquals "Notice", tireHotelOccurrence.showNoticeWith20FirstLetters()
	}
	
	void testShowNoticeWith20FirstLettersWhenNoticeIsOver20Letters() {
		tireHotelOccurrence.notice = "Notice notice notice notice notice"
		assertEquals "Notice notice notice ...", tireHotelOccurrence.showNoticeWith20FirstLetters()
	}
	
	void testShowNoticeWith20FirstLettersWhenNoticeIsEmpty() {
		tireHotelOccurrence.notice = ""
		assertEquals "", tireHotelOccurrence.showNoticeWith20FirstLetters()
	}
}
