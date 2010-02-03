package no.pstop.webapp

class TireOccurrence {
	//long id
	Tire tire
	Integer numberInStock
	Integer price
	Integer numberOfReserved
	Integer numberOfOrdered
	//Legge til en SimpleDateFormat
	Date dato
	//Ikke sikkert vi trenger numberOfAvailable
	Integer numberOfAvailable
	
    static constraints = {
    }
}
