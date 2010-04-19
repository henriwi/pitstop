package no.pstop.webapp

import grails.test.*

class PostalCodeAndPlaceTests extends GrailsUnitTestCase {
	def post
	protected void setUp() {
        super.setUp()
		mockForConstraintsTests PostalCodeAndPlace
		post = new PostalCodeAndPlace(postalCode:"0561", place:"Oslo")	
		
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testGenerateTire() {
		assertEquals "0561", post.postalCode
		assertEquals "Oslo", post.place
	}
	
	void testPostalCodeAndPlaceWithInvalidPostalCode() {
		post.postalCode = "?"
		
		assertFalse "Test failed, expected invalid postalCode", post.validate()
		def badField = post.errors.getFieldError("postalCode")
		assertNotNull "Expecting to find error in field postalCode", badField
	}
	
	void testPostalCodeAndPlaceWithInvalidPlace() {
		post.place = ""
		
		assertFalse "Test failed, expected invalid place", post.validate()
		def badField = post.errors.getFieldError("place")
		assertNotNull "Expecting to find error in field place", badField
	}
}
