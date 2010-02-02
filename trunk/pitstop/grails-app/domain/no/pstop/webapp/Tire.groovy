package no.pstop.webapp

class Tire {
	long id
	String partNr
	Integer width
	Integer profile
	Character construction
	Integer diameter
	Integer loadIndex
	String speedIndex
	String pattern
	String tireType
	
	static constraints = {
		width(min:100, max:350)
		profile(min:20, max:85)
	}
}
