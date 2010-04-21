
<%@ page import="no.pstop.webapp.SupplierOrderLine" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'supplierOrderLine.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="price" title="${message(code: 'supplierOrderLine.price.label', default: 'Price')}" />
                        
                            <g:sortableColumn property="discount" title="${message(code: 'supplierOrderLine.discount.label', default: 'Discount')}" />
                        
                            <g:sortableColumn property="environmentalFee" title="${message(code: 'supplierOrderLine.environmentalFee.label', default: 'Environmental Fee')}" />
                        
                            <th><g:message code="supplierOrderLine.supplierOrder.label" default="Supplier Order" /></th>
                   	    
                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.numberOfOrderedTires.label', default: 'Number Of Ordered Tires')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${supplierOrderLineInstanceList}" status="i" var="supplierOrderLineInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${supplierOrderLineInstance.id}">${fieldValue(bean: supplierOrderLineInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: supplierOrderLineInstance, field: "price")}</td>
                        
                            <td>${fieldValue(bean: supplierOrderLineInstance, field: "discount")}</td>
                        
                            <td>${fieldValue(bean: supplierOrderLineInstance, field: "environmentalFee")}</td>
                        
                            <td>${fieldValue(bean: supplierOrderLineInstance, field: "supplierOrder")}</td>
                        
                            <td>${fieldValue(bean: supplierOrderLineInstance, field: "numberOfOrderedTires")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${supplierOrderLineInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
