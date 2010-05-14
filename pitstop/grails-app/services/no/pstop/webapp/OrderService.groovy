package no.pstop.webapp

class OrderService {
	static transactional = true

    def saveSupplierOrder(orderInstance, session) throws RuntimeException{
		session.orderLines.each {
			orderInstance.addToSupplierOrderLines(it)
		}
		if(!orderInstance.save()) {
			throw new RuntimeException("cannot save supplierOrder")
		}
    }
	
    def saveCustomerOrder(orderInstance, session) throws RuntimeException{
		session.orderLines.each {
			orderInstance.addToCustomerOrderLines(it)
		}
		if(!orderInstance.save()) {
			throw new RuntimeException("cannot save customerOrder")
		}
    }
}
