<%@ page import="no.pstop.webapp.CustomerOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrder.label', default: 'CustomerOrder')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <g:if test="${params.action == 'list'}">
        		<span class="menuButton" id="active" >
        			<g:link class="list" action="list"><g:message code="customer.listCustomerOrder.list.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="list" action="list"><g:message code="customer.listCustomerOrder.list.label" /></g:link>
        		</span>
	        </g:else>
	        
	        <g:if test="${params.action == 'create'}">
        		<span class="menuButton" id="active" >
        			<g:link class="create" action="create"><g:message code="customer.addOrder.new.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="create" action="create"><g:message code="customer.addOrder.new.label" /></g:link>
        		</span>
	        </g:else>
        </div>
        <div class="body">
            <h1><g:message code="customerOrder.create.header.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${customerOrderInstance}">
            <div class="errors">
                <g:renderErrors bean="${customerOrderInstance}" as="list" />
            </div>
            </g:hasErrors>
                <div class="dialog">
                <g:form action="showTireOccurrences" method="get">
                    <table>
                        <tbody>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer"><g:message code="customerOrder.customer.label" default="Customer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderInstance, field: 'customer', 'errors')}">
                                    <g:select name="customerId" from="${no.pstop.webapp.Customer.list()}" optionKey="id" value="${params.customerId}" />
                                </td>
                            </tr>
                        	
							<tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="tire"><g:message code="customerOrderLine.tire.label" default="Dekk" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'tire', 'errors')}">
										<g:select noSelection="${[0:'Velg dekk']}" name="tireId" from="${tireList}" optionKey="id" value="${params?.tireId}" />
										<span class="button"><g:submitButton name="showTireOccurrences" class="next" value="${message(code: 'default.label', default: 'Vis')}" /></span>
									</td>
	                            </tr>
                        </tbody>
                    </table>
                    </g:form>
                </div>
                
                <g:if test="${no.pstop.webapp.Tire.get(params?.tireId)?.tireOccurrences}"></g:if>
                <g:form action="addToOrder" method="post">
                <table>
						<thead>
		                	<tr>
	                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.price.label')}" />
	                            
	                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.sum.label')}" />
	                        
	                            <g:sortableColumn property="numberOfReserved" title="${message(code: 'tireOccurrence.numberOfReserved.label')}" />
	                        
	                            <g:sortableColumn property="numberOfOrdered" title="${message(code: 'tireOccurrence.numberOfOrdered.label')}" />
	                        
	                            <g:sortableColumn property="numberOfAvailable" title="${message(code: 'tireOccurrence.numberOfAvailable.label')}" />
	                        
	                        	<g:sortableColumn property="registrationDate" title="${message(code: 'tireOccurrence.registrationDate.label')}" />
	                        	
	                        	<th><a class="notSortableColoumn">${message(code: 'tireOccurrence.numberInStock.label')}</a></th>
	                        	
	                        	<th><a class="notSortableColoumn">${message(code: 'tireOccurrence.price.label')}</a></th>
	                        </tr>
	                    </thead>
						<tbody>
							<g:set var="numberOfTireOccurrences" value="${0}"></g:set>
							<g:each in="${no.pstop.webapp.Tire.get(params?.tireId)?.tireOccurrences}" status="i" var="tireOccurrenceInstance">
								<g:set var="numberOfTireOccurrences" value="${numberOfTireOccurrences + 1}"></g:set>
			               		<tr>
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance?.id}"><g:formatNumber number="${tireOccurrenceInstance?.price}" format="#.00 kr" /></g:link></td>
		                            
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance?.id}"><g:formatNumber number="${tireOccurrenceInstance?.sum()}" format="#.00 kr" /></g:link></td>
		                        
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance?.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</g:link></td>
		                        
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance?.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</g:link></td>
		                        
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance?.id}">${tireOccurrenceInstance?.numberOfAvailable()}</g:link></td>
		                            
		                        	<td><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
		                        	
		                        	<td><g:select noSelection="${[0:'0']}" name="numberOfOrdered" from="${1..tireOccurrenceInstance?.numberOfAvailable()}"  /></td>
		                        	
		                        	<td><g:textField maxlength="40" tabindex='1' name="price" /></td>
		                        	<g:hiddenField name="tireOccurrenceId" value="${tireOccurrenceInstance?.id}" />
		                        	<g:hiddenField name="tireId" value="${tireOccurrenceInstance?.tire.id}" />
		                        </tr>
		                    </g:each>
        					<g:hiddenField name="numberOfTireOccurrences" value="${numberOfTireOccurrences}" />
        					<g:hiddenField name="customerId" value="${params.customerId}" />
											
						</tbody>
					</table>
					<span class="button"><g:submitButton name="showTireOccurrences" class="next" value="${message(code: 'default.label', default: 'Legg til i ordre')}" /></span>
                 </g:form>
                 
                <div>
                	<table>
                		<thead>
	                		<tr class="prop">
		                		<th><a class="notSortableColoumn">${message(code: 'tireOccurrence.numberInStock.label')}</a></th>
	
								<th><a class="notSortableColoumn">${message(code: 'tireOccurrence.numberInStock.label')}</a></th>
		                	
		                		<th><a class="notSortableColoumn">${message(code: 'tireOccurrence.numberInStock.label')}</a></th>
		                		
		                		<th><a class="notSortableColoumn">${message(code: 'tireOccurrence.numberInStock.label')}</a></th>
		                	</tr>
		                </thead>
	                	<tbody>
	                	
 							<g:each in="${orderLine}" status="i" var="orderLineInstance">
 								<tr>
                        			<td>${orderLineInstance?.tireOccurrence}</td>
                        			<td>${orderLineInstance?.numberOfOrderedTireOccurrences}</td>
                        			<td>${orderLineInstance?.price}</td>
									<g:hiddenField name="tireOccurrence.id" value="${orderLine?.id}" />
									<g:hiddenField name="numberOfTireOccurrencesOrdered" value="${numberOfTireOccurrencesOrdered}" />
									
									<td>
                            			<g:form action="deleteFromOrder" method="post">
                            				<g:hiddenField name="removeTireOccurrenceId" value="${orderLineInstance?.tireOccurrence?.id}" />
                            				<g:submitButton class="deleteTableItem" name="deleteFromOrder" value="${message(code: 'customerOrder.button.delete.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
                            			</g:form>
                           			</td>  
								</tr>
							</g:each>
	                   	
	                   	</tbody>
	            	</table>
                </div>
                
                <g:form action="save" method="post" >
                	<div class="buttons">
                    	<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    	<span class="button"><g:actionSubmit tabindex='13' class="cancel" action="list" value="${message(code: 'createTire.button.cancel.label')}" onclick="return confirm('${message(code: 'createTire.button.cancel.confirm.message')}');" /></span>
                	</div>
            	</g:form>
            	
        </div>
    </body>
</html>
