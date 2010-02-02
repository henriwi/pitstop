package no.pstop.webapp

import junit.framework.Assert;

import grails.test.*

class TireTests extends GrailsUnitTestCase {
	Tire tire
	
	protected void setUp() {
		super.setUp()
		tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests Tire
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testGenerateTire() {
		Tire tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		assertEquals 192, tire.width
		assertEquals 60, tire.profile
		assertEquals "R", tire.construction
		assertEquals 17, tire.diameter
		assertEquals "123AB", tire.partNr
		assertEquals 165, tire.loadIndex
		assertEquals "H", tire.speedIndex
		assertEquals "m12", tire.pattern
		assertEquals "Sommer", tire.tireType
	}
	
	void testGenerateTireWithInvalidePartNr(){
		Tire t = new Tire(width:165,profile:60,construction:"R",diameter:17,partNr:"?",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests(Tire)
		assertFalse "Ingen validering, ugyldig varenr", t.validate()
	}
	
	void testGenerateTireWithNonUniquePartNr(){
		Tire t1 = new Tire(width:165,profile:60,construction:"R",diameter:17,partNr:"DE3",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		Tire t2 = new Tire(width:165,profile:50,construction:"R",diameter:16,partNr:"DE3",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Vinter")
		
		mockDomain Tire;
		assertTrue "Validering ok", t1.validate()
		assertFalse "Ingen validering, ikke unikt partNr", t2.validate()
	}
	
	void testGenerateTireWithInvalideWidth(){
		Tire t = new Tire(width:0,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests(Tire)
		assertFalse "Ingen validering, ugyldig dekkbredde", t.validate()
	}
	
	void testGenerateTireWithInvalidProfile(){
		Tire t = new Tire(width:165,profile:2,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests(Tire)
		assertFalse "Ingen validering, ugyldig profil", t.validate()
	}
	
	void testGenerateTireWithInvalidConstruction(){
		Tire t = new Tire(width:165,profile:70,construction:"K",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig konstruksjon", t.validate()
	}
	
	void testGenerateTireWithInvalidDiameter(){
		Tire t = new Tire(width:165,profile:70,construction:"R",diameter:5,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig diameter", t.validate()
	}
	
	void testGenerateTireWithInvalidLoadIndex(){
		Tire t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:20,speedIndex:"H",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig belastningsindeks", t.validate()
	}
	
	void testGenerateTireWithInvalidSpeedIndex(){
		Tire t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"A",pattern:"m12",tireType:"Sommer")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig hastighetsindeks", t.validate()
	}
	
	void testGenerateTireWithInvalidPattern(){
		Tire t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"T",pattern:"?",tireType:"Sommer")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig mønster", t.validate()
	}
	
	void testGenerateTireWithInvalidTireType(){
		Tire t = new Tire(width:165,profile:70,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"T",pattern:"H",tireType:"spring")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig dekktype", t.validate()
	}
}
