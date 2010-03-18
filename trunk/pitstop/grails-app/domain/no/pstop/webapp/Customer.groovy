package no.pstop.webapp

class Customer {
	static searchable = true
	static hasMany = [tireHotelOccurrences: TireHotelOccurrence, customerOrders: CustomerOrder]
	String firstName
	String lastName
	String phoneNumber
	String address
	String postalCode
	String city
	String email
	String company
	String notice
	
    static constraints = {
		firstName(blank:false, matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\_\\.]{0,40}")
		lastName(blank:false, matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\_\\.]{0,40}")
		phoneNumber(matches: "[\\+]?\\d{0,29}")
		address(matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\.\\_]{0,50}")
		postalCode(matches: "[\\d\\-]{0,15}")
		city(matches:"[a-zA-Z0-9æøåÆØÅ\\s\\-\\_]{0,40}")
		email(email:true)
		company(matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\.\\_]{0,50}")
		notice(size:0..1000)
    }

	String autoCompleteToString(){
		"${firstName} ${lastName} - ${phoneNumber}"
	}

	String toString(){
		"${firstName} ${lastName}" 
	}
}