package no.pstop.webapp

class TireOccurrence {
	static hasMany = [customerOrderLines:CustomerOrderLine]
	static belongsTo = [tire:Tire]
	static searchable = true
	Tire tire // = new Tire()
	Double price
	Integer numberInStock
	Integer numberOfReserved = 0
	Integer numberOfOrdered = 0
	Date registrationDate
	Integer discount
	Integer environmentalFee
	static final tax = 1.25
	
    static constraints = {
		//tire(blank:false, nullable:false)
		price(min:new Double(0.00))
		numberInStock(min:0)
		numberOfReserved(min:0)
		numberOfOrdered(min:0)
		registrationDate(blank:false, nullable:false) //, min:new Date()-1)
		discount(min:0, max:100)
		environmentalFee(min:0)
	}
	
	Integer numberOfAvailable() {
		numberInStock - numberOfReserved
	}
	
	Double sum(){
		(price * ((100 - discount)/100) + environmentalFee) * tax
	}
	
	String customerOrderLineToString(){
		"${tire.toString()}"
	}
	
	String toString(){
		"${tire.toString()}"
	}
}
