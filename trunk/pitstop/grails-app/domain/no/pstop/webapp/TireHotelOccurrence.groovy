package no.pstop.webapp

class TireHotelOccurrence {
	static searchable = true
	static belongsTo = [customer : Customer]
	String tireLocation
	String registrationNumber
	String carType
	Customer customer
	String tireType
	Date inDate
	Date outDate
	String notice
	
    static constraints = {
		tireLocation(blank: false, nullable: false, matches:"([a-zA-ZøæåØÆÅ0-9])[a-zA-ZøæåØÆÅ0-9\\-\\_]{0,20}")
		registrationNumber(blank: false, nullable: false, matches:"[a-zA-ZøæåØÆÅ0-9]+[\\-\\s]?[a-zA-ZøæåØÆÅ0-9]{0,7}")
		carType(matches:"[a-zA-ZøæåØÆÅ0-9\\-\\_\\s]{0,30}")
		tireType(inList:["Sommer","Vinter (pigg)","Vinter (piggfri)", "Vinter (pigg - upigget)", "M+S (helårsdekk)"], blank:false)
		inDate(blank:false, nullable: false)
		outDate(blank:true, nullable: true)
		notice(size:0..1000)
    }
}
