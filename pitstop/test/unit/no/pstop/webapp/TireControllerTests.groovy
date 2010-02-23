package no.pstop.webapp

import grails.test.*

class TireControllerTests extends ControllerUnitTestCase {
	def t1, t2, t3 
	
	protected void setUp() {
		super.setUp()
		mockDomain Tire
		
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
	
	private setParams(Integer width, Integer profile, String construction, Integer diameter, String partNr, Integer loadIndex,
	String speedIndex, String pattern, String tireType, String brand, String tireName) {
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
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	/*void testListWithSearchQuery() {
		mockDomain(Tire, [t1,t2,t3])
		def mock = mockFor(Tire)
		controller.params.q = "192607s"
		controller.params.type="fast"
		Map model = controller.list()
		assertNotNull('list should be present in model', model.tireInstanceList)
		assertEquals('list size should match the number of mocked tires', 1, model.tireInstanceList.size())
		assertEquals(model.tireInstanceList[0], t1)
	}*/
	
	/*void testListWithNoSearchQuery() {
		mockDomain(Tire, [t1,t2,t3])
		def tireOccurrence1 = new TireOccurrence(id:1,tire:t1,price:60.5,numberInStock:1,registrationDate:new Date())
		def tireOccurrence2 = new TireOccurrence(id:2,tire:t2,price:60.5,numberInStock:1,registrationDate:new Date())
		def tireOccurrence3 = new TireOccurrence(id:3,tire:t3,price:60.5,numberInStock:1,registrationDate:new Date())
		mockDomain(TireOccurrence, [tireOccurrence1, tireOccurrence2, tireOccurrence3])
		
		Map model = controller.list()
		assertNotNull "list should be present in model", model.tireInstanceList
		assertEquals "list size should match the number of mocked tires", 3, model.tireInstanceList.size()
	}*/
	
	void testCreate() {
		def model = controller.create()
		assertNotNull model.tireInstance
	}
	
	void testSaveWithValidTire() {
		setParams(190, 60, "R", 17, "123AB", 165, "H", "m12", "Sommer", "Pirelli", "T-Zero")
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	
	void testSaveWithInvalidWidth() {
		setParams(-100, 60, "R", 17, "123AB", 165, "H", "m12", "Sommer", "Pirelli", "T-Zero")
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.save()
		
		assertEquals "redirect action", "create", controller.modelAndView.viewName
		assertNotNull "Tire should not be null", controller.modelAndView.model.linkedHashMap.tireInstance
	}
	
	void testShowWithValidId() {
		def tireOccurrence1 = new TireOccurrence(tire: t1, price: 1500, numberInStock: 4,
		registrationDate: new Date())
		def tireOccurrence2 = new TireOccurrence(tire: t1, price: 1300, numberInStock: 4,
				registrationDate: new Date() + 1)
		def tireOccurrenceList = [tireOccurrence2, tireOccurrence1]
		def tireOccurrenceTotalList = [tireOccurrence1, tireOccurrence2]
		
		mockDomain Tire, [t1]
		mockDomain TireOccurrence, [tireOccurrence1, tireOccurrence2]
		
		controller.params.id = 1
		def model = controller.show()
		assertEquals t1, model.tireInstance
		assertEquals "tireOccurenceList should be equal", tireOccurrenceList, model.tireOccurrenceInstanceList
		assertEquals "tireOccurenceTotalList should be equal", tireOccurrenceTotalList, model.tireOccurrenceInstanceTotalList
	}
	
	void testShowWithInvalidId() {
		mockDomain Tire, [t1]
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.show()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testEditWithValidId() {
		mockDomain Tire, [t1]
		controller.params.id = 1
		Map model = controller.edit()
		assertEquals "model.tireInstance", t1, model.tireInstance
	}
	
	void testEditWithInvalidId() {
		controller.params.id = 999
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.edit()
		assertEquals "redirect action", "list", redirectArgs.action
	}
	
	void testUpdateWithValidId() {
		Tire expectedTire = new Tire(id:1,width:192,profile:60,construction:"R",diameter:17,partNr:"123AB",
		loadIndex:165,speedIndex:"H",pattern:"m12",tireType:"Sommer",brand:"Pirelli",tireName:"T-Zero")
		mockDomain Tire, [expectedTire]
		
		expectedTire.metaClass.save = {-> return true }
		expectedTire.metaClass.hasErrors = {-> return false }
		
		controller.params.id = 1
		controller.metaClass.message = {args -> println "message: ${args}"} 
		controller.update()
		
		assertEquals "redirect action", "show", controller.redirectArgs.action
		assertEquals "redirect id", 1, controller.redirectArgs.id
	}
	
	void testUpdateWithValidIdButErrors() {
		mockDomain Tire, [t1]
		
		t1.metaClass.save = {-> return false }
		t1.metaClass.hasErrors = {-> return true }
		
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
		mockDomain Tire, [t1]
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
	
	void testFastSearch() {
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
