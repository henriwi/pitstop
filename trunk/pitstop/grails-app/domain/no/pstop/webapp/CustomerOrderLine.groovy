package no.pstop.webapp

class CustomerOrderLine {
	static belongsTo = [tire: Tire, customerOrder: CustomerOrder]
	Integer numberOfReservedTires
	Double price

    static constraints = {
		numberOfReservedTires(min: 1)
		price(min: new Double(0.00), max: new Double(100000000.00))
    }
	
	String toString() {
		"$tire (Antall: $numberOfReservedTires)"
	}
}
