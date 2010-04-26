package no.pstop.webapp

import grails.test.*

class CustomerOrderTests extends GrailsUnitTestCase {
		def customerOrder
		def customer
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests Customer
		mockForConstraintsTests CustomerOrder
		customer = new Customer(firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
				postalCode: "0195", city: "Radiator By", email: "felger@dekk.no", company: "Dekkilicious", notice: "God kunde")
		customerOrder = new CustomerOrder(customer: customer, orderDate: new Date(), notice: "")
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testGenerateCustomerOrderWithInvalidNotice() {
		for(int i = 0; i < 2000; i++)
		{
			customerOrder.notice += "A"
		}
		
		assertFalse "Test failed, expected invalid notice", customerOrder.validate()
		def badField = customerOrder.errors.getFieldError("notice")
		assertNotNull "I'm expecting to find error in notice", badField
	}
}
