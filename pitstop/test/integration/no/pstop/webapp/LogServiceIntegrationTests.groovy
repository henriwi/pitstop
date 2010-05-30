package no.pstop.webapp

import grails.test.*
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserImpl;
import org.grails.plugins.springsecurity.service.AuthenticateService;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.context.SecurityContextHolder as SCH 
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;


class LogServiceIntegrationTests extends GroovyTestCase {
	def logService
	def session
    protected void setUp() {
        super.setUp()
        logService = new LogService()
		session = new MockHttpSession()
    }

    protected void tearDown() {
        super.tearDown()
    }
		
	private logInUser() {
		def person = new User(username: "anders", userRealName: "Anders Evenstuen", passwd: "123", enabled: true, 
		email: "anders@gmail.com", description: "ingen", pass: "123")
		
		def authorities = person.authorities.collect { new GrantedAuthorityImpl(it.authority) }
		def userDetails = new GrailsUserImpl(person.username, person.passwd, person.enabled, true,
				true, true, authorities as GrantedAuthority[], person)
		
		SCH.context.authentication = new UsernamePasswordAuthenticationToken(userDetails, 
				person.passwd, userDetails.authorities)
		session["SPRING_SECURITY_CONTEXT"] = SCH.context
	}

    void testSaveLog() {
    	logInUser()
    	logService.saveLog(session, "Added new tire")
    }
}
