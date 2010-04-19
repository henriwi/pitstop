package no.pstop.webapp

import java.util.Date;

class SupplierOrderLine {
	static belongsTo = [tireOccurrence: TireOccurrence, supplierOrder: SupplierOrder]
	Integer numberOfOrderedTireOccurrences
	Double price
	Date deliveryDate 
	
    static constraints = {
		numberOfOrderedTireOccurrences(min: 1, max: 1000)
		price(min: new Double(0.00), max: new Double(100000000.00))
		//deliveryDate(blank: true, nullable: true)
    }
	
	String toString(){
		"${tireOccurrence?.supplierOrderLineToString()} Salgspris: ${price} kr Bestilt: ${numberOfOrderedTireOccurrences}"
	}
}
