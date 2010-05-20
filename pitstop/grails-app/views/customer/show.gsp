
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.show.title.label" /></title>
    </head>
    <body>
         <div class="nav">
        	<span class="menuButton" ${params.action == 'list' ? "id='active'" : ""} >
       			<g:link class="customerList" action="list"><g:message code="customer.list.label" /></g:link>
       		</span>
       		<span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""}  >
       			<g:link class="createUser" action="create"><g:message code="customer.create.title.label" /></g:link>
       		</span>
       		<span class="menuButton" ${(params.action == 'pendingCustomerOrders') ? "id='active'" : ""}  >
       			<g:link class="pendingCustomerOrders" action="pendingCustomerOrders"><g:message code="customer.pendingCustomerOrders.title.label" /></g:link>
       		</span>
       		<span class="menuButton" ${(customerInstance.id) ? "id='active'" : ""}  >
       			<g:link class="showUser" action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "firstName")} ${fieldValue(bean: customerInstance, field: "lastName")}</g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="customer.show.title.label" /></h1>
            <div class="dialog" id="customerShowDialog">
            	<div class="customerInfoBox">
					<h3 class="customerName">${fieldValue(bean: customerInstance, field: "firstName")} ${fieldValue(bean: customerInstance, field: "lastName")}</h3>
					<g:if test="${customerInstance.address}">
						<span class="customerAddress">${fieldValue(bean: customerInstance, field: "address")}</span>
					</g:if>
					<g:if test="${customerInstance.postalCodeAndPlace.postalCode}">
						<span class="customerPostalCodeAndPlace">${customerInstance?.postalCodeAndPlace?.postalCode} ${customerInstance?.postalCodeAndPlace?.place}</span>
					</g:if>
					<g:if test="${customerInstance.company}">
						<span class="customerCompany">${fieldValue(bean: customerInstance, field: "company")}</span>
					</g:if>
					
					<g:if test="${customerInstance.phoneNumber}">
						<span class="customerPhoneNumber">
							<modalbox:createLink id="${customerInstance.id}" controller="customer" action="showSmsView" title="Send SMS" width="350" overlayDuration="0" slideDownDuration="0" resizeDuration="0" title="${message(code: 'customer.sms.tooltip')}">Send SMS</modalbox:createLink>
							${fieldValue(bean: customerInstance, field: "phoneNumber")}
						</span>
                    </g:if>
                    <g:if test="${customerInstance.email}">
						<span class="customerEmail">
                    		<a href="mailto:${customerInstance.email}" target="_blank" title="${message(code: 'customer.email.tooltip')}">Send e-post</a>
							${fieldValue(bean: customerInstance, field: "email")}
                    	</span>
		            </g:if>
	                
	                <g:if test="${customerInstance.notice}">
						<span class="customerNotice" >${fieldValue(bean: customerInstance, field: "notice")}</span>
					</g:if>
					
	                <div class="buttons" id="customerButtons">
	                	<span class="button"><g:link class="createOrder" controller="customerOrder"  action="create" title="${message(code: 'customer.list.order.tooltip.label')}" id="${customerInstance?.id}">${message(code: 'customer.button.createOrder.label')}</g:link></span>
						<span class="button"><g:link class="addTireHotelOccurrence" controller="tireHotelOccurrence"  action="create" title="${message(code: 'customer.list.tireHotel.tooltip.label')}" id="${customerInstance?.id}">${message(code: 'customer.button.createTireHotel.label')}</g:link></span>
		                <g:form class="showCustomerButtons">
		                    <g:hiddenField name="id" value="${customerInstance?.id}" />
		                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'customer.button.edit.label', default: 'Edit')}" /></span>
		                    
		                    <g:ifAllGranted role="ROLE_ADMIN">
		                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'customer.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'customer.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
		                    </g:ifAllGranted>
						</g:form>
		        	</div>
                </div>
			</div>
			
			<div id="customerTireHotelAndOrders">
				<g:if test="${tireHotelOccurrenceInstanceTotalList}">
					<h3><g:message code="customer.show.title.tireHotel.label" /></h3>
					<div id="customerTireHotel">
						<span id="customerTireHotelOccurrenceSwitchButton">
							<a id="showCustomerHistory" href="javascript:showAndHideElement('allTireHotelOccurrences', 'activeTireHotelOccurrences');"
								onclick="showAndHideElement('hideCustomerHistory', 'showCustomerHistory');">
								Vis historikk
							</a>
							<a id="hideCustomerHistory" href="javascript:showAndHideElement('activeTireHotelOccurrences','allTireHotelOccurrences');"
								onclick="showAndHideElement('showCustomerHistory', 'hideCustomerHistory');" style="display: none;">
								Skjul historikk
							</a>
						</span>
					
						<div class="customerTireHotelOccurrencelist" id="activeTireHotelOccurrences">
								
							<g:if test="${!tireHotelOccurrenceInstanceListWithoutDeliveredInstance}">
									Kunden har ingen aktive dekk p&aring; dekkhotellet
							</g:if>
								
							<g:each in="${tireHotelOccurrenceInstanceListWithoutDeliveredInstance}" status="i" var="tireHotelOccurrenceInstance">
								<div class="customerTireHotelOccurrencelist" id="onlyActiveTireHotelOccurrences">
									<div class="tireInfo">
										<h4>
											${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")} - 
											${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}
										</h4>
										Lagerlokasjon: ${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}<br />
										${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}<br />
										Inndato: <g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" />
									</div>
									<div class="tireHotelButtons">
			                       		<g:form controller="tireHotelOccurrence" method="post">
			                        		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
			                         		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
											<g:hiddenField name="delivered" value="delivered" />
			                         		<g:actionSubmit class="delivered" title="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" action="deliverTireHotelOccurenceFromCustomerView" value="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
			                   			</g:form>
			                        	
			                       		<g:if test="${!tireHotelOccurrenceInstance.outDate}">
			                        		<g:form controller="tireHotelOccurrence" method="post">
			                        			<g:hiddenField name="customerId" value="${customerInstance?.id}" />
			                        			<g:hiddenField name="requestFromShowCustomerView" value="true" />
			                        			<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
			                        			<g:actionSubmit class="change" action="change" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" />
			                        		</g:form>
			                       		</g:if>
			                       		<g:form class="editTireHotelButton" controller="tireHotelOccurrence" method="post">
			                        			<g:hiddenField name="customerId" value="${customerInstance?.id}" />
			                        			<g:hiddenField name="requestFromShowCustomerView" value="true" />
			                        			<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
			                        			<g:actionSubmit class="edit" action="edit" title="${message(code: 'tireHotelOccurrence.list.edit.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.edit.tooltip.label')}" />
		                        		</g:form>
			                   		</div>
			                   		<div style="clear: both;"></div>
								</div>
							</g:each>
						</div>
						
			            <div id="allTireHotelOccurrences">
						<g:render template="/customer/allTireHotelOccurrences"
							model="[tireHotelOccurrenceInstanceList: tireHotelOccurrenceInstanceList, 
							tireHotelOccurrenceInstanceTotalList: tireHotelOccurrenceInstanceTotalList,
							customerInstance: customerInstance]">
						</g:render>
						</div>
					</div>
				</g:if>
				
				<g:if test="${customerOrders}">
					<h3><g:message code="customer.show.title.orders.label" /></h3>
					<div id="customerOrders">
						<span id="customerTireHotelOccurrenceSwitchButton">
							<a id="showCustomerOrderHistory" href="javascript:showAndHideElement('allCustomerOrders', 'activeCustomerOrders');"
								onclick="showAndHideElement('hideCustomerOrderHistory', 'showCustomerOrderHistory');">
								Vis historikk
							</a>
							<a id="hideCustomerOrderHistory" href="javascript:showAndHideElement('activeCustomerOrders','allCustomerOrders');"
								onclick="showAndHideElement('showCustomerOrderHistory', 'hideCustomerOrderHistory');" style="display: none;">
								Skjul historikk
							</a>
						</span>
						<div id="activeCustomerOrders">
						
							<g:if test="${!activeCustomerOrders}">
									Kunden har ingen aktive ordre
							</g:if>
													
							<g:each in="${activeCustomerOrders}" status="i" var="customerOrderInstance">
								<div class="customerOrderBox">
									<g:form controller="customerOrder" method="post">
										<g:hiddenField name="id" value="${customerOrderInstance?.id}" />
										<g:actionSubmit class="deliverOrder" action="deliverOrder" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'customerOrder.receive.label')}" />
									</g:form>
									<h4>Ordrenummer: ${customerOrderInstance?.id}</h4>
									<span><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance?.orderDate}" /></span>
									<span class="tireNotice">${customerOrderInstance?.notice}</span>
									
									<h5 class="orderedTire">Bestilte dekk:</h5>
									<g:each in="${customerOrderInstance?.customerOrderLines}" status="j" var="customerOrderLineInstance">
										<div class="customerOrderLine">
											<span class="tireName">${customerOrderLineInstance?.tire}</span>
											<span class="numberOfReservedTires">${customerOrderLineInstance?.numberOfReservedTires} stk. &agrave;</span>
											<span class="tirePrice"> kr <g:formatNumber number="${customerOrderLineInstance?.price}" format="###,##0" />
											</span>
										</div>
									</g:each>
		                   		</div>
							</g:each>
						</div>
						<div id="allCustomerOrders">
							<g:render template="/customer/allCustomerOrders"
								model="customerOrders: customerOrders, 
								customerOrdersTotalList: customerOrdersTotalList,
								customerInstance: customerInstance]">
							</g:render>
						</div>
				</g:if>
			</div>				
			</div>

    </body>
</html>
