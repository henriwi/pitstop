package no.pstop.webapp

class CustomerOrder {
	static hasMany = [customerOrderLines: CustomerOrderLine]
    static belongsTo = [customer: Customer]
    Date orderDate
	String notice
	
    static constraints = {
		//notice(size: 0..1000)
		notice(nullable: true)
    }
}
