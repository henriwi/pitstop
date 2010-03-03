package no.pstop.webapp

class TireHotelOccurrence {
	
	String tireLocation
	String registrationNumber
	String carType
	Customer customer
	String tireType
	Date inDate
	Date outDate
	String notice
	
    static constraints = {
		tireLocation(blank: false, nullable: false, matches:"([]a-zA-ZøæåØÆÅ0-9])[a-zA-ZøæåØÆÅ0-9\\-\\_]{0,20}")
		registrationNumber(blank: false, nullable: false, matches:"[a-zA-ZøæåØÆÅ0-9]+[\\-\\s]?[a-zA-ZøæåØÆÅ0-9]{0,7}")
		carType(matches:"[a-zA-ZøæåØÆÅ0-9\\-\\_\\s]{0,30}")
		tireType(blank: false, nullable: false, matches:"[a-zA-ZøæåØÆÅ0-9\\-\\(\\)\\/\\+\\s]{0,30}")
		inDate(blank:false, nullable: false)
		notice(size:0..1000)
    }
}
