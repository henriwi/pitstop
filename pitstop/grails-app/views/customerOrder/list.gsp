
<%@ page import="no.pstop.webapp.CustomerOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrder.label', default: 'CustomerOrder')}" />
        <title><g:message code="customerOrder.list.header.label" /></title>
    </head>
    <body>
        <div class="nav">
       		<span class="menuButton" id="${params.action == 'list' || params.action == 'save'? 'active' : ''}" >
       			<g:link class="list" action="list"><g:message code="customer.listCustomerOrder.list.label" /></g:link>
       		</span>
       		<span class="menuButton" id="${params.action == 'create' ? 'active' : ''}" >
       			<g:link class="create" action="create"><g:message code="customer.addOrder.new.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <h1><g:message code="customerOrder.list.header.label" args="[entityName]" /></h1>
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
                    <g:each in="${customerOrderInstanceList}" status="i" var="customerOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerOrderInstance.id}">${fieldValue(bean: customerOrderInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate format="dd.MM.yyyy HH:mm" date="${customerOrderInstance.orderDate}" /></td>
                        
                            <td>${fieldValue(bean: customerOrderInstance, field: "customer")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
