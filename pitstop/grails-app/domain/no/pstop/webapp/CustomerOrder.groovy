package no.pstop.webapp

import java.util.Date;

class CustomerOrder {
	static final lengthOfNoticeInListView = 50
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
	
	String showNoticeWith10FirstLetters() {
		if (notice?.length() > lengthOfNoticeInListView) {
			String firstLetters = notice?.substring(0, lengthOfNoticeInListView)
			firstLetters + " ..."
		}
		else
			notice
	}
}
