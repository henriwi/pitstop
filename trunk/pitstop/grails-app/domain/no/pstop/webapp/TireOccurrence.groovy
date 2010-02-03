package no.pstop.webapp

class TireOccurrence {
	//long id
	Tire tire
	int numberInStock
	int price
	int numberOfReserved
	int numberOfOrdered
	//TODO
	//DateTime dato
	int numberOfAvailable = numberInStock - numberOfReserved
	
    static constraints = {
    }
}
