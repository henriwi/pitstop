package no.pstop.webapp

class CustomerOrder {
	static hasMany = [customerOrderLines: CustomerOrderLine]
    static belongsTo = [customer: Customer]
    static constraints = {
    }
}
