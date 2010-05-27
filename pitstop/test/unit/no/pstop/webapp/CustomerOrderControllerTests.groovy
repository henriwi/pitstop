package no.pstop.webapp;

import grails.test.ControllerUnitTestCase;
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserImpl;
import org.grails.plugins.springsecurity.service.AuthenticateService;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.context.SecurityContextHolder as SCH 
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;

class CustomerOrderControllerTests extends ControllerUnitTestCase {
	def customer
	def post
	def tire
	def customerOrderLine
	def customerOrder
	
	protected void setUp() {
		super.setUp();
		
		mockDomain CustomerOrder
		mockDomain CustomerOrderLine
		
		post = new PostalCodeAndPlace(postalCode:"0194",place:"Oslo")
		customer = new Customer(id:1, firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
				postalCodeAndPlace: post, email: "felger@dekk.no", company: "Dekkilicious", notice: "God kunde")
		tire = new Tire(width: 190, profile: 60, construction: "R", diameter: 17, partNr: "123AB",
				loadIndex: 165, speedIndex: "H", pattern: "m12", tireType: "Sommer", brand: "Nokian", tireName: "T-Zero", 
				notice:"Demodekk", retailPrice: 1095, numberInStock: 4)
		customerOrder = new CustomerOrder(customer: customer, orderDate: new Date(), deliveredDate: null, notice: "")
		customerOrderLine = new CustomerOrderLine(tire: tire, customerOrder: customerOrder,
				numberOfReservedTires: 4, price: 950.0)
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
		controller.session["SPRING_SECURITY_CONTEXT"] = SCH.context
	}
	
	private setParams(Double price, Integer numberOfReservedTires, Integer tire_id) {
		controller.params.price = price
		controller.params.numberOfReservedTires = numberOfReservedTires
		controller.params.tire_id = tire_id
	}
	
	private setSessions(orderLines) {
		controller.session["order"] = new CustomerOrder()
		controller.session["orderLines"] = orderLines
	}
	
	void testCreate() {
		mockDomain Customer, [customer]
		controller.params.id = 1
		
		def model = controller.create()
		
		assertNotNull "Ordermodel should not be null", model.order
		assertNotNull "Customer should not be null", model.order.customer
	}
	
	void testAddToOrder() {
		setParams(1500, 4, 1)
		controller.params.customer_id = 1
		setSessions([])
		mockDomain Tire, [tire]
		mockDomain Customer
		
		controller.addToOrder()

		assertEquals "View should be create", "create", controller.modelAndView.viewName
		assertNotNull "Ordermodel should not be null", controller.modelAndView.model.linkedHashMap.order
		assertEquals "Number of orderlines should be 1", 1, controller.modelAndView.model.linkedHashMap.orderLines.size()
	}
	
	void testDeleteFromOrder() {
		def orderLines = [customerOrderLine]
		mockDomain CustomerOrderLine, orderLines
		setSessions(orderLines)
		controller.params._action_deleteFromOrder = "0"
		
		controller.deleteFromOrder()
		
		assertEquals "View should be create", "create", controller.modelAndView.viewName
		assertNotNull "Ordermodel should not be null", controller.modelAndView.model.linkedHashMap.order
		assertEquals "Number of orderlines should be 0", 0, controller.modelAndView.model.linkedHashMap.orderLines.size()
	}
	
	void testDeliverOrder() {
		mockDomain CustomerOrder, [customerOrder]
		mockDomain CustomerOrderLine, [customerOrderLine]
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"}
		
		def logMock = mockFor(LogService)
		logMock.demand.saveLog() {}
		controller.logService = logMock.createMock() 
		
		logInUser()
		
		controller.deliverOrder()
		
		assertEquals "Redirect controller should be customer", "customer", controller.redirectArgs.controller
		assertEquals "Redirect action should be show", "show", controller.redirectArgs.action
		assertEquals "Redirect id should be 1", 1, controller.redirectArgs.id
	}
}
