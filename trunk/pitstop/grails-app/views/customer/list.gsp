
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.list.title.label" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="customer.new.label" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="customer.list.header.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'customer.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="firstName" title="${message(code: 'customer.firstName.label', default: 'First Name')}" />
                        
                            <g:sortableColumn property="lastName" title="${message(code: 'customer.lastName.label', default: 'Last Name')}" />
                        
                            <g:sortableColumn property="phoneNumber" title="${message(code: 'customer.phoneNumber.label', default: 'Phone Number')}" />
                        
                            <g:sortableColumn property="address" title="${message(code: 'customer.address.label', default: 'Address')}" />
                        
                            <g:sortableColumn property="postalCode" title="${message(code: 'customer.postalCode.label', default: 'Postal Code')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerInstanceList}" status="i" var="customerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "firstName")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "lastName")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "phoneNumber")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "address")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "postalCode")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
