package no.pstop.webapp

class PostalCodeAndPlace {

	static hasMany = [customers: Customer]
    String postalCode
	String place		
	
    static constraints = {
		postalCode(blank: false, matches: "[0-9]{4}")
		place(blank: false)
    }
}
