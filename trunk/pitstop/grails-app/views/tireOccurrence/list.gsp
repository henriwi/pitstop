
<%@ page import="no.pstop.webapp.TireOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireOccurrence.label', default: 'TireOccurrence')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'tireOccurrence.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="tire" title="${message(code: 'tireOccurrence.tire.label', default: 'Dekktype')}" />
                                              	    
                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.price.label', default: 'Pris')}" />
                        
                            <g:sortableColumn property="numberInStock" title="${message(code: 'tireOccurrence.numberInStock.label', default: 'Antall')}" />
                        
                            <g:sortableColumn property="numberOfReserved" title="${message(code: 'tireOccurrence.numberOfReserved.label', default: 'Reservert')}" />
                        
                            <g:sortableColumn property="numberOfOrdered" title="${message(code: 'tireOccurrence.numberOfOrdered.label', default: 'Bestilt')}" />
                        
                            <g:sortableColumn property="numberOfAvailable" title="${message(code: 'tireOccurrence.numberOfAvailable.label', default: 'Tiljengelighet')}" />
                        
                        	<g:sortableColumn property="registrationDate" title="${message(code: 'tireOccurrence.registrationDate.label', default: 'Registreringsdato')}" />
                        
 
                        
                        	
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireOccurrenceInstanceList}" status="i" var="tireOccurrenceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "id")}</g:link></td>
                        
                        	<td>${fieldValue(bean: tireOccurrenceInstance, field: "tire")}</td>
                        	
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "price")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberOfAvailable")}</td>
                        
                        	<td>${fieldValue(bean: tireOccurrenceInstance, field: "registrationDate")}</td>
                        
                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tireOccurrenceInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
