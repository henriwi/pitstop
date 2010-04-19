package no.pstop.webapp
import groovy.util.GroovyTestCase;

import grails.test.*

class CustomerControllerIntegrationTests extends GroovyTestCase {
	Customer customer1, customer2, customer3
	def controller
	def post
	
    protected void setUp() {
        super.setUp()
	    post = new PostalCodeAndPlace(postalCode:"0195",place:"Radiator By").save(flush: true)

        customer1 = new Customer(firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
		postalCodeAndPlace: post, email: "felger@dekk.no", company: "Dekkilicious", notice: "God kunde").save(flush: true)
		
		customer2 = new Customer(firstName: "Dekk Ingunn", lastName: "Felgesen", phoneNumber: "94950854", address: "Felgesvingen 8",
		postalCodeAndPlace: post, email: "felger@felg.no", company: "Dekkilicious", notice: "Ganske god kunde").save(flush: true)
		
		customer3 = new Customer(firstName: "Hans Fredrik Olsen", lastName: "Felgesen", phoneNumber: "112", address: "Helgegata 8",
		postalCodeAndPlace: post, email: "felger@felg.no", company: "Dekkpartner", notice: "Ganske god kunde").save(flush: true)
		
		controller = new CustomerController()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testListWithSearchQuery() {
    	controller.params.q = "Dekkilicious"
		def expectedList = [customer1, customer2]
		def model = controller.list()
		
		assertEquals "Expected list should be the same as the returned", expectedList.toString(), model.customerInstanceList.toString()
		assertEquals "Number of expected should be the same as returned", expectedList.size(), model.customerInstanceTotal
    }
	
	void testListWithoutSearchQuery() {
		def expectedList = [customer1, customer2, customer3]
		def model = controller.list()
		
		assertEquals "Expected list should be the same as the returned", expectedList.toString(), model.customerInstanceList.toString()
		assertEquals "Number of expected should be the same as returned", expectedList.size(), model.customerInstanceTotal
	}
}
