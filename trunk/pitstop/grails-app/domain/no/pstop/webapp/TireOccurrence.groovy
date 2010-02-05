package no.pstop.webapp

class TireOccurrence {
	long id
	Tire tire
	Double price
	Integer numberInStock
	Integer numberOfReserved
	Integer numberOfOrdered
	Date date
	Integer numberOfAvailable
	
    static constraints = {
		price(min:new Double(0.00))
		numberInStock(min:0)
		numberOfReserved(min:0)
		numberOfOrdered(min:0)
		numberOfAvailable(min:0)
    }
}
