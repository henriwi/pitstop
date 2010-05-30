package no.pstop.webapp;

import grails.test.ControllerUnitTestCase;

class SupplierOrderControllerTests extends ControllerUnitTestCase {
	
	def supplierOrder
	def supplierOrderLine
	protected void setUp() {
		super.setUp();
		mockDomain SupplierOrder
		mockDomain SupplierOrderLine
		
		supplierOrder = new SupplierOrder(supplier: "Dekk Service", notice: "Leveres innen 2 uker")
		supplierOrderLine = new SupplierOrderLine(supplierOrder: supplierOrder, tire: new Tire(), 
		numberOfOrderedTires: 4, numberOfReceivedTires: 0, price: 2000, discount: 10, environmentalFee: 10)
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testIndex() {
		controller.index()
		assertEquals "list", controller.redirectArgs.action
	}
	
	void testList() {
		def supplierOrderList = [supplierOrder]
		mockDomain SupplierOrder, supplierOrderList
		def model = controller.list()
		
		assertEquals supplierOrderList, model.supplierOrderInstanceList
	}
	
	void testCreate() {
		def model = controller.create()
		assertNotNull "Order should not be null", model.session.order
		assertNotNull "Orderline should not be null", model.session.orderLine
	}
	
	void testSave() {
		controller.params.supplier = "Oslo dekkservice"
		controller.params.notice = "Hentes innen to uker"
		
		def supplierOrderLines = [supplierOrderLine]
		mockDomain SupplierOrderLine, supplierOrderLines
		
		controller.session["order"] = supplierOrder
		controller.session["orderLines"] = supplierOrderLines
		controller.metaClass.message = {args -> println "message: ${args}"}
		
		def logMock = mockFor(OrderService)
		logMock.demand.saveSupplierOrder() {}
		controller.orderService = logMock.createMock() 
		
		controller.save()
		assertEquals "pendingSupplierOrders", controller.redirectArgs.action
	}

}
