
<%@ page import="no.pstop.webapp.TireOccurrence" %>

<%@page import="no.pstop.webapp.TireOccurrence"%><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireOccurrence.label', default: 'Dekkforekomst')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Hjem</a></span>
            <span class="menuButton"><g:link class="list" controller="tire" action="list">Dekkliste</g:link></span>
            <span class="menuButton"><g:link class="create" controller="tire" action="create">Nytt dekk</g:link></span>
            <span class="menuButton"><g:link class="list" action="list">Vis dekkforekomster</g:link></span>
            <span class="menuButton"><g:link class="search" controller="tire" action="search">S&oslash;k</g:link></span>        </div>
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
                        
                        	<td><g:link action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "tire")}</g:link></td>
                        	
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "price")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</td>
                        
                            <td>${tireOccurrenceInstance.numberInStock-tireOccurrenceInstance.numberOfReserved}</td>
                            
                            <td><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate next="Neste" prev="Forrige" maxsteps="5" max="1" controller="tireOccurrence"
            action="list" total="${tireOccurrenceInstanceTotal}"></g:paginate>
            </div>
        </div>
    </body>
</html>
