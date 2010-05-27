package no.pstop.webapp

class IndexController {
    def index = {
		def numberOfPendingCustomerOrders = numberOfPendingCustomerOrders()
		def numberOfPendingSupplierOrders = numberOfPendingSupplierOrders()
		render(model: [numberOfPendingCustomerOrders: numberOfPendingCustomerOrders, numberOfPendingSupplierOrders: numberOfPendingSupplierOrders], view: "index")
	}
	
    private numberOfPendingCustomerOrders() {
		def customerOrdersWithoutDeliveredDate = CustomerOrder.findAllByDeliveredDateIsNull()
		return customerOrdersWithoutDeliveredDate.size()
	}
	
	private numberOfPendingSupplierOrders() {
		def pendingSupplierOrdersList = []
		def supplierOrders = SupplierOrder.list(params).each { 
			boolean pending = false
			it.supplierOrderLines.each {
				if (!it.receivedDate) {
					pending = true
				}
			}
			if (pending) {
				pendingSupplierOrdersList << it
			}
		}
		return pendingSupplierOrdersList.size()
	}
}
