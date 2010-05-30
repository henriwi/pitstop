package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserImpl;
import org.grails.plugins.springsecurity.service.AuthenticateService;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.context.SecurityContextHolder as SCH 
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;
import grails.test.*

class LoginControllerIntegrationTests extends GroovyTestCase {
	
	def controller
	def authenticateService
	def uriPrefix = "/test"
	
    protected void setUp() {
        super.setUp()
		controller = new LoginController()
		controller.authenticateService = new AuthenticateService()
    }

    protected void tearDown() {
        super.tearDown()
		SCH.context.authentication = null
    }
		
	private logIn() {
		def person = new User(username: "anders", userRealName: "Anders Evenstuen", passwd: "123", enabled: true, 
				email: "anders@gmail.com", description: "ingen", pass: "123")
		
		def authorities = person.authorities.collect { new GrantedAuthorityImpl(it.authority) }
		def userDetails = new GrailsUserImpl(person.username, person.passwd, person.enabled, true,
				true, true, authorities as GrantedAuthority[], person)
		
		SCH.context.authentication = new UsernamePasswordAuthenticationToken(userDetails, 
				person.passwd, userDetails.authorities)
	}

    void testIndexAsLoggedIn() {
		logIn()
		controller.index()
		assertEquals "Redirect uri", "/", controller.response.redirectedUrl
    }
		
	void testIndexAsLoggedOut() {
		controller.index()
		assertEquals "Redirect uri", "/login/auth", controller.response.redirectedUrl
	}
	
	void testAuthAsLoggedIn() {
		logIn()
		controller.auth()
		assertEquals "Redirect uri", "/", controller.response.redirectedUrl
	}
	
	void testAuthAsLoggedOut() {
		controller.auth()
		assertEquals "View name", "${uriPrefix}/auth", controller.getModelAndView().viewName
		assertEquals "Model", "/j_spring_security_check", controller.getModelAndView().model.postUrl
	}
	
	void testFull() {
		controller.full()
		assertEquals "View name", "${uriPrefix}/auth", controller.getModelAndView().viewName
		assertNotNull "Model should not be null", controller.getModelAndView().model.hasCookie
	}
	
	void testAuthFail() {
		controller.authfail()
		assertEquals "Redirect uri", "/login/auth", controller.response.redirectedUrl
	}
}
