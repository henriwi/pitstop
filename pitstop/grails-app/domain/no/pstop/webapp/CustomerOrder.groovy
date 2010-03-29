package no.pstop.webapp

class CustomerOrder {
	static hasMany = [customerOrderLines: CustomerOrderLine]
    static belongsTo = [customer: Customer]
    Customer customer
    Date orderDate
	String notice
	
    static constraints = {
		orderDate(max: new Date() + 1)
		notice(size: 0..1000)
    }
	
	String toString(){
		"Ordre - ${id}"
	}
}
