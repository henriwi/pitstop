package no.pstop.webapp

import grails.test.*

class SupplierOrderTests extends GrailsUnitTestCase {
	def supplierOrder
    protected void setUp() {
		super.setUp()
		mockForConstraintsTests SupplierOrder
		supplierOrder = new SupplierOrder(supplier: "Pirelli", orderDate: new Date(), notice: "")
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testGenerateCustomerOrderWithInvalidNotice() {
		for(int i = 0; i < 2000; i++)
		{
			supplierOrder.notice += "A"
		}
		
		assertFalse "Test failed, expected invalid notice", supplierOrder.validate()
		def badField = supplierOrder.errors.getFieldError("notice")
		assertNotNull "I'm expecting to find error in notice", badField
	}
	
	void testToString() {
		supplierOrder.id = 1
		assertEquals "Ordre - 1", supplierOrder.toString()
	}
}
