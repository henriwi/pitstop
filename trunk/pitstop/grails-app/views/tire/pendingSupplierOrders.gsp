
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tire.pendingSupplierOrders.title.label" /></title>
    </head>
    <body>
        <div class="nav">
        	<span class="menuButton" id="${params.action == 'list' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'create' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'search' && params.controller == 'tire' ? 'active' : ''}" >
	    		<g:link controller="tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link>
       		</span>
       		
       		<span class="menuButton" id="${params.action == 'pendingSupplierOrders' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link class="pendingSupplierOrders" action="pendingSupplierOrders"><g:message code="tire.pendingSupplierOrders.title.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <h1><g:message code="tire.pendingSupplierOrders.title.label" /></h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'supplierOrder.list.table.orderNumber.label', default: 'ID')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.list.table.orderDate.label', default: 'Order Date')}" />
                        
                            <th><g:message code="supplierOrder.list.table.customer.label" default="Supplier" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
	                    <g:each in="${supplierOrderWithoutReceivedDateInstanceList}" status="i" var="supplierOrderWithoutReceivedDateInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        
	                            <td><g:link action="show" id="${supplierOrderWithoutReceivedDateInstance.id}">${fieldValue(bean: supplierOrderWithoutReceivedDateInstance, field: "id")}</g:link></td>
	                        
	                            <td><g:formatDate format="dd.MM.yyyy hh:mm" date="${supplierOrderWithoutReceivedDateInstance.orderDate}" /></td>
	                        
	                            <td>${fieldValue(bean: supplierOrderWithoutReceivedDateInstance, field: "supplier")}</td>
	                        
	                        </tr>
	                    </g:each>
                    </tbody>
                </table>
            </div>
       	</div>
    </body>
</html>
