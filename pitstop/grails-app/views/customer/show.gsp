
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
       			<g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link>
       		</span>
       		<span class="menuButton" ${(params.action == 'pendingCustomerOrders') ? "id='active'" : ""}  >
       			<g:link class="pendingCustomerOrders" action="pendingCustomerOrders"><g:message code="customer.pendingCustomerOrders.title.label" /></g:link>
       		</span>
       		<span class="menuButton" ${(params.action == 'show') ? "id='active'" : ""}  >
       			<g:link class="showUser" action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "firstName")} ${fieldValue(bean: customerInstance, field: "lastName")}</g:link>
       		</span>
        </div>
        <div class="body">
            <h1><g:message code="customer.show.title.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
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
							${fieldValue(bean: customerInstance, field: "phoneNumber")}
							<modalbox:createLink id="${customerInstance.id}" controller="customer" action="showSmsView" title="Send SMS" width="350" overlayDuration="0" slideDownDuration="0" resizeDuration="0">Send SMS</modalbox:createLink>
						</span>
                    </g:if>
                    <g:if test="${customerInstance.email}">
						<span class="customerEmail">
							${fieldValue(bean: customerInstance, field: "email")}
                    		<a href="mailto:${customerInstance.email}" target="_blank">Send e-post</a>
                    	</span>
		            </g:if>
	                
	                <g:if test="${customerInstance.notice}">
						<span class="customerNotice" >${fieldValue(bean: customerInstance, field: "notice")}</span>
					</g:if>
					
	                <div class="buttons" id="customerButtons">
		                <g:form class="showCustomerButtons">
		                    <g:hiddenField name="id" value="${customerInstance?.id}" />
		                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'customer.button.edit.label', default: 'Edit')}" /></span>
		                    
		                    <g:ifAllGranted role="ROLE_ADMIN">
		                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'customer.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'customer.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
		                    </g:ifAllGranted>
						</g:form>
						<span class="button"><g:link class="createOrder" controller="customerOrder"  action="create" title="${message(code: 'customer.list.order.tooltip.label')}" id="${customerInstance?.id}">${message(code: 'customer.button.createOrder.label', default: 'Order')}</g:link></span>
		        	</div>
                </div>
                
			</div>
			
			<div id="customerTireHotelAndOrders">
				<g:if test="${tireHotelOccurrenceInstanceTotalList}">
					<h3><g:message code="customer.show.title.tireHotel.label" /></h3>
					<div id="customerTireHotel">
						<span id="customerTireHotelOccurrenceSwitchButton">
							<a id="showCustomerHistory" href="javascript:hideAndShowElement('allTireHotelOccurrences', 'activeTireHotelOccurrences');"
								onclick="hideAndShowElement('hideCustomerHistory', 'showCustomerHistory');">Vis historikk</a>
							<a id="hideCustomerHistory" href="javascript:hideAndShowElement('activeTireHotelOccurrences','allTireHotelOccurrences');"
								onclick="hideAndShowElement('showCustomerHistory', 'hideCustomerHistory');" style="visibility: hidden;">Skjul historikk</a>
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
								<!--Hva er dette? Slette?-->
<!--						                <g:ifAllGranted role="ROLE_ADMIN">-->
<!--			                         		<g:form controller="tireHotelOccurrence" method="post">-->
<!--			                         			<g:hiddenField name="customerId" value="${customerInstance?.id}" />-->
<!--			                        			<g:hiddenField name="requestFromShowCustomerView" value="true" />-->
<!--			                         			<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />-->
<!--			                         			-->
<!--			                         		</g:form>-->
<!--			                   			</g:ifAllGranted>-->
			                   		</div>
			                   		<div style="clear: both;"></div>
								</div>
							</g:each>
						</div>
			            <div class="customerTireHotelOccurrencelist" id="allTireHotelOccurrences">
			               	<table>
			                   	<thead>
			                       	<tr>
			                           	<g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label')}" />
			                       
			                           	<g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label')}" />
			                       
			                           	<g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label')}" />
			                       
			                           	<g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label')}" />
			                       
			                           	<g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label')}" />
			                           
			                        	<g:sortableColumn property="outDate" title="${message(code: 'tireHotelOccurrence.list.outDate.label')}" />
			                        		
			                        	<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delivered.label')}</a></th>
	                            		
	                            		<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.change.label')}</a></th>
	                            		
	                            	<g:ifAllGranted role="ROLE_ADMIN">
	                            		<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delete.label')}</a></th>
	                            	</g:ifAllGranted>
			                    	</tr>
			                   	</thead>
			                   	<tbody>
				                    <g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
										<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				                       
				                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</td>
				                       
				                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</td>
				                       
				                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</td>
				                       
				                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</td>
				                       
				                            <td><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></td>
				                           
			                        		<td><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.outDate}" /></td>
			                        		
			                        		<td>
		                            			<g:if test="${!tireHotelOccurrenceInstance.outDate}">
					                        		<g:form controller="tireHotelOccurrence" method="post">
						                        		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
			                            				<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
														<g:hiddenField name="delivered" value="delivered" />
			                            				<g:actionSubmit class="delivered" title="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" action="deliverTireHotelOccurenceFromCustomerView" value="${message(code: 'tireHotelOccurrence.list.delivered.button')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
			                            			</g:form>
		                            			</g:if>
	                            			</td>
	                            			
	                            			<td>
	                            				<g:if test="${!tireHotelOccurrenceInstance.outDate}">
		                            				<g:form controller="tireHotelOccurrence" method="post">
		                            					<g:hiddenField name="customerId" value="${customerInstance?.id}" />
		                            					<g:hiddenField name="requestFromShowCustomerView" value="true" />
		                            					<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
		                            					<g:actionSubmit class="change" action="change" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.change.button')}" />
		                            				</g:form>
	                            				</g:if>
	                            			</td>
	                            			
	     			                      	<g:ifAllGranted role="ROLE_ADMIN">
			                            		<td>
			                            			<g:form controller="tireHotelOccurrence" method="post">
			                            				<g:hiddenField name="customerId" value="${customerInstance?.id}" />
		                            					<g:hiddenField name="requestFromShowCustomerView" value="true" />
			                            				<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
			                            				<g:actionSubmit class="deleteTableItem" title="${message(code: 'tireHotelOccurrence.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'tireHotelOccurrence.button.delete.confirm.message')}');" />
			                            			</g:form>
			                            		</td>
	                        				</g:ifAllGranted>
				                    	</tr>
				                	</g:each>
			                	</tbody>
			               	</table>
							<div class="paginateButtons" id="showCustomer">
				          		<g:paginate next="Neste" prev="Forrige" controller="customer" action="show" id="${customerInstance.id}" total="${tireHotelOccurrenceInstanceTotalList.size()}"></g:paginate>
				        	</div>
						</div>
					</g:if>
				</div>
			
				<g:if test="${customerOrders}">
					<div id="customerOrders">
						<h1><g:message code="customer.show.title.orders.label" /></h1>
						<g:each in="${customerOrders}" status="i" var="customerOrderInstance">
							<div id="customerCustomerOrder">
								${customerOrderInstance?.id}
	                   		</div>
						</g:each>
					</div>
				</g:if>
			</div>
        </div>
    </body>
</html>
