package no.pstop.webapp

import javax.servlet.http.HttpSession;
import groovy.util.GroovyTestCase;
import org.springframework.mock.web.MockHttpSession;
import grails.test.*
import org.springframework.security.context.SecurityContextHolder as SCH
//import org.springframework.security.providers.TestingAuthenticationToken
import org.springframework.security.GrantedAuthority
import org.springframework.security.Authentication
import org.springframework.security.GrantedAuthorityImpl


class LogServiceTests extends GroovyTestCase {
	def logService
	
    protected void setUp() {
        super.setUp()
		//authe
        logService = new LogService()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSaveLog() {

    	//logService.saveLog(session, "Added new tire");
    }
}
