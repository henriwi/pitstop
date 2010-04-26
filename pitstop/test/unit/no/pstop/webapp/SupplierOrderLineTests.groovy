package no.pstop.webapp

import grails.test.*

class SupplierOrderLineTests extends GrailsUnitTestCase {
	def supplierOrderLine
	
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests SupplierOrderLine
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
	
	void testGenerateSupplierOrderLineWithEmptyPrice(){
		supplierOrderLine.price = null
		
		assertFalse "Test failed, expected empty price", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('price')
		assertNotNull "Expecting error in field price"
	}
	
	void testGenerateSupplierOrderLineWithDiscountLessThanZero(){
		supplierOrderLine.discount = -4
		
		assertFalse "Test failed, expected discount less than zero", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('discount')
		assertNotNull "Expecting error in field discount"
	}
	
	void testGenerateSupplierOrderLineWithDiscountMoreThanHundred(){
		supplierOrderLine.discount = 101
		
		assertFalse "Test failed, expected discount more than one hundred", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('discount')
		assertNotNull "Expecting error in field discount"
	}
	
	void testGenerateSupplierOrderLineWithInvalidEnvironmentalFee(){
		supplierOrderLine.environmentalFee = -2
		
		assertFalse "Test failed, expecting invalid environmentalFee", supplierOrderLine.validate()
		def badField = supplierOrderLine.errors.getFieldError('environmentalFee')
		assertNotNull "Expecting error in field environmentalFee"
	}
}
