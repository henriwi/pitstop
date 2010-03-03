
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.list.title.label" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="tireHotelOccurrence.home.label" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="tireHotelOccurrence.list.header.label"/></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'tireHotelOccurrence.list.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label', default: 'Tire Location')}" />
                        
                            <g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label', default: 'Registration Number')}" />
                        
                            <g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label', default: 'Car Type')}" />
                        
                            <g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label', default: 'Tire Type')}" />
                        
                            <g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label', default: 'In Date')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</td>
                        
                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</td>
                        
                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</td>
                        
                            <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</td>
                        
                            <td><g:formatDate date="${tireHotelOccurrenceInstance.inDate}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tireHotelOccurrenceInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
