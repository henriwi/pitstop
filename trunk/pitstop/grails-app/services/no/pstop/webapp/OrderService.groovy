package no.pstop.webapp

class OrderService {
	static transactional = true

    def saveSupplierOrder(orderInstance, session) throws RuntimeException{
		if(!orderInstance.save(flush:true)){
			orderInstance.errors.each { 
				println it
			}
			throw new RuntimeException("cannot save order")
		}
		session.orderLines.each {
			it.supplierOrder = orderInstance
			if(!it.save(flush: true)){
				it.errors.each { 
					println it
				}
				throw new RuntimeException("cannot save orderline")
			}
		}
    }
	
    def saveCustomerOrder(orderInstance, session) throws RuntimeException{
		if(!orderInstance.save(flush:true)){
			orderInstance.errors.each { 
				println it
			}
			throw new RuntimeException("cannot save order")
		}
		session.orderLines.each {
			it.customerOrder  = orderInstance
			if(!it.save(flush: true)){
				throw new RuntimeException("cannot save orderline")
			}
		}
    }
}
