package no.pstop.webapp

import groovy.util.GroovyTestCase;
import grails.test.*

class TireIntegrationTests extends GroovyTestCase {
	static final regexFastSearch = /(\d{3})(\d{2})(\d{1})(s|v|S|V)/
	def max = 10
	def offset = 0
	Tire t1, t2, t3, t4
	
	protected void setUp() {
		super.setUp()
		
		t1 = new Tire(id: 1, partNr: "1722550NOKHKPLR98R", brand: "Nokian", tireName: "Hakka", width: 100, profile: 20, construction: "R", diameter: 17,
				loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer", retailPrice: 1095, numberInStock: 4, notice:"Demodekk", enabled: true).save(flush:true)
		t2 = new Tire(id: 2, partNr: "1419570RGODGA91H", brand: "Goodyear", tireName: "ga", width: 195, profile: 70, construction: "R", diameter: 14,
				loadIndex: 50, speedIndex: "T", pattern: "Speed beast", tireType: "Vinter (pigg)", retailPrice: 1150, numberInStock: 2, notice:"", enabled: true).save(flush:true)
		t3 = new Tire(id: 3, partNr: "1620575RMICAGISOMM110R", brand: "Michelin", tireName: "agilis", width: 205, profile: 75, construction: "R", diameter: 16,
				loadIndex: 60, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer", retailPrice: 990, numberInStock: 6, notice:"", enabled: true).save(flush:true)
		t4 = new Tire(id: 4, partNr: "1721545RBCTTLS800XL", brand: "Sumitomo", tireName: "Speed", width: 215, profile: 45, construction: "R", diameter: 17,
				loadIndex: 75, speedIndex: "T", pattern: "Speed beast", tireType: "Vinter (pigg)", retailPrice: 1095, numberInStock: 4, notice:"Brukt", enabled: true).save(flush:true)
	}
	
	protected void tearDown() {
		super.tearDown()
		t1.delete(flush:true)
		t2.delete(flush:true)
		t3.delete(flush:true)
		t4.delete(flush:true)
	}
	
	void testFastSearch() {
		def query = "100207s" =~ regexFastSearch
		def showTrueOrFalse = "true"
		def tireList = Tire.fastSearch(query,max,offset, showTrueOrFalse)
		def expectedTireList = [t1]
		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), tireList.toString()
	}
	
	void testNormalSearchWithAllParams() {
		def tireList = Tire.normalSearch("100", "20", "17", "L", "Sommer", "Nokian", max, offset)
		def expectedTireList = [t1]
		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), tireList.toString()
	}
	
	void testNormalSearchWithOneParam() {
		def tireList = Tire.normalSearch("", "", "17", "", "", "", max, offset)
		def expectedTireList = [t1, t4]
		assertEquals "Expected list should be the same as the returned list", expectedTireList.toString(), tireList.toString()
	}
	
	//TODO lag test når man sorterer på tiljengelig. Mock opp, expect list og hva man får ut.
}
