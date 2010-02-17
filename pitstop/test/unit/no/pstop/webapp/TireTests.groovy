package no.pstop.webapp

import junit.framework.Assert;

import grails.test.*

class TireTests extends GrailsUnitTestCase {
	//def trutle //= new Tire()
	protected void setUp() {
		super.setUp()
		//trutle = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
			//	loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests Tire
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testGenerateTire() {
		def tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "T-Zero")
		
		assertEquals 192, tire.width
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
		def t = new Tire(width:165,profile:60,construction:"R",diameter:17,partNr:"?",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig partNr", t.validate()
		def badField = t.errors.getFieldError('partNr')
		assertNotNull "Jeg forventer å finne en feil i feltet partNr", badField
		//def code = badField?.codes.find {it == 'tire.partNr.validator.invalid'} 
		//assertNotNull "the partNr field should be the gjerningsmann", code 
	}
	
	void testGenerateTireWithNonUniquePartNr(){
		def t1 = new Tire(width:165,profile:60,construction:"R",diameter:17,partNr:"DE3",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		def t2 = new Tire(width:165,profile:50,construction:"R",diameter:17,partNr:"DE3",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		mockForConstraintsTests(Tire, [t1])
		
		assertTrue "Test feilet, forventet ok validering", t1.validate()
		assertFalse "Test feilet, forventet samme partNr som t1", t2.validate()
		//def badField = t2.errors.getFieldError('partNr')
		//assertNull "Jeg forventer et unikt nummer i partNr", badField
	}
	
	void testGenerateTireWithInvalidWidth(){
		//trutle.width = 0
		def t = new Tire(width:0,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig width", t.validate()
		def badField = t.errors.getFieldError('width')
		assertNotNull "Jeg forventer å finne en feil i feltet width", badField
	}
	
	void testGenerateTireWithInvalidProfile(){
		def t = new Tire(width:165,profile:2,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig profile", t.validate()
		def badField = t.errors.getFieldError('profile')
		assertNotNull "Jeg forventer å finne en feil i feltet profile", badField
	}
	
	void testGenerateTireWithInvalidConstruction(){
		def t = new Tire(width:165,profile:70,construction:"K",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig construction", t.validate()
		def badField = t.errors.getFieldError('construction')
		assertNotNull "Jeg forventer å finne en feil i feltet construction", badField
	}
	
	void testGenerateTireWithInvalidDiameter(){
		def t = new Tire(width:165,profile:70,construction:"R",diameter:5,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig diameter", t.validate()
		def badField = t.errors.getFieldError('diameter')
		assertNotNull "Jeg forventer å finne en feil i feltet diameter", badField
	}
	
	void testGenerateTireWithInvalidLoadIndex(){
		def t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:20,speedIndex:"H",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig loadIndex", t.validate()
		def badField = t.errors.getFieldError('loadIndex')
		assertNotNull "Jeg forventer å finne en feil i feltet loadIndex", badField
	}
	
	void testGenerateTireWithInvalidSpeedIndex(){
		def t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"A",pattern:"m12",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig speedIndex", t.validate()
		def badField = t.errors.getFieldError('speedIndex')
		assertNotNull "Jeg forventer å finne feil i feltet speedIndex", badField
	}
	
	void testGenerateTireWithInvalidPattern(){
		def t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"T",pattern:"?",tireType:"Sommer", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig pattern", t.validate()
		def badField = t.errors.getFieldError('pattern')
		assertNotNull "Jeg forventer å finne en feil i feltet pattern", badField
	}
	
	void testGenerateTireWithInvalidTireType(){
		def t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"T",pattern:"H",tireType:"spring", brand:"Nokian", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig tireType", t.validate()
		def badField = t.errors.getFieldError('tireType')
		assertNotNull "Jeg forventer å finne en feil i feltet tireType", badField
	}
	
	void testGenerateTireWithInvalidTireBrand(){
		def t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"T",pattern:"H",tireType:"Sommer", brand:"", tireName: "Zero")
		
		assertFalse "Test feilet, forventet ugyldig tireBrand", t.validate()
		def badField = t.errors.getFieldError('brand')
		assertNotNull "Jeg forventer å finne en feil i feltet brand", badField
	}
	
	void testGenerateTireWithInvalidTireName(){
		def t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"T",pattern:"H",tireType:"Sommer", brand:"Nokian", tireName: "<>")
		
		assertFalse "Test feilet, forventet ugyldig tireName", t.validate()
		def badField = t.errors.getFieldError('tireName')
		assertNotNull "Jeg forventer å finne en feil i feltet tireName", badField
	}
}
