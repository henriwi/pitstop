package no.pstop.webapp

import grails.test.*

class UserTests extends GrailsUnitTestCase {
	def user
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests User
		
		user = new User(username: "Anders", userRealName: "Anders Evenstuen", passwd: "123", enabled: true, 
		email: "anders@gmail.com", description: "ingen", pass: "123")
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testCreateUser() {
		assertEquals "Anders", user.username
		assertEquals "Anders Evenstuen", user.userRealName
		assertEquals "123", user.passwd
		assertEquals true, user.enabled
		assertEquals "anders@gmail.com", user.email
		assertEquals "ingen", user.description
		assertEquals "123", user.pass
    }
	
	void testCreateUserWithBlankUsername() {
		user.username = null
		
		assertFalse "Expected false validation", user.validate()
		def badField = user.errors.getFieldError("username")
		assertNotNull "Expected error in username", badField
	}
	
	void testCreateUserWithNonUniqueUsername() {
		def user2 = new User(username: "Anders", userRealName: "Anders Olsen", passwd: "123", enabled: true, 
		email: "anders@gmail.com", description: "ingen", pass: "123")
		
		mockForConstraintsTests User, [user]
		
		assertFalse "Expected false validation", user2.validate()
		def badField = user2.errors.getFieldError("username")
		assertNotNull "Expected error in username", badField
	}
	
	void testCreateUserWithBlankUserRealName() {
		user.userRealName = null
		
		assertFalse "Expected false validation", user.validate()
		def badField = user.errors.getFieldError("userRealName")
		assertNotNull "Expected error in userRealName", badField
	}
	
	void testCreateUserWithBlankPasswd() {
		user.passwd = null
		
		assertFalse "Expected false validation", user.validate()
		def badField = user.errors.getFieldError("passwd")
		assertNotNull "Expected error in passwd", badField
	}
	
	void testCreateUserWithInvalidEmail() {
		user.email = "anders.gmail.com"
		
		assertFalse "Expected false validation", user.validate()
		def badField = user.errors.getFieldError("email")
		assertNotNull "Expected error in email", badField
	}
}
