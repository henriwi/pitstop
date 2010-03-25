
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.show.title.label" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="customer.list.label" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link></span>
        </div>
        <div class="body">
            <span class="menuButton"><g:link class="back" controller="customer"><g:message code="customer.show.button.back.label" /></g:link></span>
            <h1><g:message code="customer.show.title.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog" id="customerShowDialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.firstName.label" default="First Name" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "firstName")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.lastName.label" default="Last Name" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "lastName")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.phoneNumber.label" default="Phone Number" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "phoneNumber")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.address.label" default="Address" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "address")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.postalCode.label" default="Postal Code" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "postalCode")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.city.label" default="City" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "city")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.email.label" default="Email" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "email")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.company.label" default="Company" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "company")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.notice.label" default="Notice" /></td>
                            <span id="notice" >
                            	<td valign="top" class="value">${fieldValue(bean: customerInstance, field: "notice")}</td>
                            </span>
                        </tr>
                    </tbody>
                </table>
                <div class="buttons">
	                <g:form>
	                    <g:hiddenField name="id" value="${customerInstance?.id}" />
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
	                    <g:ifAllGranted role="ROLE_ADMIN">
	                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'customer.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
	                    </g:ifAllGranted>
	                    <br /><br />
	                    <span class="button"><a href="mailto:${customerInstance.email}" target="_blank">Send e-post til kunde</a></span>
	            	</g:form>
	        	</div>
			</div>
			<div id="customerTireHotelAndOrders">
				<g:if test="${tireHotelOccurrenceInstanceList}">
		            <div id="customerTireHotelOccurrencelist">
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
		                    	</tr>
		                   	</thead>
		                   	<tbody>
			                    <g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
													<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			                       
			                            <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</g:link></td>
			                       
			                            <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</g:link></td>
			                       
			                            <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</g:link></td>
			                       
			                            <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</g:link></td>
			                       
			                            <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></g:link></td>
			                           
			                        		<td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.outDate}" /></g:link></td>
			                        		<td>
				                        		<g:form controller="tireHotelOccurrence" method="post">
				                        			<g:hiddenField name="customerId" value="${customerInstance?.id}" />
	                            				<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
																			<g:hiddenField name="delivered" value="delivered" />
	                            				<g:actionSubmit class="delivered" title="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" action="deliverTireHotelOccurenceFromCustomerView" value="${message(code: 'tireHotelOccurrence.list.delivered.button')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
	                            			</g:form>
                            			</td>
                            			<td>
                            				<g:form controller="tireHotelOccurrence" method="post">
                            					<g:hiddenField name="customerId" value="${customerInstance?.id}" />
                            					<g:hiddenField name="requestFromShowCustomerView" value="true" />
                            					<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
                            					<g:actionSubmit class="change" action="change" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.change.button')}" />
                            				</g:form>
                            			</td>
			                    	</tr>
			                	</g:each>
		                	</tbody>
		               	</table>
						<div class="paginateButtons" id="showCustomer">
			          		<g:paginate next="Neste" prev="Forrige" controller="customer" action="show" id="${customerInstance.id}" total="${tireHotelOccurrenceInstanceTotalList.size()}"></g:paginate>
			        	</div>
					</div>
				</g:if>
				<g:if test="${customerOrderInstanceList}">
					<div class="customerOrders">
		               	<table>
		                   	<thead>
		                       	<tr>
		                            <g:sortableColumn property="id" title="${message(code: 'customerOrder.header.id.label')}" />
		                        
		                            <g:sortableColumn property="orderDate" title="${message(code: 'customerOrder.header.orderDate.label')}" />
		                    	</tr>
		                   	</thead>
		                   	<tbody>
			                    <g:each in="${customerOrderInstanceList}" status="i" var="customerOrderInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                            <td><g:link controller="customerOrder" action="show" id="${customerOrderInstance.id}">${fieldValue(bean: customerOrderInstance, field: "id")}</g:link></td>
		                        
		                            <td><g:link controller="customerOrder" action="show" id="${customerOrderInstance.id}"><g:formatDate format="dd.MM.yyyy hh:mm" date="${customerOrderInstance.orderDate}" /></g:link></td>
		                        </tr>
		                    </g:each>
		                	</tbody>
		               	</table>
										<div class="paginateButtons" id="showCustomer">
			          		<g:paginate next="${message(code: 'default.paginate.next')}" prev="${message(code: 'default.paginate.prev')}" controller="customer" action="show" id="${customerInstance.id}" total="${customerOrderInstanceList.size()}"></g:paginate>
			        	</div>
					</div>
				</g:if>
			</div>
        </div>
    </body>
</html>
