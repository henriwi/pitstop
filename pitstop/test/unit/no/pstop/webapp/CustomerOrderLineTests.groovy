package no.pstop.webapp

import grails.test.*

class CustomerOrderLineTests extends GrailsUnitTestCase {
	def tire
	def customerOrderLine
	
	protected void setUp() {
        super.setUp()
				
		mockForConstraintsTests CustomerOrderLine
		tire = new Tire(width: 190, profile: 60, construction: "R", diameter: 17, partNr: "123AB",
				loadIndex: 165, speedIndex: "H", pattern: "m12", tireType: "Sommer", brand: "Nokian", tireName: "T-Zero", 
				notice:"Demodekk", retailPrice: 1095, numberInStock: 4)	
		customerOrderLine = new CustomerOrderLine(tire: tire, customerOrder: new CustomerOrder(),
				numberOfReservedTires: 4, price: 950.0, deliveredDate: null)
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGenerateCustomerOrderLineWithInvalidNumberOfReservedTires() {
    	customerOrderLine.numberOfReservedTires = 0
		
		assertFalse "Test failed, expecting invalid numberOfReservedTires", customerOrderLine.validate()
		def badField = customerOrderLine.errors.getFieldError('numberOfReservedTires')
		assertNotNull "Expecting error in field numberOfReservedTires", badField
	}
	
	void testGenerateCustomerOrderLineWithInvalidPrice() {
		customerOrderLine.price = -2
		
		assertFalse "Test failed, expecting invalid price", customerOrderLine.validate()
		def badField = customerOrderLine.errors.getFieldError('price')
		assertNotNull "Expecting error in field price", badField
	}
	
	void testToString() {
		assertEquals "$tire (Antall: $customerOrderLine.numberOfReservedTires)", customerOrderLine.toString()
	}
}
