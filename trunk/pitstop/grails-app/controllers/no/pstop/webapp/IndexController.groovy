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
		def supplierOrderLinesWithoutReceivedDate = SupplierOrderLine.findAllByReceivedDateIsNull()
		return supplierOrderLinesWithoutReceivedDate.size()
	}
}
