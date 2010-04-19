package no.pstop.webapp

import grails.test.*

class SupplierOrderLineTests extends GrailsUnitTestCase {
	def tireOccurrence
	def supplierOrderLine
	
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests TireOccurrence
		mockForConstraintsTests SupplierOrderLine
		tireOccurrence = new TireOccurrence(tire: new Tire(), price: 89.89, numberInStock: 4, numberOfReserved: 3,
				numberOfOrdered: 8, discount: 20, environmentalFee: 10, registrationDate: new Date())
		supplierOrderLine = new SupplierOrderLine(tireOccurrence: tireOccurrence, numberOfOrderedTireOccurrences: 4,
				price: 950.0, deliveryDate: new Date())
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testGenerateSupplierOrderLineWithInvalidNumberOfOrderedTireOccurrences() {
		supplierOrderLine.numberOfOrderedTireOccurrences = 0
		
		assertFalse "Test failed, expecting invalid numberOfOrderedTireOccurrences", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('numberOfOrderedTireOccurrences')
		assertNotNull "Expecting error in field numberOfOrderedTireOccurrences", badField
	}
	
	void testGenerateSupplierOrderLineWithInvalidPrice() {
		supplierOrderLine.price = -2
		
		assertFalse "Test failed, expecting invalid price", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('price')
		assertNotNull "Expecting error in field price", badField
	}
}
