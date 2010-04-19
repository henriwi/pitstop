package no.pstop.webapp

class SupplierOrder {
	static hasMany = [SupplierOrderLines: SupplierOrderLine]
	Date orderDate
	String supplier
	String notice
	
	static constraints = {
		// Hvis denne er med, vil det ikke være mulighet til å endre 
		// dato senere dersom den skal være før dagens dato
		//orderDate(max: new Date() + 1)
		notice(size: 0..1000)
    }
	
	String toString(){
		"Ordre - ${id}"
	}
}
