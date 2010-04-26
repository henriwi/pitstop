package no.pstop.webapp

class CustomerOrder {
	static hasMany = [customerOrderLines: CustomerOrderLine]
    static belongsTo = [customer: Customer]
    Date orderDate
	
    static constraints = {
		orderDate(max: new Date() + 1)
    }
}
