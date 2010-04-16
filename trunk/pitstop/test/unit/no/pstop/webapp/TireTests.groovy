package no.pstop.webapp

import junit.framework.Assert
import grails.test.*

class TireTests extends GrailsUnitTestCase {
	def tire
	protected void setUp() {
		super.setUp()
		mockForConstraintsTests Tire
		tire = new Tire(width: 190, profile: 60, construction: "R", diameter: 17, partNr: "123AB",
				loadIndex: 165, speedIndex: "H", pattern: "m12", tireType: "Sommer", brand: "Nokian", tireName: "T-Zero", notice:"Demodekk")	
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testGenerateTire() {
		assertEquals 190, tire.width
		assertEquals 60, tire.profile
		assertEquals "R", tire.construction
		assertEquals 17, tire.diameter
		assertEquals "123AB", tire.partNr
		assertEquals 165, tire.loadIndex
		assertEquals "H", tire.speedIndex
		assertEquals "m12", tire.pattern
		assertEquals "Sommer", tire.tireType
		assertEquals "Nokian", tire.brand
		assertEquals "T-Zero", tire.tireName
	}
	
	void testGenerateTireWithInvalidPartNr() {
		tire.partNr = "?"
		
		assertFalse "Test failed, expected invalid partNr", tire.validate()
		def badField = tire.errors.getFieldError("partNr")
		assertNotNull "Expecting to find error in field partNr", badField
	}
	
	void testGenerateTireWithNonUniquePartNr() {
		def tire2 = new Tire(width: 190, profile: 60, construction: "R", diameter: 17, partNr: "123AB",
		loadIndex: 165, speedIndex: "H", pattern: "m12", tireType: "Sommer", brand: "Nokian", tireName: "T-Zero", notice: "Demodekk")	
	
		mockForConstraintsTests(Tire, [tire])
		
		assertTrue "Test failed, expected ok validation", tire.validate()
		assertFalse "Test failed, expected same partNr as tire", tire2.validate()
	}
	
	void testGenerateTireWithInvalidWidth() {
		tire.width = 0
		
		assertFalse "Test failed, expected invalid width", tire.validate()
		def badField = tire.errors.getFieldError("width")
		assertNotNull "Expecting to find error in field width", badField
	}
	
	void testGenerateTireWithInvalidProfile() {
		tire.profile = 2
		
		assertFalse "Test failed, expected invalid profile", tire.validate()
		def badField = tire.errors.getFieldError("profile")
		assertNotNull "Expecting to find error in field profile", badField
	}
	
	void testGenerateTireWithInvalidConstruction() {
		tire.construction = "K"
		
		assertFalse "Test failed, expected invalid construction", tire.validate()
		def badField = tire.errors.getFieldError("construction")
		assertNotNull "Expecting to find error in field construction", badField
	}
	
	void testGenerateTireWithInvalidDiameter() {
		tire.diameter = 5
		
		assertFalse "Test failed, expected invalid diameter", tire.validate()
		def badField = tire.errors.getFieldError("diameter")
		assertNotNull "Expecting to find error in field diameter", badField
	}
	
	void testGenerateTireWithInvalidLoadIndex() {
		tire.loadIndex = -2
		
		assertFalse "Test failed, expected invalid loadIndex", tire.validate()
		def badField = tire.errors.getFieldError("loadIndex")
		assertNotNull "Expecting to find error in field loadIndex", badField
	}
	
	void testGenerateTireWithInvalidSpeedIndex() {
		tire.speedIndex = "A"
		
		assertFalse "Test failed, expected invalid speedIndex", tire.validate()
		def badField = tire.errors.getFieldError("speedIndex")
		assertNotNull "Expecting to find error in field speedIndex", badField
	}
	
	void testGenerateTireWithInvalidPattern() {
		tire.pattern = "?"
		
		assertFalse "Test failed, expected invalid pattern", tire.validate()
		def badField = tire.errors.getFieldError("pattern")
		assertNotNull "Expecting to find error in field pattern", badField
	}
	
	void testGenerateTireWithInvalidTireType() {
		tire.tireType = "spring"
		
		assertFalse "Test failed, expected invalid tireType", tire.validate()
		def badField = tire.errors.getFieldError("tireType")
		assertNotNull "Expecting to find error in field tireType", badField
	}
	
	void testGenerateTireWithInvalidBrand() {
		tire.brand = ""
		
		assertFalse "Test failed, expected invalid tireBrand", tire.validate()
		def badField = tire.errors.getFieldError("brand")
		assertNotNull "Expecting to find error in field brand", badField
	}
	
	void testGenerateTireWithInvalidTireName() {
		tire.tireName = "<>"
		
		assertFalse "Test failed, expected invalid tireName", tire.validate()
		def badField = tire.errors.getFieldError("tireName")
		assertNotNull "Expecting to find error in field tireName", badField
	}
	
	void testOrderToString() {
		assertEquals "Nokian T-Zero 190/60 R17 165H Sommer (123AB)", tire.orderToString()
	}
	
	void testToString() {
		assertEquals "Nokian T-Zero 190/60 R17 165H Sommer (på lager: 0)", tire.toString()
	}
	
	void testTireShowToString() {
		assertEquals "Nokian T-Zero 190/60 R17 165H Sommer", tire.tireShowToString()
	}
	
	void testShowNoticeWith10FirstLettersWhenNoticeIsUnder10Letters() {
		tire.notice = "Notice"
		assertEquals "Notice", tire.showNoticeWith10FirstLetters()
	}
	
	void testShowNoticeWith10FirstLettersWhenNoticeIsOver10Letters() {
		tire.notice = "Notice notice notice"
		assertEquals "Notice not ...", tire.showNoticeWith10FirstLetters()
	}
	
	void testShowNoticeWith10FirstLettersWhenNoticeIsEmpty() {
		tire.notice = ""
		assertEquals "", tire.showNoticeWith10FirstLetters()
	}
	
	void testShowNoticeWith10FirstLettersWhenNoticeIsNull() {
		tire.notice = null
		assertEquals null, tire.showNoticeWith10FirstLetters()
	}
	
	void testFastSearchString() {
		assertEquals "190607s", tire.fastSearchString()
	}
}
