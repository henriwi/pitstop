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
		width(range:100..350)
	}
}
