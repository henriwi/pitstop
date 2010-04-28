package no.pstop.webapp

import java.util.Date;

class CustomerOrder {
	static hasMany = [customerOrderLines: CustomerOrderLine]
    static belongsTo = [customer: Customer]
    Date orderDate
	Date deliveredDate
	String notice
	
    static constraints = {
		deliveredDate(nullable: true)
		notice(size: 0..1000)
		notice(nullable: true)
    }
}
