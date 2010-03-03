
<%@ page import="no.pstop.webapp.TireHotelOccurence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'tireHotelOccurence.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurence.tireLocation.label', default: 'Tire Location')}" />
                        
                            <g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurence.registrationNumber.label', default: 'Registration Number')}" />
                        
                            <g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurence.carType.label', default: 'Car Type')}" />
                        
                            <g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurence.tireType.label', default: 'Tire Type')}" />
                        
                            <g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurence.inDate.label', default: 'In Date')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireHotelOccurenceInstanceList}" status="i" var="tireHotelOccurenceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireHotelOccurenceInstance.id}">${fieldValue(bean: tireHotelOccurenceInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: tireHotelOccurenceInstance, field: "tireLocation")}</td>
                        
                            <td>${fieldValue(bean: tireHotelOccurenceInstance, field: "registrationNumber")}</td>
                        
                            <td>${fieldValue(bean: tireHotelOccurenceInstance, field: "carType")}</td>
                        
                            <td>${fieldValue(bean: tireHotelOccurenceInstance, field: "tireType")}</td>
                        
                            <td><g:formatDate date="${tireHotelOccurenceInstance.inDate}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tireHotelOccurenceInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
