package no.pstop.webapp

class CustomerOrderLine {
	static belongsTo = [tireOccurrence: TireOccurrence, customerOrder: CustomerOrder]
    TireOccurrence tireOccurrence
	CustomerOrder customerOrder
	Integer numberOfOrderedTireOccurrences
	Double price
	Date deliveryDate

    static constraints = {
		numberOfOrderedTireOccurrences(min: 1, max: 1000)
		price(min: new Double(0.00), max: new Double(100000000.00))
		deliveryDate(blank: true, nullable: true)
    }
	
	String toString(){
		"${tireOccurrence.customerOrderLineToString()}" +
		" Salgspris: ${price}kr Bestilt: ${numberOfOrderedTireOccurrences}"
	}
	
	
}
