package no.pstop.webapp

class TireOccurrence {
	//long id
	Tire tire
	Integer numberInStock
	Integer price
	Integer numberOfReserved
	Integer numberOfOrdered
	//Date fungerer ikke
	Date date
	//Ikke sikkert vi trenger numberOfAvailable
	Integer numberOfAvailable
	
    static constraints = {
    }
}
