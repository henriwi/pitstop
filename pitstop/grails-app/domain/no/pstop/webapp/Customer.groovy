package no.pstop.webapp

class Customer {
	static final lengthOfNoticeInListView = 10
	
	static searchable = true
	static hasMany = [tireHotelOccurrences: TireHotelOccurrence, customerOrders: CustomerOrder]
	static belongsTo = [postalCodeAndPlace: PostalCodeAndPlace]

	String firstName
	String lastName
	String phoneNumber
	String address
	String email
	String company
	String notice
	
    static constraints = {
		firstName(blank: false, matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\_\\.]{0,40}")
		lastName(blank: false, matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\_\\.]{0,40}")
		phoneNumber(matches: "[\\+]?\\d{0,29}")
		address(matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\.\\_]{0,50}")
		email(email: true)
		company(matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\.\\_]{0,50}")
		notice(size: 0..1000)
		postalCodeAndPlace(nullable: false)
    }

	String autoCompleteToString(){
		"${firstName} ${lastName} ${phoneNumber != null ? phoneNumber : '-'}"
	}

	String toString(){
		"${firstName} ${lastName}" 
	}
	
	String showNoticeWith10FirstLetters() {
		if (notice?.length() > lengthOfNoticeInListView) {
			String firstLetters = notice?.substring(0, lengthOfNoticeInListView)
			firstLetters + " ..."
		}
		else
			notice
	}
}
