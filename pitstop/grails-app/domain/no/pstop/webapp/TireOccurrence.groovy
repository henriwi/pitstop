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
		
    }
}
