package no.pstop.webapp

import grails.test.*

class CustomerOrderLineTests extends GrailsUnitTestCase {
	def tireOccurrence
	def customerOrderLine
	
	protected void setUp() {
        super.setUp()
				
		mockForConstraintsTests TireOccurrence
		mockForConstraintsTests CustomerOrderLine
		tireOccurrence = new TireOccurrence(tire: new Tire(), price: 89.89, numberInStock: 4, numberOfReserved: 3,
				numberOfOrdered: 8, discount: 20, environmentalFee: 10, registrationDate: new Date())
		customerOrderLine = new CustomerOrderLine(tireOccurrence: tireOccurrence, numberOfOrderedTireOccurrences: 4,
				price: 950.0, deliveryDate: new Date())
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGenerateCustomerOrderLineWithInvalidNumberOfOrderedTireOccurrences() {
    	customerOrderLine.numberOfOrderedTireOccurrences = 0
		
		assertFalse "Test failed, expecting invalid numberOfOrderedTireOccurrences", customerOrderLine.validate()
		def badField = customerOrderLine.errors.getFieldError('numberOfOrderedTireOccurrences')
		assertNotNull "Expecting error in field numberOfOrderedTireOccurrences", badField
	}
	
	void testGenerateCustomerOrderLineWithInvalidPrice() {
		customerOrderLine.price = -2
		
		assertFalse "Test failed, expecting invalid price", customerOrderLine.validate()
		def badField = customerOrderLine.errors.getFieldError('price')
		assertNotNull "Expecting error in field price", badField
	}
	/*
	void testGenerateCustomerOrderLineWithInvalidDeliveryDate() {
		customerOrderLine.deliveryDate = -2
		
		assertFalse "Test failed, expecting invalid deliveryDate", customerOrderLine.validate()
		def badField = customerOrderLine.errors.getFieldError('deliveryDate')
		assertNotNull "Expecting error in field deliveryDate", badField
	}
	*/
}
