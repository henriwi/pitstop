package no.pstop.webapp

class CustomerOrderService {

	static transactional = true

    def saveOrder(CustomerOrder customerOrderInstance, session) throws RuntimeException{
		if(!customerOrderInstance.save(flush:true)){
			throw new RuntimeException("cannot save order")
		}
		for (def orderLine : session.orderLineList) {
			def tireOccurrenceInstance = TireOccurrence.get(orderLine?.tireOccurrence?.id)
			tireOccurrenceInstance.numberOfReserved += orderLine?.numberOfOrderedTireOccurrences
			if(!orderLine.save(flush: true)){
				throw new RuntimeException("cannot save orderline")
			}
		}
    }
}
