
<%@ page import="no.pstop.webapp.CustomerOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrder.label', default: 'CustomerOrder')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'customerOrder.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'customerOrder.orderDate.label', default: 'Order Date')}" />
                        
                            <g:sortableColumn property="notice" title="${message(code: 'customerOrder.notice.label', default: 'Notice')}" />
                        
                            <th><g:message code="customerOrder.customer.label" default="Customer" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerOrderInstanceList}" status="i" var="customerOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerOrderInstance.id}">${fieldValue(bean: customerOrderInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance.orderDate}" /></td>
                        
                            <td>${fieldValue(bean: customerOrderInstance, field: "notice")}</td>
                        
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
