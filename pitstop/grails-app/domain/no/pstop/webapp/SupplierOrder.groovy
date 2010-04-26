package no.pstop.webapp

class SupplierOrder {
	static hasMany = [supplierOrderLines: SupplierOrderLine]
	String orderNumber
	Date orderDate
	String supplier
	String notice
	
	static constraints = {
		notice(size: 0..1000)
		orderNumber(size: 0..500, blank: false )
		supplier(size: 0..100)
    }
}
