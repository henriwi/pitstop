package no.pstop.webapp

import grails.test.*

class TireControllerTests extends ControllerUnitTestCase {
	def t1, t2, t3 
	
	protected void setUp() {
		super.setUp()
		
		t1 = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli")
		t2 = new Tire(id:2,width:192,profile:60,construction:"R",diameter:18,partNr:"123AC",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli")
		t3 = new Tire(id:3,width:192,profile:60,construction:"R",diameter:19,partNr:"123AD",
				loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli")
		
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	/*void testListWithSearchQuery() {
		mockDomain(Tire, [t1,t2,t3])
		//def mockTire = mockFor(Tire)
		//mockTire.demand.search = {-> return t1}
		controller.params.q = "192607s"
		controller.params.type="fast"
		
		Map model = controller.list()
		assertNotNull('list should be present in model', model.tireInstanceList)
		assertEquals('list size should match the number of mocked tires', 1, model.tireInstanceList.size())
		assertEquals(model.tireInstanceList[0], t1)
	}*/
	
	void testListWithNoSearchQuery() {
		
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
		def tireOccurrence1 = new TireOccurrence(tire: t1, price: 1500, numberInStock: 4,
				registrationDate: new Date())
		def tireOccurrence2 = new TireOccurrence(tire: t1, price: 1300, numberInStock: 4,
				registrationDate: new Date())
		def tireOccurrenceList = [tireOccurrence1, tireOccurrence2]
		
		mockDomain Tire, [t1]
		mockDomain TireOccurrence, [tireOccurrence1, tireOccurrence2]
		
		controller.params.id = 1
		def model = controller.show()
		assertEquals t1, model.tireInstance
		assertEquals tireOccurrenceList, model.tireOccurrenceInstanceList
	}
	
	void testShowWithInvalidId() {
		mockDomain Tire, [t1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain(Tire, [t1])
		controller.params.id = 1
		Map model = controller.edit()
		assertEquals "model.tireInstance", t1, model.tireInstance
	}
	
	void testEditWithInvalidId() {
		mockDomain(Tire)
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		assertEquals("redirect action", "list", redirectArgs.action)
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
		
		assertEquals("redirect action", "show", controller.redirectArgs.action)
		assertEquals("redirect id", 1, controller.redirectArgs.id)
	}
	
	void testUpdateWithValidIdButErrors() {
		mockDomain(Tire, [t1])
		
		t1.metaClass.save = {-> return false }
		t1.metaClass.hasErrors = {-> return true }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals("redirect action", "edit", controller.modelAndView.viewName)
		assertNotNull("Tire should not be null", controller.modelAndView.model.linkedHashMap.tireInstance)
	}
	
	void testUpdateWithInvalidId() {
		mockDomain(Tire)
		
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals('redirect action', "list", controller.redirectArgs.action)
	}
	
	void testDeleteWithValidId() {
		mockDomain(Tire, [t1])
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
	
	void testSearch() {
		mockDomain Tire
		def model = controller.search()
		assertNotNull model.tireInstance
	}
	
	void testFastSearch() {
		controller.params.txtFastSearch = "Pirelli"
		controller.fastSearch()
		assertEquals('redirect action', "list", controller.redirectArgs.action)
		assertEquals('Query params should be equal', controller.params.txtFastSearch, controller.redirectArgs.params.q)
		assertEquals('Type param should be fast', "fast", controller.redirectArgs.params.type)
	}
}
