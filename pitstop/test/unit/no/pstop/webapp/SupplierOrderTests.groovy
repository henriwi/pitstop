package no.pstop.webapp

import grails.test.*

class SupplierOrderTests extends GrailsUnitTestCase {
	def supplierOrder
    protected void setUp() {
		super.setUp()
		mockForConstraintsTests SupplierOrder
		supplierOrder = new SupplierOrder(orderNumber: "86789", orderDate: new Date(), supplier: "Pirelli", notice: "")
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testGenerateSupplierOrderWithInvalidNotice() {
		for(int i = 0; i < 1001; i++){
			supplierOrder.notice += "A"
		}
		
		assertFalse "Test failed, expected invalid notice", supplierOrder.validate()
		def badField = supplierOrder.errors.getFieldError("notice")
		assertNotNull "I'm expecting to find error in notice", badField
	}
	
	void testGenerateSupplierOrderWithInvalidSupplier() {
		for(int i = 0; i < 100; i++){
			supplierOrder.supplier += "A"
		}
		
		assertFalse "Test failed, expected invalid supplier", supplierOrder.validate()
		def badField = supplierOrder.errors.getFieldError("supplier")
		assertNotNull "I'm expecting to find error in supplier", badField
	}
}
