package no.pstop.webapp

class TireOccurrence {
	static belongsTo = [tire:Tire]
	
	long id
	Tire tire
	Double price
	Integer numberInStock
	Integer numberOfReserved = 0
	Integer numberOfOrdered = 0
	Date date
	Integer numberOfAvailable = 0
	
    static constraints = {
		price(min:new Double(0.00))
		numberInStock(min:0)
		numberOfReserved(min:0)
		numberOfOrdered(min:0)
//TODO Fjerne constraint av numberOfAvailable og etterpå endre i testene
		numberOfAvailable(min:0)
		date(min:new Date()-1)
	}
}
