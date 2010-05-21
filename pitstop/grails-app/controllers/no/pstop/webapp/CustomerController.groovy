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

	def deliverOrder = {
		def customerOrder = CustomerOrder.get(params.id)
		customerOrder?.customerOrderLines.each {
			it?.tire?.numberInStock -= it?.numberOfReservedTires
		}
		customerOrder?.deliveredDate = new Date()
		redirect(controller: "customer", action: "pendingCustomerOrders")
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
		if (!customerInstance.validate()) {
			render(view: "create", model: [customerInstance: customerInstance])
        }
        else {
			customerInstance = customerInstance.merge(flush: true)
			flash.message = "${message(code: 'customer.created.message', args: [message(code: 'customer.label' ), customerInstance.firstName, customerInstance.lastName])}"
			redirect(action: "show", id: customerInstance.id)
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
				
			def tireHotelOccurrenceListWithoutDelivered = TireHotelOccurrence.findAllByOutDateIsNullAndCustomer(customerInstance)
			def tireHotelOccurrenceInstanceList = TireHotelOccurrence.findAllByCustomer(customerInstance, [max:params.max, offset:params.offset])
			def tireHotelOccurrenceInstanceTotalList = TireHotelOccurrence.findAllByCustomer(customerInstance)
			
        	def activeCustomerOrders = CustomerOrder.findAllByCustomerAndDeliveredDateIsNull(customerInstance)
        	def customerOrders = CustomerOrder.findAllByCustomer(customerInstance, [max:params.max, offset:params.offset])
        	def customerOrdersTotalList = CustomerOrder.findAllByCustomer(customerInstance)					

			[customerInstance: customerInstance, 
			tireHotelOccurrenceInstanceListWithoutDeliveredInstance: tireHotelOccurrenceListWithoutDelivered,
			tireHotelOccurrenceInstanceList: tireHotelOccurrenceInstanceList, 
			tireHotelOccurrenceInstanceTotalList: tireHotelOccurrenceInstanceTotalList, 
			activeCustomerOrders: activeCustomerOrders, customerOrders: customerOrders, 
			customerOrdersTotalList: customerOrdersTotalList]
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
			def postalCodeAndPlace = PostalCodeAndPlace.findByPostalCode(params.postalCode)
			customerInstance.postalCodeAndPlace = postalCodeAndPlace
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

	def sendSmsToCustomer = {
		if(params.RCV && params.TXT) {
			def url = new URL ("http://sms.pswin.com/http4sms/send.asp")
			def conn = url.openConnection()
			conn.setRequestMethod("POST")
			
			String data = "USER=pitstop&PW=ngriter7&SND=Pit-stop&RCV=47" + params.RCV + "&TXT=" + params.TXT
			
			conn.doOutput = true
			
			Writer wr = new OutputStreamWriter(conn.outputStream)
			wr.write(data)
			wr.flush()
			wr.close()
			
			conn.connect()
//			println conn.content.text
			conn.responseMessage
//			if(conn.responseMessage == "OK\n"){}
				render(template: "sendSmsSuccess")
		}
		else {
			render "Fyll ut alle felter"
		}
	}
	
	def updateAllTireHotelOccurrencesList = {
		def customerInstance = Customer.get(params.id)
		def tireHotelOccurrenceInstanceList = TireHotelOccurrence.findAllByCustomer(customerInstance, [max:params.max, offset:params.offset, 
		sort: params.sort, order: params.order])
		def tireHotelOccurrenceInstanceTotalList = TireHotelOccurrence.findAllByCustomer(customerInstance)
		
		render(template:"allTireHotelOccurrences", model:[ tireHotelOccurrenceInstanceList: tireHotelOccurrenceInstanceList,
		tireHotelOccurrenceInstanceTotalList: tireHotelOccurrenceInstanceTotalList,
		customerInstance: customerInstance])
	}
	
	def updateAllCustomerOrdersList = {
		def customerInstance = Customer.get(params.id)
		def customerOrders = CustomerOrder.findAllByCustomer(customerInstance, [max:params.max, offset:params.offset, 
		sort: params.sort, order: params.order])
		def customerOrdersTotalList = CustomerOrder.findAllByCustomer(customerInstance)
		
		render(template:"allCustomerOrders", model:[ customerOrders: customerOrders,
		customerOrdersTotalList: customerOrdersTotalList,
		customerInstance: customerInstance])
	}
	
	def getTireInfoFromSelectedTire = {
		println "Hepp"
		render "Jada"
	}
}
