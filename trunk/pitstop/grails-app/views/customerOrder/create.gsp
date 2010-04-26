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
       		<span class="menuButton" id="${params.action == 'list' ? 'active' : ''}" >
       			<g:link class="list" action="list"><g:message code="customer.listCustomerOrder.list.label" /></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'create' ? 'active' : ''}" >
       			<g:link class="create" action="create"><g:message code="customer.addOrder.new.label" /></g:link>
       		</span>
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
                <div id="customerOrderDialog">
	                <div id="customerAndTireInfo">
	                	<g:form action="showTireInfo" method="get">
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
											<g:select onChange="this.form.submit()" noSelection="${[0:'Velg dekk']}" name="tireId" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${tire?.id}" />
										</td>
			                    	</tr>
		                  			<tr class="prop">
		                                <td valign="top" class="notice">
		                                    <label for="tire"><g:message code="customerOrderLine.notice.label" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'notice', 'errors')}">
		                                	<g:textArea value="${order?.notice }" tabindex='13' name="notice" rows="5" cols="10"/>
										</td>
			                    	</tr>
		                        </tbody>
		                    </table>
	                    </g:form>
	                 </div>
	                 <div id="customerOrderTireInfo">
	                 <g:if test="${tire}"> 
		                 <g:form action="addToOrder" method="post">
		                 	<table>
		                 		<tbody>
		                 			<tr class="prop">
		                 				<td><g:message code="customerOrder.retailPrice.label"></g:message></td>
		                 				<td><g:formatNumber number="${tire?.retailPrice }" format="#0.00 kr" /></td>
		                 			</tr>
		                 			<tr class="prop">
		                 				<td><g:message code="customerOrder.highestPrice.label"></g:message></td>
		                 				<td><g:formatNumber number="${tire?.highestPrice()}" format="#0.00 kr" /></td>
		                 			</tr>
		                 			<tr class="prop">
		                 				<td><g:message code="customerOrder.averagePrice.label"></g:message></td>
		                 				<td><g:formatNumber number="${tire?.averagePrice() }" format="#0.00 kr" /></td>
		                 			</tr>
		 							<tr class="prop">
		                                <td valign="top" class="name"><label for="price"><g:message code="customerOrderLine.price.label" /></label></td>
		                                <td><g:textField maxlength="30" tabindex='12' name="price" value="" /></td>
		                            </tr>
		                         	<tr class="prop">
		                                <td valign="top" class="name"><label for="numberOfReservedTires"><g:message code="customerOrderLine.numberOfReservedTires.label" /></label></td>
		                                <td><g:textField maxlength="30" tabindex='12' name="numberOfReservedTires" value="" /></td>
		                            </tr>
		                            <tr>
		                            	<td><span class="button"><g:submitButton name="showTireOccurrences" class="next" value="${message(code: 'customerOrder.addToOrder.label')}" /></span></td>
		                            </tr>
		                 		</tbody>
		                 	</table>
		                 </g:form>
		             	</g:if>
		             </div>
	           	</div>
                 
                <div id="customerOrderedItems">
                	<table>
                		<thead>
	                		<tr class="prop">
		                		<th><a class="notSortableColoumn">${message(code: 'customerOrderLine.tire.table.label')}</a></th>
	
		                		<th id="customerOrderPriceHeader"><a class="notSortableColoumn">${message(code: 'customerOrderLine.price.table.label')}</a></th>
		                		
		                		<th id="customerOrderDeleteHeader"><a class="notSortableColoumn">${message(code: 'customerOrderLine.numberOfReservedTires.table.label')}</a></th>
		                		
		                		<th id="customerOrderDeleteHeader"><a class="notSortableColoumn">${message(code: 'customerOrderLine.deleteFromOrder.table.label')}</a></th>
		                	</tr>
		                </thead>
	                	<tbody>
	                	
	                	<g:set var="orderLineIndex" value="${0}"></g:set>
										<g:each in="${orderLines}" status="i" var="orderLineInstance">
										<g:hasErrors bean="${orderLineInstance}">
				            <div class="errors">
				                <g:renderErrors bean="${orderLineInstance}" as="list" />
				            </div>
			            </g:hasErrors>
							<tr>
                      			<td>${orderLineInstance?.tire}</td>
                      			<td><g:formatNumber number="${orderLineInstance?.price}" format="#.00 kr" /></td>
                      			<td>${orderLineInstance?.numberOfReservedTires}</td>
								<td>
                          			<g:form action="deleteFromOrder" method="post">
                          				<g:hiddenField name="orderLineIndex" value="${orderLineIndex}" />
                          				<g:submitButton class="deleteTableItem" name="deleteFromOrder" title="${message(code: 'customerOrder.list.delete.tooltip.label')}" value="${message(code: 'list.button.table.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
                          			</g:form>
                         		</td>  
							</tr>
							<g:set var="orderLineIndex" value="${orderLineIndex + 1}"></g:set>
					</g:each>
                   	</tbody>
            		</table>
                
	                <g:form action="save" method="post" >
	                	<div class="buttons">
	                    	<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'customerOrder.button.create.label')}" /></span>
	                    	<span class="button"><g:actionSubmit tabindex='13' class="cancel" action="list" value="${message(code: 'createTire.button.cancel.label')}" onclick="return confirm('${message(code: 'createTire.button.cancel.confirm.message')}');" /></span>
	                	</div>
	            	</g:form>
	            </div>
        </div>
    </body>
</html>
