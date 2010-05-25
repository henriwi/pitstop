package no.pstop.webapp

import com.sun.org.apache.xerces.internal.impl.xs.identity.Selector.Matcher;
import grails.test.*
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserImpl;
import org.grails.plugins.springsecurity.service.AuthenticateService;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.context.SecurityContextHolder as SCH 
import org.springframework.security.providers.UsernamePasswordAuthenticationToken;

class TireControllerTests extends ControllerUnitTestCase {
	def tire
	protected void setUp() {
		super.setUp()
		mockDomain Tire
		
		tire = new Tire(width: 190, profile: 60, construction: "R", diameter: 17, partNr: "123AB",
				loadIndex: 165, speedIndex: "H", pattern: "m12", tireType: "Sommer", brand: "Nokian", tireName: "T-Zero", 
				notice:"Demodekk", retailPrice: 1095, numberInStock: 4)
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	private setParams(Integer width, Integer profile, String construction, Integer diameter, String partNr, Integer loadIndex,
	String speedIndex, String pattern, String tireType, String brand, String tireName, Double retailPrice, 
	Integer numberInStock, String notice) {
		controller.params.width = width
		controller.params.profile = profile
		controller.params.construction = construction
		controller.params.diameter = diameter
		controller.params.partNr = partNr
		controller.params.loadIndex = loadIndex
		controller.params.speedIndex = speedIndex
		controller.params.pattern = pattern
		controller.params.tireType = tireType
		controller.params.brand = brand
		controller.params.tireName = tireName
		controller.params.retailPrice = retailPrice
		controller.params.numberInStock = numberInStock
		controller.params.notice = notice
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
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testCreate() {
		def model = controller.create()
		assertNotNull model.tireInstance
	}
	
	void testSaveWithValidTire() {
		setParams(190, 60, "R", 17, "123AB", 165, "H", "m12", "Sommer", "Pirelli", "T-Zero", 1095, 4, "Demodekk")
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()

		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testSaveWithInvalidWidth() {
		setParams(-100, 60, "R", 17, "123AB", 165, "H", "m12", "Sommer", "Pirelli", "T-Zero", 1095, 4, "Demodekk")
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()
		
		assertEquals "redirect action", "create", controller.modelAndView.viewName
		assertNotNull "Tire should not be null", controller.modelAndView.model.linkedHashMap.tireInstance
	}
	
	void testShowWithValidId() {
		def supplierOrderLine1 = new SupplierOrderLine(tire: tire, supplierOrder: new SupplierOrder(), 
				numberOfOrderedTires: 4, price: 1095.0, receivedDate: null, discount: 10, environmentalFee: 10)
		def supplierOrderLine2 = new SupplierOrderLine(tire: tire, supplierOrder: new SupplierOrder(), 
				numberOfOrderedTires: 2, price: 995.0, receivedDate: null, discount: 10, environmentalFee: 10)
		
		def customerOrderLine1 = new CustomerOrderLine(tire: tire, numberOfReservedTires: 4, 
				customerOrder: new CustomerOrder(), price: 1095.0)
		def customerOrderLine2 = new CustomerOrderLine(tire: tire, numberOfReservedTires: 6, 
				customerOrder: new CustomerOrder(), price: 995.0)
		
		def supplierOrderLines = [supplierOrderLine1, supplierOrderLine2]
		def customerOrderLines = [customerOrderLine1, customerOrderLine2]
		
		mockDomain SupplierOrderLine, supplierOrderLines 
		mockDomain CustomerOrderLine, customerOrderLines
		mockDomain Tire, [tire]
		
		controller.params.id = 1
		def model = controller.show()
		assertEquals "Tire should be equal", tire, model.tireInstance
		assertEquals "supplierOrderLines should be equal", supplierOrderLines, model.supplierOrderLines
		assertNotNull "customerOrders should not be null", model.customerOrders
	}
	
	void testShowWithInvalidId() {
		mockDomain Tire, [tire]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain Tire, [tire]
		controller.params.id = 1
		Map model = controller.edit()
		assertEquals "model.tireInstance", tire, model.tireInstance
	}
	
	void testEditWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		assertEquals "redirect action", "list", redirectArgs.action
	}
	
	void testUpdateWithValidId() {
		mockDomain Tire, [tire]
		
		tire.metaClass.save = {-> return true }
		tire.metaClass.hasErrors = {-> return false }
		
		def logMock = mockFor(LogService)
		logMock.demand.saveLog() {}
		controller.logService = logMock.createMock() 
		
		logInUser()
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testUpdateWithValidIdButErrors() {
		mockDomain Tire, [tire]
		
		tire.metaClass.save = {-> return false }
		tire.metaClass.hasErrors = {-> return true }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "edit", controller.modelAndView.viewName
		assertNotNull "Tire should not be null", controller.modelAndView.model.linkedHashMap.tireInstance
	}
	
	void testUpdateWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithValidId() {
		mockDomain Tire, [tire]
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testDeleteWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		assertEquals "redirect action", "list", controller.redirectArgs.action
	}
	
	void testSearch() {
		def model = controller.search()
		assertNotNull model.tireInstance
	}
	
	void testFastSearchWithQuery() {
		controller.params.txtFastSearch = "Pirelli"
		controller.fastSearch()
		assertEquals "redirect action", "list", controller.redirectArgs.action
		assertEquals "Query params should be equal", controller.params.txtFastSearch, controller.redirectArgs.params.q
		assertEquals "Type param should be fast", "fast", controller.redirectArgs.params.type
	}
	
	void testNormalSearch() {
		controller.params.width = 195
		controller.params.profile = 55
		controller.params.diameter = 15
		controller.params.speedIndex = "L"
		controller.params.tireType = "Sommer"
		controller.params.brand = "Pirelli"
		controller.normalSearch()
		assertEquals "redirect action", "list", controller.redirectArgs.action
		assertEquals "Type params should be normal", "normal", controller.redirectArgs.params.type
		assertEquals "Query params should be equal", controller.params.width, controller.redirectArgs.params.width
		assertEquals "Query params should be equal", controller.params.profile, controller.redirectArgs.params.profile
		assertEquals "Query params should be equal", controller.params.diameter, controller.redirectArgs.params.diameter
		assertEquals "Query params should be equal", controller.params.speedIndex, controller.redirectArgs.params.speedIndex
		assertEquals "Query params should be equal", controller.params.tireType, controller.redirectArgs.params.tireType
		assertEquals "Query params should be equal", controller.params.brand, controller.redirectArgs.params.brand
	}
}
