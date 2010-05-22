package no.pstop.webapp

class SupplierOrder {
	static final lengthOfNoticeInListView = 10
	static hasMany = [supplierOrderLines: SupplierOrderLine]
	Date orderDate
	String supplier
	String notice
	
	static constraints = {
		supplier(size: 0..100)
		notice(size: 0..1000)
    }
	
	String showNoticeWith10FirstLetters() {
		if (notice?.length() > lengthOfNoticeInListView) {
			String firstLetters = notice?.substring(0, lengthOfNoticeInListView)
			firstLetters + " ..."
		}
		else
			notice
	}
	
	boolean delivered() {
		boolean isDelivered = true
		
		supplierOrderLines.each {
			if (!it.receivedDate) {
				isDelivered = false
			}
		}
		return isDelivered
	}
}
