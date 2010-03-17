package no.pstop.webapp

import grails.test.*

class LogoutControllerTests extends ControllerUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testIndex() {
		controller.index()
		def uri = '/j_spring_security_logout'
		assertEquals "Redirect uri", uri, controller.redirectArgs.uri
    }
}
