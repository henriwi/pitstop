package no.pstop.webapp

import grails.test.*

class TireTests extends GrailsUnitTestCase {
	protected void setUp() {
		super.setUp()
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testGenerateTire() {
		Tire t = new Tire(width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"sommer")
		
		assertEquals 192, t.width
		assertEquals 60, t.profile
		assertEquals "R", t.construction
		assertEquals 17, t.diameter
		assertEquals "123AB", t.partNr
		assertEquals 165, t.loadIndex
		assertEquals "H", t.speedIndex
		assertEquals "m12", t.pattern
		assertEquals "sommer", t.tireType
	}
}
