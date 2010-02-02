package no.pstop.webapp

import junit.framework.Assert;

import grails.test.*

class TireTests extends GrailsUnitTestCase {
	Tire tire
	
	protected void setUp() {
		super.setUp()
		tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		mockForConstraintsTests Tire
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testGenerateTire() {
		Tire tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		assertEquals 192, tire.width
		assertEquals 60, tire.profile
		assertEquals "R", tire.construction
		assertEquals 17, tire.diameter
		assertEquals "123AB", tire.partNr
		assertEquals 165, tire.loadIndex
		assertEquals "H", tire.speedIndex
		assertEquals "m12", tire.pattern
		assertEquals "sommer", tire.tireType
	}
	
	void testGenerateTireWithUnvalideWidth(){
		Tire t = new Tire(width:0,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		mockForConstraintsTests(Tire)
		assertFalse "There should be errors", t.validate()
	}
	
	void testGenerateTireWithUnvalidProfile(){
		Tire t = new Tire(width:165,profile:2,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		mockForConstraintsTests(Tire)
		assertFalse "Ingen validering, ugyldig profil", t.validate()
	}
	
	void testGenerateTireWithUnvalidConstruction(){
		Tire t = new Tire(width:165,profile:70,construction:"K",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig konstruksjon", t.validate()
	}
	
	void testGenerateTireWithUnvalidDiameter(){
		Tire t = new Tire(width:165,profile:70,construction:"R",diameter:100,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		mockForConstraintsTests (Tire)
		assertFalse "Ingen validering, ugyldig diameter", t.validate()
	}
}
