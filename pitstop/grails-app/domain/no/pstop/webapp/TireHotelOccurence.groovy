package no.pstop.webapp

class TireHotelOccurence {
	
	String tireLocation
	String registrationNumber
	String carType
	Customer customer
	String tireType
	Date inDate
	Date outDate
	String notice
	
    static constraints = {
		tireLocation(blank: false, matches:"\\w[\\-\\_\\w]+")
    }
}
