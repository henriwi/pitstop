package no.pstop.webapp

import grails.test.*

class CustomerTests extends GrailsUnitTestCase {
	def customer
    protected void setUp() {
        super.setUp()
		mockForConstraintsTests Customer
		customer = new Customer(firstName: "Dekk Roar", lastName: "Dekkesen", phoneNumber: "19555095", address: "Dekkveien 1",
						postalCode: "0195", city: "Radiator By", email: "felger@dekk.no", company: "Dekkilicious", notice: "God kunde")
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGenerateCustomer() {
		assertEquals "Dekk Roar", customer.firstName
		assertEquals "Dekkesen", customer.lastName
		assertEquals "19555095", customer.phoneNumber
		assertEquals "Dekkveien 1", customer.address
		assertEquals "0195", customer.postalCode
		assertEquals "Radiator By", customer.city
		assertEquals "felger@dekk.no", customer.email
		assertEquals "Dekkilicious", customer.company
		assertEquals "God kunde", customer.notice
    }
	
	void testGenerateCustomerWithEmptyFirstName() {
		customer.firstName = ""
		
		assertFalse "Test failed, expected empty firstName", customer.validate()
		def badField = customer.errors.getFieldError("firstName")
		assertNotNull "I'm expecting to find error in firstName", badField
	}
	
	void testGenerateCustomerWithInvalidFirstName() {
		customer.firstName = "?"
		
		assertFalse "Test failed, expected invalid firstName", customer.validate()
		def badField = customer.errors.getFieldError("firstName")
		assertNotNull "I'm expecting to find error in firstName", badField
	}
	
	void testGenerateCustomerWithEmptyLastName() {
		customer.lastName = ""
		
		assertFalse "Test failed, expected empty lastName", customer.validate()
		def badField = customer.errors.getFieldError("lastName")
		assertNotNull "I'm expecting to find error in lastName", badField
	}
	
	void testGenerateCustomerWithInvalidLastName() {
		customer.lastName = "?"
		
		assertFalse "Test failed, expected invalid lastName", customer.validate()
		def badField = customer.errors.getFieldError("lastName")
		assertNotNull "I'm expecting to find error in lastName", badField
	}
	
	void testGenerateCustomerWithInvalidPhoneNumber() {
		customer.phoneNumber = "<>"
		
		assertFalse "Test failed, expected invalid phoneNumber", customer.validate()
		def badField = customer.errors.getFieldError("phoneNumber")
		assertNotNull "I'm expecting to find error in phoneNumber", badField
	}
	
	void testGenerateCustomerWithInvalidAddress() {
		customer.address = "<>"
		
		assertFalse "Test failed, expected invalid address", customer.validate()
		def badField = customer.errors.getFieldError("address")
		assertNotNull "I'm expecting to find error in address", badField
	}
	
	void testGenerateCustomerWithInvalidPostalCode() {
		customer.postalCode = "?"
		
		assertFalse "Test failed, expected invalid postalCode", customer.validate()
		def badField = customer.errors.getFieldError("postalCode")
		assertNotNull "I'm expecting to find error in postalCode", badField
	}
	
	void testGenerateCustomerWithInvalidCity() {
		customer.city = "?"
		
		assertFalse "Test failed, expected invalid city", customer.validate()
		def badField = customer.errors.getFieldError("city")
		assertNotNull "I'm expecting to find error in city", badField
	}
	
	void testGenerateCustomerWithInvalidEmail() {
		customer.email = "per.persen@@hotmail.com"
		
		assertFalse "Test failed, expected invalid email", customer.validate()
		def badField = customer.errors.getFieldError("email")
		assertNotNull "I'm expecting to find error in email", badField
	}
	
	void testGenerateCustomerWithInvalidCompany() {
		customer.company = "?"
		
		assertFalse "Test failed, expected invalid company", customer.validate()
		def badField = customer.errors.getFieldError("company")
		assertNotNull "I'm expecting to find error in company", badField
	}
	
	void testGenerateCustomerWithInvalidNotice() {
		
		for(int i = 0; i < 2000; i++)
		{
			customer.notice += "A"
		}
		
		assertFalse "Test failed, expected invalid notice", customer.validate()
		def badField = customer.errors.getFieldError("notice")
		assertNotNull "I'm expecting to find error in notice", badField
	}
	
	void testToString(){
		assertEquals "Dekk Roar Dekkesen", customer.toString()
	}
	
	void testShowNoticeWith20FirstLettersWhenNoticeIsUnder20Letters() {
		customer.notice = "Notice"
		assertEquals "Notice", customer.showNoticeWith20FirstLetters()
	}
	
	void testShowNoticeWith20FirstLettersWhenNoticeIsOver20Letters() {
		customer.notice = "Notice notice notice notice notice"
		assertEquals "Notice notice notice ...", customer.showNoticeWith20FirstLetters()
	}
	
	void testShowNoticeWith20FirstLettersWhenNoticeIsEmpty() {
		customer.notice = ""
		assertEquals "", customer.showNoticeWith20FirstLetters()
	}
	
	void testShowNoticeWith20FirstLettersWhenNoticeIsNull() {
		customer.notice = null
		assertEquals null, customer.showNoticeWith20FirstLetters()
	}
}
