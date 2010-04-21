package no.pstop.webapp

class CustomerOrderLine {
	static belongsTo = [tire: Tire, customerOrder: CustomerOrder]
	Integer numberOfReservedTires
	Double price

    static constraints = {
		price(min: new Double(0.00), max: new Double(100000000.00))
    }
	
}
