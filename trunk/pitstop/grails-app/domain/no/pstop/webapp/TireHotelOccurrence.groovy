package no.pstop.webapp

class TireHotelOccurrence {
	static final lengthOfNoticeInListView = 10
	
	static searchable = true
	static belongsTo = [customer: Customer]
	String tireLocation
	String registrationNumber
	String carType
	Customer customer
	String tireType
	Date inDate
	Date outDate
	String notice
	
    static constraints = {
		tireLocation(blank: false, nullable: false, matches: "([a-zA-ZøæåØÆÅ0-9])[a-zA-ZøæåØÆÅ0-9\\-\\_\\s]{0,20}")
		registrationNumber(blank: false, nullable: false, matches: "[a-zA-ZøæåØÆÅ0-9]{0,10}[\\-\\s]?[a-zA-ZøæåØÆÅ0-9]{0,10}")
		carType(matches: "[a-zA-ZøæåØÆÅ0-9\\-\\_\\s\\.]{0,30}")
		tireType(inList: ["Sommer", "Vinter (pigg)", "Vinter (piggfri)", "Vinter (pigg - upigget)", "M+S (helårsdekk)"], blank: false)
		inDate(blank: false, nullable: false)
		outDate(blank: true, nullable: true)
		notice(size: 0..1000)
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
