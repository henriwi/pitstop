
<%@ page import="no.pstop.webapp.CustomerOrderLine" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrderLine.label', default: 'CustomerOrderLine')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${customerOrderLineInstance}">
            <div class="errors">
                <g:renderErrors bean="${customerOrderLineInstance}" as="list" />
            </div>
            </g:hasErrors>
                <div class="dialog">
                    <table>
                        <tbody>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer"><g:message code="customerOrder.customer.label" default="Customer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderInstance, field: 'customer', 'errors')}">
									${order?.customer}
									<g:hiddenField name="customer.id" value="${order?.customer?.id}" />
                                </td>
                            </tr>
                            
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tire"><g:message code="customerOrderLine.tire.label" default="Dekk" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'tire', 'errors')}">
                                	<ul>
                                	<g:set var="numberOfTireOccurrencesOrdered" value="${0}"></g:set>
      								<g:each in="${orderLine}" status="j" var="orderLineInstance">
      								<g:set var="numberOfTireOccurrencesOrdered" value="${numberOfTireOccurrencesOrdered + 1}"></g:set>
                             			<li>${orderLineInstance}</li>
										<g:hiddenField name="tireOccurrence.id" value="${orderLine?.id}" />
										<g:hiddenField name="numberOfTireOccurrencesOrdered" value="${numberOfTireOccurrencesOrdered}" />
									</g:each>
									</ul>
								</td>
                            </tr>
                        	
						</tbody>
					</table>
					
					<g:form action="next" method="post">
						<table>
							<tbody>
								<tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="tire"><g:message code="customerOrderLine.tire.label" default="Dekk" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'tire', 'errors')}">
										<!--<g:select name="tire.id" from="${no.pstop.webapp.Tire.list()}" optionKey="id" optionValue="${{it?.orderToString()}}" />-->
										<g:select noSelection="${[0:'Velg dekk']}" name="tire.id" from="${notOrderedTires}" optionKey="id" value="${params?.tire?.id}" />
										<span class="button"><g:actionSubmit controller="customerOrder" action="showTireOccurrences" method="get" name="showTireOccurrences" class="next" value="${message(code: 'default.label', default: 'Vis')}" /></span>
									</td>
	                            </tr>
							</tbody>
						</table>
						
					</g:form>
					
					<table>
						<thead>
		                	<tr>
	                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.price.label')}" />
	                            
								<!--<g:sortableColumn property="discount" title="${message(code: 'tireOccurrence.discount.label')}" />-->
	                            
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
							<g:each in="${no.pstop.webapp.Tire.get(params?.tire?.id)?.tireOccurrences}" status="j" var="tireOccurrenceInstance">
								<g:set var="numberOfTireOccurrences" value="${numberOfTireOccurrences + 1}"></g:set>
			               		<tr>
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.price}" format="#.00 kr" /></g:link></td>
		                            
									<!--<td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.discount}" format="#" /> %</g:link></td>-->
		                            
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.sum()}" format="#.00 kr" /></g:link></td>
		                        
									<!--<td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</g:link></td>-->
		                        
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</g:link></td>
		                        
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</g:link></td>
		                        
		                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${tireOccurrenceInstance.numberOfAvailable()}</g:link></td>
		                            
		                        	<td><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
		                        	
		                        	<td><g:select name="tireOccurrenceInStock" from="${0..tireOccurrenceInstance.numberOfAvailable()}"  value="${order?.customer?.id}" /></td>
		                        	
		                        	<td><g:textField maxlength="40" tabindex='1' name="price" value="${customerOrderLine?.price}" /></td>
		                        	<g:hiddenField name="tireOccurrenceId" value="${tireOccurrenceInstance.id}" />
		                        	<g:hiddenField name="tireId" value="${tireOccurrenceInstance.tire.id}" />
		                        </tr>
		                    </g:each>
        					<g:hiddenField name="numberOfTireOccurrences" value="${numberOfTireOccurrences}" />
											
						</tbody>
					</table>
						<span class="button"><g:actionSubmit action="next" method="get" name="showTireOccurrences" class="next" value="${message(code: 'default.label', default: 'Legg til i ordre')}" /></span>
					<table>
						<tbody>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="notice"><g:message code="customerOrder.notice.label" default="Notice" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderInstance, field: 'notice', 'errors')}">
                                    <g:textArea name="notice" cols="40" rows="5" value="${customerOrderInstance?.notice}" />
                                </td>
                            </tr>
	                    </tbody>
					</table>
                </div>
                
                <g:form controller="customerOrderLine" action="save" method="post" >
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    <span class="button"><g:submitButton name="createNew" class="create" value="${message(code: 'default.label', default: 'Tilbake')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>