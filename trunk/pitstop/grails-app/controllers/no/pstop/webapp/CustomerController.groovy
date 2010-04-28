package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;
import grails.converters.JSON

@Secured(['ROLE_ADMIN', 'ROLE_USER'])
class CustomerController {
	static final maxNumberOfTireHotelOccurrences = 10
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

	def list = {
		def customerList
		def customerCount
		
		if(params.q){
			customerList = Customer.search("*" + params.q + "*", escape: true).results
			customerCount = customerList.size()
			flash.message = "Resultat av søk: " + params.q
		}
		else {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			customerList = Customer.list(params)
			customerCount = Customer.count()
		}
		
		if(customerCount == 0 ) {
			flash.message = "${message(code: 'customer.search.notFound.message', args: [message(code: 'customer.label'), params.q])}"
		}
		
		[customerInstanceList: customerList, customerInstanceTotal: customerCount]
	}

	def pendingCustomerOrders = {
		def customerOrderWithoutDeliveredDate = CustomerOrder.findAllByDeliveredDateIsNull()
		[customerOrderWithoutDeliveredDateInstanceList: customerOrderWithoutDeliveredDate]
	}

    def create = {
        def customerInstance = new Customer()
        customerInstance.properties = params
        return [customerInstance: customerInstance]
    }

    def save = {
		def postalCodeAndPlace = PostalCodeAndPlace.findByPostalCode(params.postalCode)
		def customerInstance = new Customer(params)
		customerInstance.postalCodeAndPlace = postalCodeAndPlace
		if (customerInstance.save(flush: true)) {
            flash.message = "${message(code: 'customer.created.message', args: [message(code: 'customer.label' ), customerInstance.firstName, customerInstance.lastName])}"
            redirect(action: "show", id: customerInstance.id)
        }
        else {
            render(view: "create", model: [customerInstance: customerInstance])
        }
    }

    def show = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
			if (!params.max)
				params.max = maxNumberOfTireHotelOccurrences
			if (!params.offset)
				params.offset = 0
				
			def tireHotelOccurrenceListWithoutDelivered = TireHotelOccurrence.findAllByOutDateIsNullAndCustomer(Customer.get(params.id))
			def tireHotelOccurrenceInstanceList = TireHotelOccurrence.findAllByCustomer(Customer.get(params.id), [max:params.max, offset:params.offset])
			def tireHotelOccurrenceInstanceTotalList = TireHotelOccurrence.findAllByCustomer(Customer.get(params.id))	
        	def customerOrders = CustomerOrder.findAllByCustomer(Customer.get(params.id))

			[customerInstance: customerInstance, 
			tireHotelOccurrenceInstanceListWithoutDeliveredInstance: tireHotelOccurrenceListWithoutDelivered,
			tireHotelOccurrenceInstanceList: tireHotelOccurrenceInstanceList, 
			tireHotelOccurrenceInstanceTotalList: tireHotelOccurrenceInstanceTotalList, 
			customerOrders: customerOrders]
        }
    }

    def edit = {
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerInstance: customerInstance]
        }
    }

    def update = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            customerInstance.properties = params
            if (!customerInstance.hasErrors() && customerInstance.save(flush: true)) {
                flash.message = "${message(code: 'customer.updated.message', args: [message(code: 'customer.label'), customerInstance.firstName, customerInstance.lastName])}"
                redirect(action: "show", id: customerInstance.id)
            }
            else {
                render(view: "edit", model: [customerInstance: customerInstance])
            }
        }
        else {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(['ROLE_ADMIN'])
    def delete = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            try {
                customerInstance.delete(flush: true)
                flash.message = "${message(code: 'customer.deleted.message', args: [message(code: 'customer.label'), customerInstance.firstName, customerInstance.lastName])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'customer.not.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'customer.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }

	def customerAutoComplete = {
		def customers = Customer.findAllByFirstNameLikeOrLastNameLikeOrPhoneNumberLike("%${params.query}%", "%${params.query}%", "%${params.query}%")
		
		customers = customers.collect {
			[id: it.id, name:it.autoCompleteToString()]
		}
		def jsonCustomer = [
		    customers: customers
		]
		render jsonCustomer as JSON
	}
	
	def search = {
		redirect(action: "list", params:[q: params.search])
	}
	
	def getPlace = {
		def postalObject = PostalCodeAndPlace.findByPostalCode(params.value)

		if (postalObject != null)	
			render postalObject.place
		else 
			render ""
	}
	
	def showSmsView = {
		def customerInstance = Customer.get(params.id)
		render(view: "send", model: [customerInstanceList: customerInstance])
	}
	
	def customerOrdersAsJSON = {
		def orders = CustomerOrder.findAllByCustomer(Customer.get(params.id))
		def pendingOrders = getPendingOrders(orders)

		def formattedOrders = pendingOrders.collect {
			[
			 id: "<b>$it.id</b>",
			 orderDate: new java.text.SimpleDateFormat("dd.MM.yyyy").format(it.orderDate),
			 delivered: "<form action='/pitstop/customerOrder/deliverOrder' method='get'>" +
			 		"<input type='hidden' name='id' value='$it.id'>" + 
			 		"<input class='recieveSupplierOrder' type='submit' value=''></form>", 
				 //g.actionSubmit(class:"deleteTableItem", value: "test", name: "${message(code: 'list.button.table.label')}", controller: "customer", action: 'show'),
			 dataUrl: g.createLink(controller: "customerOrder", action: 'show') + "/$it.id"
			]
		}
		
		def data = [
			//totalRecords: orders.size(),
			results: formattedOrders,
		]
		
		render data as JSON
	}
	
	private getPendingOrders(orders) {
		def pendingOrders = []
		orders.each {
			boolean pending = false
			it.customerOrderLine.each { 
				
// DeliveredDate eksisterer ikke lenger
//				if(!it.deliveredDate) {
					pending = true
//				}
			}
			if(pending) {
				pendingOrders << it
			}
		}
		return pendingOrders
	}
}
