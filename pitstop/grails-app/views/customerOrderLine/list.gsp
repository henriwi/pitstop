
<%@ page import="no.pstop.webapp.CustomerOrderLine" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrderLine.label', default: 'CustomerOrderLine')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'customerOrderLine.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="numberOfOrderedTireOccurrences" title="${message(code: 'customerOrderLine.numberOfOrderedTireOccurrences.label', default: 'Number Of Ordered Tire Occurrences')}" />
                        
                            <g:sortableColumn property="price" title="${message(code: 'customerOrderLine.price.label', default: 'Price')}" />
                        
                            <g:sortableColumn property="deliveryDate" title="${message(code: 'customerOrderLine.deliveryDate.label', default: 'Delivery Date')}" />
                        
                            <th><g:message code="customerOrderLine.tireOccurrence.label" default="Tire Occurrence" /></th>
                   	    
                            <th><g:message code="customerOrderLine.customerOrder.label" default="Customer Order" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerOrderLineInstanceList}" status="i" var="customerOrderLineInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerOrderLineInstance.id}">${fieldValue(bean: customerOrderLineInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: customerOrderLineInstance, field: "numberOfOrderedTireOccurrences")}</td>
                        
                            <td>${fieldValue(bean: customerOrderLineInstance, field: "price")}</td>
                        
                            <td><g:formatDate date="${customerOrderLineInstance.deliveryDate}" /></td>
                        
                            <td>${fieldValue(bean: customerOrderLineInstance, field: "tireOccurrence")}</td>
                        
                            <td>${fieldValue(bean: customerOrderLineInstance, field: "customerOrder")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerOrderLineInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
