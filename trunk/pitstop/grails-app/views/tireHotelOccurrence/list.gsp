
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.list.title.label" /></title>
    </head>
    <body>
        <div class="nav">
			<span class="menuButton"><g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link></span>
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
                            <g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label')}" />
                        
                            <g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label')}" />
                        
                            <g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label')}" />
                        
                            <g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label')}" />
                        
                            <g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label')}" />
                            
                            <g:sortableColumn property="outDate" title="${message(code: 'tireHotelOccurrence.list.outDate.label')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></g:link></td>
                            
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.outDate}" /></g:link></td>
                        
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
