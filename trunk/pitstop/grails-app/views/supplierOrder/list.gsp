
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrder.label', default: 'SupplierOrder')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'supplierOrder.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.orderDate.label', default: 'Order Date')}" />
                        
                            <g:sortableColumn property="orderNumber" title="${message(code: 'supplierOrder.orderNumber.label', default: 'Order Number')}" />
                        
                            <g:sortableColumn property="supplier" title="${message(code: 'supplierOrder.supplier.label', default: 'Supplier')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${supplierOrderInstanceList}" status="i" var="supplierOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${supplierOrderInstance.id}">${fieldValue(bean: supplierOrderInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${supplierOrderInstance.orderDate}" /></td>
                        
                            <td>${fieldValue(bean: supplierOrderInstance, field: "orderNumber")}</td>
                        
                            <td>${fieldValue(bean: supplierOrderInstance, field: "supplier")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${supplierOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
