package no.pstop.webapp

import junit.framework.Assert;

import grails.test.*

class TireTests extends GrailsUnitTestCase {
	protected void setUp() {
		super.setUp()
		
		Tire tire = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		//mockForConstraintsTests(Tire, [existingTire])
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
	
	/*void testGenerateTireWithEmptyFields(){
	 Tire t = new Tire(width:165,profile:60,construction:"R",diameter:17,partNr:"123AB",
	 loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
	 mockForConstraintsTests(Tire)
	 assertFalse "There should be errors", t.validate()
	 //assertFalse t.validate()
	 //assertTrue t.validate()
	 }*/
	
	void testGenerateTireWithUnvalideWidth(){
		Tire t = new Tire(width:0,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		mockForConstraintsTests(Tire)
		assertFalse "There should be errors", t.validate()
		//assertFalse t.validate()
		//assertTrue t.validate()
	}
	
	void testGenerateTireWithUnvalidProfile(){
		Tire t = new Tire(width:165,profile:2,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		mockForConstraintsTests(Tire)
		assertFalse "Ingen validering, ugyldig profil", t.validate()
	}
	
	
}
