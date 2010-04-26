package no.pstop.webapp

class IndexController {
    def index = {
		def tireList = Tire.list()
		def tireLabelList = []
		def numberOfAvailableList = []
		tireList.each {
			int numberOfAvailable = 0
			tireLabelList << it.brand +" " +it.tireName +" " +it.diameter +"''"
			it.tireOccurrences.each {
				numberOfAvailable += it.numberOfAvailable()
			}
			numberOfAvailableList << numberOfAvailable
		}
		println numberOfAvailableList
		println tireLabelList
		render(model: [numberOfAvailableListValues: numberOfAvailableList, tireListLabels: tireLabelList], view: "index")
	}
}
