package no.pstop.webapp

class SupplierOrder {
	static hasMany = [supplierOrderLines: SupplierOrderLine]
	Date orderDate
	String supplier
	String notice
	
	static constraints = {
		supplier(size: 0..100)
		notice(size: 0..1000)
    }
}
