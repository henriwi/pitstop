package no.pstop.webapp

class Tire {
	long id
	String partNr
	Integer width
	Integer profile
	String construction
	Integer diameter
	Integer loadIndex
	String speedIndex
	String pattern
	String tireType
	
	static constraints = {
		partNr(matches:"[a-zA-Z0-9]+", blank:false, unique:true)
		width(min:100, max:350)
		profile(min:20, max:85)
		construction(matches:"R", blank:false)
		diameter(min:10, max:50)
		loadIndex(min:40, max:240)
		speedIndex(inList:["L","M","N","P","Q","R","S","T","U","H","V","W","Y","Z","ZR"], blank:false)
		//TODO
		pattern(matches:"[a-zA-Z0-9\\s]{0,30}", blank:false)
		tireType(inList:["Sommer","Vinter (pigg)","Vinter (piggfri)"], blank:false)
	}
}
