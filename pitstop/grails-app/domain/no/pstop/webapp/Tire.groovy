package no.pstop.webapp
import java.util.ArrayList;
import java.util.regex.Matcher



class Tire {
	static searchable = true
	static hasMany = [ tireOccurrences : TireOccurrence ]
    static final tireIndex = 0
    static final widthIndex = 1
    static final profileIndex = 2
    static final diameterIndex = 3
    static final tireTypeIndex = 4

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
		partNr(matches:"[a-zA-Z0-9|æ|ø|å|Æ|Ø|Å|\\-|\\_]{0,40}", blank:false, unique:true)
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

	static fastSearch(Matcher query){
		Tire.search()
		{
			must(term('width', query[tireIndex][widthIndex]))
			must(term('profile', query[tireIndex][profileIndex]))
			must(wildcard('diameter', "*" + query[tireIndex][diameterIndex]))
			must(prefix('tireType', query[tireIndex][tireTypeIndex].toString().toLowerCase()))
		}.results
	}

	static normalSearch(String width, String profile, String diameter, String speedIndex, String tireType, String brand){
		Tire.search() {
			width != "" ? must(term('width', width)) : ""
			profile != "" ? must(term('profile', profile)) : ""
			diameter != "" ? must(term('diameter', diameter)) : ""
			speedIndex != "" && speedIndex != "Alle" ? must(term('speedIndex', speedIndex.toLowerCase())) : ""
			tireType != "" && tireType != "Alle" ? must(term('tireType', tireType.toLowerCase())) : ""
			brand != "" ? must(term('brand', brand.toLowerCase())) : ""
		}.results
	}
	
	static findNumberOfAvailable(List<Integer> tireIdList) {
		String condition = createConditionList(tireIdList);
		TireOccurrence.executeQuery("select sum(numberInStock-numberOfReserved) from TireOccurrence where tire in(" + condition + ") group by tire.id")
	}
	
	private static createConditionList(List<Integer> tireIdList) {
		String condition = ""
		for (int i = 0; i < tireIdList.size() - 1; i++) {
			condition += tireIdList.get(i) + ", "
		}
		condition += tireIdList.get(tireIdList.size()-1)
		return condition
	}
	
	String toString(){
		"${brand} ${tireName} ${width}/${profile} ${construction}${diameter} ${loadIndex}${speedIndex} ${tireType} (${partNr})" 
	}
}
