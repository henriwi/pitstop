package no.pstop.webapp

import java.sql.Date;
import grails.test.*

class LogTests extends GrailsUnitTestCase {
	def log
	def user
	long date = 1000000000
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests Log
		mockDomain User
		user = new User(username: "Anders", userRealName: "Anders Evenstuen", passwd: "123", enabled: true, 
		email: "anders@gmail.com", description: "ingen", pass: "123")
		log = new Log(user: user, date: new Date(date), event: "Created tire")
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGenerateLog() {
    	assertEquals user, log.user
		assertEquals new Date(date), log.date
		assertEquals "Created tire", log.event
    }
	
	void testGenerateLogWithNoUser() {
		log.user = null
		assertFalse "Expected invalid user", log.validate()
		def badField = log.errors.getFieldError('user')
		assertNotNull "Expecting to find error in field user", badField
	}
	
	void testGenerateLogWithNoDate() {
		log.date = null
		assertFalse "Expected invalid date", log.validate()
		def badField = log.errors.getFieldError('date')
		assertNotNull "Expecting to find error in field date", badField
	}
	
	void testGenerateLogWithBlankAction() {
		log.event = ""
		assertFalse "Expected invalid action", log.validate()
		def badField = log.errors.getFieldError('event')
		assertNotNull "Expecting to find error in field event", badField
	}
}
