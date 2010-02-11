package no.pstop.webapp

class Tire {
	static searchable = true
	static hasMany = [ tireOccurrences : TireOccurrence ]

	long id
	String partNr
	String brand
	String tireName
	Integer width
	Integer profile
	String construction
	Integer diameter
	Integer loadIndex
	String speedIndex
	String pattern
	String tireType
	
	static constraints = {
		partNr(matches:"[a-zA-Z0-9|æ|ø|å|Æ|Ø|Å|\\-|\\_]{0,20}", blank:false, unique:true)
		brand(blank:false, matches:"[a-zA-Z0-9|æ|ø|å|Æ|Ø|Å|\\-|\\_]{0,30}")
		tireName(matches:"[a-zA-Z0-9|æ|ø|å|Æ|Ø|Å|\\-|\\_]{0,30}")
		width(min:100, max:350)
		profile(min:20, max:85)
		construction(inList:["R"], blank:false)
		diameter(min:10, max:50)
		loadIndex(min:40, max:240)
		speedIndex(inList:["L","M","N","P","Q","R","S","T","U","H","V","W","Y","Z","ZR"], blank:false)
		pattern(matches:"[a-zA-Z0-9\\s|æ|ø|å|Æ|Ø|Å|\\-|\\_]{0,30}", blank:false)
		tireType(inList:["Sommer","Vinter (pigg)","Vinter (piggfri)"], blank:false)
	}


	String toString(){
		"${brand} ${tireName} ${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} ${tireType} (${partNr})" 
		
	}
}
