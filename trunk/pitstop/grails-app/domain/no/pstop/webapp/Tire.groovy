package no.pstop.webapp
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher

class Tire {
	static searchable = true
	static hasMany = [customerOrderLines: CustomerOrderLine, supplierOrderLines: SupplierOrderLine]
    static final tireIndex = 0
    static final widthIndex = 1
    static final profileIndex = 2
    static final diameterIndex = 3
    static final tireTypeIndex = 4
    static final lengthOfNoticeInListView = 10
	
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
	String notice
	Double retailPrice
	Integer numberInStock
	boolean enabled
	
	
	static constraints = {
		partNr(matches: "[a-zA-Z0-9æøåÆØÅ\\-\\_]{0,40}", blank: false, unique: true)
		brand(blank: false, matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\_\\']{0,30}")
		tireName(matches: "[a-zA-Z0-9æøåÆØÅ\\s\\-\\_\\']{0,30}")
		width(min: 100, max: 350)
		profile(min: 20, max: 85)
		construction(inList: ["R"], blank: false)
		diameter(min: 10, max: 50)
		loadIndex(min: 1, max: 240)
		speedIndex(inList: ["L","M","N","P","PR","Q","R","S","T","U","H","V","W","Y","Z","ZR"], blank: false)
		pattern(matches: "[a-zA-Z0-9\\s|æ|ø|å|Æ|Ø|Å|\\-|\\_]{0,30}")
		tireType(inList: ["Sommer", "Vinter (pigg)", "Vinter (piggfri)", "Vinter (pigg - upigget)", "M+S (helårsdekk)"], blank: false)
		retailPrice(min: new Double(0.00))
		numberInStock(min: 0)
	}

	static fastSearch(Matcher query, Integer max, Integer offset) {
		Tire.search([max: max, offset: offset], escape: true) {
			must(term('width', query[tireIndex][widthIndex]))
			must(term('profile', query[tireIndex][profileIndex]))
			must(wildcard('diameter', "*" + query[tireIndex][diameterIndex]))
			must(prefix('tireType', query[tireIndex][tireTypeIndex].toString().toLowerCase()))
		}.results
	}

	static normalSearch(String width, String profile, String diameter, String speedIndex, 
	String tireType, String brand, Integer max, Integer offset) {
		Tire?.search([max: max, offset: offset, escape: true]) {
			width != "" ? must(term('width', width)) : ""
			profile != "" ? must(term('profile', profile)) : ""
			diameter != "" ? must(term('diameter', diameter)) : ""
			speedIndex != "" && speedIndex != "Alle" ? must(term('speedIndex', speedIndex?.toLowerCase())) : ""
			tireType != "" && tireType != "Alle" ? must(queryString(tireType)) : ""
			brand != "" ? must(term('brand', brand?.toLowerCase())) : ""
		}?.results
	}
	
	/*String toString() {
		Integer numberOfAvailable = 0 
		for (tireOccurrence in this?.tireOccurrences) {
			numberOfAvailable += tireOccurrence?.numberOfAvailable()
		}
		"${brand} ${tireName} ${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} ${tireType} (på lager: ${numberOfAvailable})"
	}*/
	
	String toString(){
		"${brand} ${tireName} ${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} ${tireType}"
	}
	
	String orderToString() {
		"${brand} ${tireName} ${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} ${tireType} (${partNr})"
		//"${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} (${retailPrice},-)"
	}
	
	String tireShowToString() {
		"${brand} ${tireName} ${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} ${tireType}"
		// Forslag til ny toString()
		//"${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} (${retailPrice},-)"
	}
	
	String showNoticeWith10FirstLetters() {
		if (notice?.length() > lengthOfNoticeInListView) {
			String firstLetters = notice?.substring(0, lengthOfNoticeInListView)
			firstLetters + " ..."
		}
		else
			notice
	}
	
	String fastSearchString() {
		String lastNumberInDiameter = diameter?.toString().substring(1, 2)
		String firstLetterInTireType = tireType?.substring(0, 1).toLowerCase()
		"${width}${profile}${lastNumberInDiameter}${firstLetterInTireType}"
	}
	
	String enabledLabel(){
		(enabled) ? "Ja" : "Nei"
	}
}
