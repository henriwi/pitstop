package no.pstop.webapp

import grails.test.*

class SupplierOrderLineTests extends GrailsUnitTestCase {
	//def tireOccurrence
	def supplierOrderLine
	
    protected void setUp() {
        super.setUp()
		//mockForConstraintsTests TireOccurrence
		mockForConstraintsTests SupplierOrderLine
		/*tireOccurrence = new TireOccurrence(tire: new Tire(), price: 89.89, numberInStock: 4, numberOfReserved: 3,
				numberOfOrdered: 8, discount: 20, environmentalFee: 10, registrationDate: new Date())*/
		supplierOrderLine = new SupplierOrderLine(tire: new Tire(), supplierOrder: new SupplierOrder(), 
		numberOfOrderedTires: 4,price: 950.0, receivedDate: new Date(), discount: 10, environmentalFee: 12)
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testGenerateSupplierOrderLineWithInvalidNumberOfOrderedTires() {
		supplierOrderLine.numberOfOrderedTires = 0
		
		assertFalse "Test failed, expecting invalid numberOfOrderedTires", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('numberOfOrderedTires')
		assertNotNull "Expecting error in field numberOfOrderedTires", badField
	}
	
	void testGenerateSupplierOrderLineWithEmptyNumberOfOrderedTires(){
		supplierOrderLine.numberOfOrderedTires = null
		
		assertFalse "Test failed, expected empty numberOfOrderedTires", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError("numberOfOrderedTires")
		assertNotNull "I'm expecting to find error in numberOfOrderedTires", badField
	}
	
	void testGenerateSupplierOrderLineWithInvalidPrice() {
		supplierOrderLine.price = -2
		
		assertFalse "Test failed, expecting invalid price", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('price')
		assertNotNull "Expecting error in field price", badField
	}
}
