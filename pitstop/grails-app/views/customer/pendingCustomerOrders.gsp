
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.pendingCustomerOrders.title.label" /></title>
    </head>
    <body>
        <div class="nav">
        	<span class="menuButton" id="${params.action == 'list' ? 'active' : ''}" >
       			<g:link class="list" action="list"><g:message code="customer.list.label" /></g:link>
       		</span>
        
       		<span class="menuButton" id="${params.action == 'create' ? 'active' : ''}"  >
       			<g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link>
       		</span>
       		
       		<span class="menuButton" id="${params.action == 'pendingCustomerOrders' ? 'active' : ''}" >
       			<g:link class="pendingCustomerOrders" action="pendingCustomerOrders"><g:message code="customer.pendingCustomerOrders.title.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <h1><g:message code="customer.pendingCustomerOrders.header.label" /></h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'customerOrder.list.table.orderNumber.label', default: 'ID')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'customerOrder.list.table.orderDate.label', default: 'Order Date')}" />
                        
                            <th><g:message code="customerOrder.list.table.customer.label" default="Customer" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
	                    <g:each in="${customerOrderWithoutDeliveredDateInstanceList}" status="i" var="customerOrderWithoutDeliveredDateInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        
	                            <td><g:link action="show" id="${customerOrderWithoutDeliveredDateInstance.id}">${fieldValue(bean: customerOrderWithoutDeliveredDateInstance, field: "id")}</g:link></td>
	                        
	                            <td><g:formatDate format="dd.MM.yyyy hh:mm" date="${customerOrderWithoutDeliveredDateInstance.orderDate}" /></td>
	                        
	                            <td>${fieldValue(bean: customerOrderWithoutDeliveredDateInstance, field: "customer")}</td>
	                        
	                        </tr>
	                    </g:each>
                    </tbody>
                </table>
            </div>
       	</div>
    </body>
</html>
