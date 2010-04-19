package no.pstop.webapp

class TireOccurrence {
	static final tax = 1.25
	
	static hasMany = [customerOrderLines: CustomerOrderLine]
	static belongsTo = [tire: Tire]
	static searchable = true
	Double price
	Integer numberInStock
	Integer numberOfReserved = 0
	Integer numberOfOrdered = 0
	Date registrationDate
	Integer discount
	Integer environmentalFee
	boolean inStock = true
	
    static constraints = {
		price(min: new Double(0.00))
		numberInStock(min: 0)
		numberOfReserved(min: 0)
		numberOfOrdered(min: 0)
		registrationDate(blank: false, nullable: false)
		discount(min: 0, max: 100)
		environmentalFee(min: 0)
	}
	
	Integer numberOfAvailable() {
		numberInStock - numberOfReserved
	}
	
	Double sum(){
		(price * ((100 - discount)/100) + environmentalFee) * tax
	}
	
	String customerOrderLineToString(){
		"${tire?.toString()}"
	}
	
	String toString(){
		"${tire?.toString()}"
	}
}
