package no.pstop.webapp

class CustomerOrderService {

	static transactional = true

    def saveOrder(CustomerOrder customerOrderInstance, session) throws RuntimeException{
		customerOrderInstance.validate()
		customerOrderInstance.errors.each {
			println it
			}
		if(!customerOrderInstance.save(flush:true)){
			throw new RuntimeException("cannot save order")
		}
		session.orderLineList.each {
			it.customerOrder = customerOrderInstance
			it.validate()
			it.errors.each {
				println it
			}
			if(!it.save(flush: true)){
				throw new RuntimeException("cannot save orderline")
			}
		}
    }
}
