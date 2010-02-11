package no.pstop.webapp

import grails.test.*

class TireControllerTests extends ControllerUnitTestCase {
	protected void setUp() {
		super.setUp()
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	/*void testListWithSearchQuery() {
		def t1 = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli")
		def t2 = new Tire(id:2,width:192,profile:60,construction:"R",diameter:17,partNr:"123AC",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli")
		def t3 = new Tire(id:3,width:192,profile:60,construction:"R",diameter:17,partNr:"123AD",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli")
		
		mockDomain(Tire, [t1,t2,t3])
		Tire.metaClass.static.search = {args -> return "Sommer" }
		Tire.metaClass.static.search.results = {args -> return t1 }
		//def mockTire = mockFor(Tire)
		//mockTire.demand.search = {-> return t1}
		controller.params.q = "Sommer"
		
		Map model = controller.list()
		assertNotNull('list should be present in model', model.tireInstanceList)
		assertEquals('list size should match the number of mocked tires', 3, model.tireInstanceList.size())
	}*/
	
	void testListWithNoSearchQuery() {
		def t1 = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		def t2 = new Tire(id:2,width:192,profile:60,construction:"R",diameter:17,partNr:"123AC",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		def t3 = new Tire(id:3,width:192,profile:60,construction:"R",diameter:17,partNr:"123AD",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		
		mockDomain(Tire, [t1,t2,t3])
		
		Map model = controller.list()
		assertNotNull('list should be present in model', model.tireInstanceList)
		assertEquals('list size should match the number of mocked tires', 3, model.tireInstanceList.size())
	}

	void testCreate() {
		mockDomain Tire
		def model = controller.create()
		assertNotNull model.tireInstance
	}
	
	void testSaveWithValidTire() {
		mockDomain Tire
		controller.params.width = 192
		controller.params.profile = 60
		controller.params.construction = "R"
		controller.params.diameter = 17
		controller.params.partNr = "123AB"
		controller.params.loadIndex = 165
		controller.params.speedIndex = "H"
		controller.params.pattern = "m12"
		controller.params.tireType = "Sommer"
		controller.params.brand = "Pirelli"
		controller.params.tireName = "T-Zero"
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()
		
		assertEquals('redirect action', "show", controller.redirectArgs.action)
		assertEquals('redirect id', 1, controller.redirectArgs.id)
	}
	
	void testSaveWithInvalidWidth() {
		mockDomain Tire
		controller.params.width = -100
		controller.params.profile = 60
		controller.params.construction = "R"
		controller.params.diameter = 17
		controller.params.partNr = "123AB"
		controller.params.loadIndex = 165
		controller.params.speedIndex = "H"
		controller.params.pattern = "m12"
		controller.params.tireType = "Sommer"
		controller.params.brand = "Pirelli"
		controller.params.tireName = "T-Zero"
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()
		
		assertEquals('redirect action', "create", controller.modelAndView.viewName)
		assertNotNull('Tire should not be null', controller.modelAndView.model.linkedHashMap.tireInstance)
	}
	
	void testShowWithValidId() {
		def tire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		mockDomain Tire, [tire]
		controller.params.id = 1
		def model = controller.show()
		assertEquals tire, model.tireInstance
	}
	
	void testShowWithInvalidId() {
		def tire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		mockDomain Tire, [tire]
		controller.params.id = 2
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		Tire expectedTire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		mockDomain(Tire, [expectedTire])
		controller.params.id = 1
		Map model = controller.edit()
		assertEquals('model.tireInstance', expectedTire, model.tireInstance)
	}
	
	void testEditWithInvalidId() {
		mockDomain(Tire)
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		assertEquals('redirect action', "list", redirectArgs.action)
	}
	
	void testUpdateWithValidId() {
		Tire expectedTire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		mockDomain(Tire, [expectedTire])
		
		expectedTire.metaClass.save = {-> return true }
		expectedTire.metaClass.hasErrors = {-> return false }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals('redirect action', "show", controller.redirectArgs.action)
		assertEquals('redirect id', 1, controller.redirectArgs.id)
	}
	
	void testUpdateWithValidIdButErrors() {
		Tire expectedTire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		mockDomain(Tire, [expectedTire])
		
		expectedTire.metaClass.save = {-> return false }
		expectedTire.metaClass.hasErrors = {-> return true }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals('redirect action', "edit", controller.modelAndView.viewName)
		assertNotNull('Tire should not be null', controller.modelAndView.model.linkedHashMap.tireInstance)
	}
	
	void testUpdateWithInvalidId() {
		mockDomain(Tire)
		
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals('redirect action', "list", controller.redirectArgs.action)
	}
	
	void testDeleteWithValidId() {
		mockDomain(Tire, [new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")])
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		assertEquals('redirect action', "list", controller.redirectArgs.action)
	}
	
	void testDeleteWithInvalidId() {
		mockDomain(Tire)
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.delete()
		assertEquals('redirect action', "list", controller.redirectArgs.action)
	}
}
