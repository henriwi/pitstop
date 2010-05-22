
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customerOrder.pendingCustomerOrders.title.label" /></title>
    </head>
    <body>
        <div class="nav">
       		<span class="menuButton" id="${params.action == 'pendingCustomerOrders' ? 'active' : ''}" >
       			<g:link class="pendingCustomerOrders" action="pendingCustomerOrders"><g:message code="customerOrder.pendingCustomerOrders.title.label" /></g:link>
       		</span>
       		<span class="menuButton" id="${(params.action == 'create' || params.action == 'save') ? 'active' : ''}" >
       			<g:link class="create" action="create"><g:message code="customerOrder.create.title.label" /></g:link>
       		</span>
       		<span class="menuButton" id="${params.action == 'list' ? 'active' : ''}" >
       			<g:link class="list" action="list"><g:message code="customerOrder.list.title.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="customerOrder.pendingCustomerOrders.header.label" /></h1>
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'customerOrder.list.table.orderNumber.label')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'customerOrder.list.table.orderDate.label')}" />
                        
                            <th><g:message code="supplierOrder.list.table.customer.label" default="Customer" /></th>
                            
                        </tr>
                    </thead>
                    <tbody>
	                    <g:each in="${customerOrderWithoutDeliveredDateInstanceList}" status="i" var="customerOrderWithoutDeliveredDateInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        
								<td><modalbox:createLink controller="customerOrder" action="show" id="${customerOrderWithoutDeliveredDateInstance?.id}" title="Kundeordre" width="700">${customerOrderWithoutDeliveredDateInstance?.id}</modalbox:createLink></td>
									                        
	                            <td><g:formatDate format="dd.MM.yyyy HH:mm" date="${customerOrderWithoutDeliveredDateInstance.orderDate}" /></td>
	                        
	                            <td>${fieldValue(bean: customerOrderWithoutDeliveredDateInstance, field: "customer")}</td>
	                        	
	                        </tr>
	                    </g:each>
                    </tbody>
                </table>
            </div>
       	</div>
    </body>
</html>
