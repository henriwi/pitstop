package no.pstop.webapp

import java.util.Date;

class SupplierOrderLine {
	static final tax = 1.25
	static belongsTo = [tire: Tire, supplierOrder: SupplierOrder]
	Integer numberOfOrderedTires
	Integer numberOfReceivedTires
	Double price
	Date receivedDate
	Integer discount
	Integer environmentalFee
	
    static constraints = {
		numberOfOrderedTires(min: 1, blank: false)
		numberOfReceivedTires(min: 0)
		price(min: new Double(0.00), blank: false)
		discount(min: 0, max: 100)
		environmentalFee(min: 0)
		receivedDate(nullable: true)
	}
	
	String toString() {
		"$tire (Antall: $numberOfOrderedTires)"
	}
}
