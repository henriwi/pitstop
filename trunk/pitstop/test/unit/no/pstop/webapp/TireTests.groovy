package no.pstop.webapp

import junit.framework.Assert;

import grails.test.*

class TireTests extends GrailsUnitTestCase {
	def tire
	protected void setUp() {
		super.setUp()
		mockForConstraintsTests Tire
		tire = new Tire(width:190,profile:60,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "T-Zero")	
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
	
	void testGenerateTireWithInvalidPartNr(){
		tire.partNr = "?"
		
		assertFalse "Test feilet, forventet ugyldig partNr", tire.validate()
		def badField = tire.errors.getFieldError("partNr")
		assertNotNull "Jeg forventer å finne en feil i feltet partNr", badField
	}
	
	void testGenerateTireWithNonUniquePartNr(){
		def tire2 = new Tire(width:190,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "T-Zero")	
	
		mockForConstraintsTests(Tire, [tire])
		
		assertTrue "Test feilet, forventet ok validering", tire.validate()
		assertFalse "Test feilet, forventet samme partNr som tire", tire2.validate()
	}
	
	void testGenerateTireWithInvalidWidth(){
		tire.width = 0
		
		assertFalse "Test feilet, forventet ugyldig width", tire.validate()
		def badField = tire.errors.getFieldError("width")
		assertNotNull "Jeg forventer å finne en feil i feltet width", badField
	}
	
	void testGenerateTireWithInvalidProfile(){
		tire.profile = 2
		
		assertFalse "Test feilet, forventet ugyldig profile", tire.validate()
		def badField = tire.errors.getFieldError("profile")
		assertNotNull "Jeg forventer å finne en feil i feltet profile", badField
	}
	
	void testGenerateTireWithInvalidConstruction(){
		tire.construction = "K"
		
		assertFalse "Test feilet, forventet ugyldig construction", tire.validate()
		def badField = tire.errors.getFieldError("construction")
		assertNotNull "Jeg forventer å finne en feil i feltet construction", badField
	}
	
	void testGenerateTireWithInvalidDiameter(){
		tire.diameter = 5
		
		assertFalse "Test feilet, forventet ugyldig diameter", tire.validate()
		def badField = tire.errors.getFieldError("diameter")
		assertNotNull "Jeg forventer å finne en feil i feltet diameter", badField
	}
	
	void testGenerateTireWithInvalidLoadIndex(){
		tire.loadIndex = 20
		
		assertFalse "Test feilet, forventet ugyldig loadIndex", tire.validate()
		def badField = tire.errors.getFieldError("loadIndex")
		assertNotNull "Jeg forventer å finne en feil i feltet loadIndex", badField
	}
	
	void testGenerateTireWithInvalidSpeedIndex(){
		tire.speedIndex = "A"
		
		assertFalse "Test feilet, forventet ugyldig speedIndex", tire.validate()
		def badField = tire.errors.getFieldError("speedIndex")
		assertNotNull "Jeg forventer å finne feil i feltet speedIndex", badField
	}
	
	void testGenerateTireWithInvalidPattern(){
		tire.pattern = "?"
		
		assertFalse "Test feilet, forventet ugyldig pattern", tire.validate()
		def badField = tire.errors.getFieldError("pattern")
		assertNotNull "Jeg forventer å finne en feil i feltet pattern", badField
	}
	
	void testGenerateTireWithInvalidTireType(){
		tire.tireType = "spring"
		
		assertFalse "Test feilet, forventet ugyldig tireType", tire.validate()
		def badField = tire.errors.getFieldError("tireType")
		assertNotNull "Jeg forventer å finne en feil i feltet tireType", badField
	}
	
	void testGenerateTireWithInvalidBrand(){
		tire.brand = ""
		
		assertFalse "Test feilet, forventet ugyldig tireBrand", tire.validate()
		def badField = tire.errors.getFieldError("brand")
		assertNotNull "Jeg forventer å finne en feil i feltet brand", badField
	}
	
	void testGenerateTireWithInvalidTireName(){
		tire.tireName = "<>"
		
		assertFalse "Test feilet, forventet ugyldig tireName", tire.validate()
		def badField = tire.errors.getFieldError("tireName")
		assertNotNull "Jeg forventer å finne en feil i feltet tireName", badField
	}
	
	void testToString(){
		assertEquals "Nokian T-Zero 190/60 R17 165H Sommer (123AB)", tire.toString()
	}
}
