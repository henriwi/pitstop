package no.pstop.webapp

class TireOccurrence {
	//long id
	Tire tire
	Integer numberInStock
	Integer price
	Integer numberOfReserved
	Integer numberOfOrdered
	//TODO
	//DateTime dato
	//Ikke sikkert vi trenger numberOfAvailable
	Integer numberOfAvailable
	
    static constraints = {
    }
}
