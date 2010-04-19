package no.pstop.webapp;

import groovy.util.GroovyTestCase;
import grails.test.*

class TireControllerIntegrationTests extends GroovyTestCase {
	Tire t1, t2, t3, t4
	def controller
	
	protected void setUp() {
		super.setUp()
		t1 = new Tire(id: 1, partNr: "1722550NOKHKPLR98R", brand: "Nokian", tireName: "Hakka", width: 100, profile: 20, construction: "R", diameter: 17,
				loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer", retailPrice: 1095, notice:"Demodekk").save(flush:true)
		t2 = new Tire(id: 2, partNr: "1419570RGODGA91H", brand: "Goodyear", tireName: "ga", width: 195, profile: 70, construction: "R", diameter: 14,
				loadIndex: 50, speedIndex: "T", pattern: "Speed beast", tireType: "Vinter (pigg)", retailPrice: 1150, notice:"").save(flush:true)
		t3 = new Tire(id: 3, partNr: "1620575RMICAGISOMM110R", brand: "Michelin", tireName: "agilis", width: 205, profile: 75, construction: "R", diameter: 16,
				loadIndex: 60, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer", retailPrice: 990, notice:"").save(flush:true)
		t4 = new Tire(id: 4, partNr: "1721545RBCTTLS800XL", brand: "Sumitomo", tireName: "Speed", width: 215, profile: 45, construction: "R", diameter: 17,
				loadIndex: 75, speedIndex: "T", pattern: "Speed beast", tireType: "Vinter (pigg)", retailPrice: 1095, notice:"Brukt").save(flush:true)
		
		controller = new TireController()
	}
	
	protected void tearDown() {
		super.tearDown()
		t1.delete(flush:true)
		t2.delete(flush:true)
		t3.delete(flush:true)
		t4.delete(flush:true)
	}
	
	private setParams(String type, String width, String profile, String diameter, String speedIndex, String tireType,
	String brand){
		controller.params.type = type
		controller.params.width = width
		controller.params.profile = profile
		controller.params.diameter = diameter
		controller.params.speedIndex = speedIndex
		controller.params.tireType = tireType
		controller.params.brand = brand
	}
	
	void testListWithSpecialFastSearchQuery(){
		controller.params.q = "100207s"
		controller.params.type = "fast"
		def expectedTireList = [t1]
		def model = controller.list()
		
		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), model.tireInstanceList.toString()
		assertEquals "Both lists should have the same number of tires", expectedTireList.size(), model.tireInstanceTotal
	}
	
	void testListWithFastSearchQuery(){
		controller.params.q = "sommer"
		controller.params.type = "fast"
		def expectedTireList = [t1, t3]
		def model = controller.list()
		
		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), model.tireInstanceList.toString()
		assertEquals "Both lists should have the same number of tires", expectedTireList.size(), model.tireInstanceTotal
	}
	
	void testNormalSearchQueryWithoutInput(){
		setParams("normal", "", "", "", "", "", "")
		def expectedTireList = [t1, t2, t3, t4]
		def model = controller.list()
		
		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), model.tireInstanceList.toString()
		assertEquals "Both lists should have the same number of tires", expectedTireList.size(), model.tireInstanceTotal
	}
	
	void testNormalSearchQuery(){
		setParams("normal", "", "", "", "", "Vinter (pigg)", "")
		def expectedTireList = [t2, t4]
		def model = controller.list()

		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), model.tireInstanceList.toString()
		assertEquals "Both lists should have the same number of tires", expectedTireList.size(), model.tireInstanceTotal
	}
	
	void testListWithNoQuery(){
		def expectedTireList = [t1, t2, t3, t4]
		def model = controller.list()
		
		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), model.tireInstanceList.toString()
		assertEquals "Both lists should have the same number of tires", expectedTireList.size(), model.tireInstanceTotal
	}
}
