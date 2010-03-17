package no.pstop.webapp
import org.grails.plugins.springsecurity.service.AuthenticateService;

import grails.test.*

class UserControllerTests extends ControllerUnitTestCase {
	def user1, user2, user3
    protected void setUp() {
        super.setUp()
		mockDomain User
		mockDomain Role
		
		user1 = new User(username: "anders", userRealName: "Anders Evenstuen", passwd: "123", enabled: true, 
		email: "anders@gmail.com", description: "ingen", pass: "123")
		
		user2 = new User(username: "henrik", userRealName: "Henrik Hansen", passwd: "123", enabled: true, 
				email: "henrik@gmail.com", description: "ingen", pass: "123")
		
		user3 = new User(username: "ole", userRealName: "Ole Olsen", passwd: "123", enabled: true, 
				email: "ole@gmail.com", description: "ingen", pass: "123")
    }

    protected void tearDown() {
        super.tearDown()
    }
	
	private setParams(String username, String userRealName, String passwd, boolean enabled,
	String email, String description, String pass) {
		controller.params.username = username
		controller.params.userRealName = userRealName
		controller.params.passwd = passwd
		controller.params.enabled = enabled
		controller.params.email = email
		controller.params.description = description
		controller.params.pass = pass
	}

    void testIndex() {
		controller.index()
		assertEquals "redirect acton", "list", controller.redirectArgs.action
    }
	
	void testList() {
		def expectedList = [user1, user2, user3]
		mockDomain User, expectedList
		
		def model = controller.list()
		assertEquals "Expected list should be the same as the returned", expectedList, model.personList
	}
	
	void testShowWithValideId() {
		mockDomain User, [user1]
		
		controller.params.id = 1
		def model = controller.show()
		
		assertEquals "Expected model shold be the same as the returned", user1, model.person
	}
	
	void testShowWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = { args -> println "message: ${args}" }
		controller.show()
		
		assertEquals "Redirect action", "list", controller.redirectArgs.action
	}
	
	/*void testDelete() {
		mockDomain User, [user1]
		def mock = mockFor(AuthenticateService)
		controller.authenticateService = new AuthenticateService()
		//mock.demand.principal() {-> return user1}
		controller.authenticateService.principal() {-> return user1}
		controller.metaClass.message = { args -> println "message: ${args}" }
		controller.params.id = 1
		controller.delete()
		
		assertEquals "Redirect action", "list", controller.redirectArgs.action
	}*/
	
	void testCreate() {
		def model = controller.create()
		assertNotNull model.person
	}
	
	void testEditWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = { args -> println "message: ${args}" }
		controller.edit()
		
		assertEquals "Redirect action", "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain User, [user1]
		controller.params.id = 1
		def model = controller.edit()
		
		assertEquals "Expected model should be the same as the returned", user1, model.person
	}
	
	void testUpdateWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = { args -> println "message: ${args}" }
		controller.update()
		
		assertEquals "Redirect action", "edit", controller.redirectArgs.action
		assertEquals "Expected id should be the same as returned", controller.params.id, controller.redirectArgs.id
	}
	
	void testUpdateWithValidIdAndSamePassword() {
		mockDomain User, [user1]
		controller.params.id = 1
		setParams(user1.username, "Jan Anders Evenstuen", user1.passwd, user1.enabled, 
				user1.email, user1.description, user1.pass)
		
		controller.update()
		
		assertEquals "Redirect action", "show", controller.redirectArgs.action
	}
	
	void testUpdateWithInvalidUser() {
		mockDomain User, [user1]
		controller.params.id = 1
		setParams(user1.username, user1.userRealName, user1.passwd, user1.enabled, 
				"anders.gmail.com", user1.description, user1.pass)
		
		controller.update()
		
		assertEquals "Redirect action", "edit", controller.modelAndView.viewName
		assertNotNull "User should not be null", controller.modelAndView.model.linkedHashMap.person
	}
	
	//TODO - test save-methods
	
}
