package no.pstop.webapp

class SupplierOrder {
	static hasMany = [supplierOrderLines: SupplierOrderLine]
	String orderNumber
	Date orderDate
	String supplier
	
	static constraints = {
		// Hvis denne er med, vil det ikke være mulighet til å endre 
		// dato senere dersom den skal være før dagens dato
		//orderDate(max: new Date() + 1)
    }
	
}
