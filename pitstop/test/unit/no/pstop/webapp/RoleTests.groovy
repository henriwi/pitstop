package no.pstop.webapp

import grails.test.*

class RoleTests extends GrailsUnitTestCase {
	def role
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests Role
		
		role = new Role(description: "administrator access", authority: "ROLE_ADMIN")
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testCreateRole() {
		assertEquals "administrator access", role.description
		assertEquals "ROLE_ADMIN", role.authority
    }
	
	void testCreateRoleWithBlankAuthority() {
		role.authority = null
		
		assertFalse "Expected false validation", role.validate()
		def badField = role.errors.getFieldError("authority")
		assertNotNull "Expected error i authority", badField
	}
	
	void testCreateRoleWithNonUniqueAuthority() {
		def role2 = new Role(description: "administrator access", authority: "ROLE_ADMIN")
		mockForConstraintsTests Role, [role]
		
		assertFalse "Expected false validation", role2.validate()
		def badField = role2.errors.getFieldError("authority")
		assertNotNull "Expected error i authority", badField
	}
}
