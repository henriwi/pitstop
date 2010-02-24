
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tire.label', default: 'dekktype')}" />
        <title>Dekktyper</title>
    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label" default="Dekkliste" /></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label" default="Nytt dekk" /></g:link></span>
		    <span class="menuButton"><g:link controller="tireOccurrence" class="create" action="create"><g:message code="default.button.newTireOccurrence.label" default="Ny dekkforekomst"  /></g:link></span>
	    	<span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label" default="Dekkforekomster" /></g:link></span>
	    	<span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label" default="Søk" /></g:link></span>
        </div>
        <div class="body">
            <h1>Dekktyper</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="partNr" title="${message(code: 'tire.partNr.table.label', default: 'Varenummer')}" />
                        
                            <g:sortableColumn property="brand" title="${message(code: 'tire.brand.table.label', default: 'Merke')}" />

                            <g:sortableColumn property="tireName" title="${message(code: 'tire.tireName.table.label', default: 'Dekknavn')}" />

                            <g:sortableColumn property="width" title="${message(code: 'tire.width.table.label', default: 'Bredde')}" />
                        
                            <g:sortableColumn property="profile" title="${message(code: 'tire.profile.table.label', default: 'Profil')}" />
                        
                            <g:sortableColumn property="construction" title="${message(code: 'tire.construction.table.label', default: 'Konstruksjon')}" />
                        
                            <g:sortableColumn property="diameter" title="${message(code: 'tire.diameter.table.label', default: 'Felgdiameter')}" />
                            
                            <g:sortableColumn property="index" title="${message(code: 'tire.index.table.label', default: 'Indeks')}" />
                            
                            <g:sortableColumn property="pattern" title="${message(code: 'tire.pattern.table.label', default: 'Mønster')}" />
                            
                            <g:sortableColumn property="tireType" title="${message(code: 'tire.tireType.table.label', default: 'Dekktype')}" />
                            
                            <g:sortableColumn property="tireType" title="${message(code: 'tireOccurrence.numberOfAvailable.table.label', default: 'Tilgjengelig')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:set var="numberOfAvailableIndex" value="${0}"></g:set>
                    <g:each in="${tireInstanceList}" status="i" var="tireInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "partNr")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "brand")}</g:link></td>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "tireName")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "width")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "profile")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "construction")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "diameter")}</g:link></td>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "loadIndex")}${fieldValue(bean: tireInstance, field: "speedIndex")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "pattern")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "tireType")}</g:link></td>
             				<g:if test="${numberOfAvailable[numberOfAvailableIndex][0] == tireInstance.id}">
                            	<td><g:link action="show" id="${tireInstance.id}">${numberOfAvailable[numberOfAvailableIndex][1]}</g:link></td>
                            	<g:set var="numberOfAvailableIndex" value="${numberOfAvailableIndex + 1}"></g:set>
                            </g:if>
                            <g:else>
                            	<td><g:link action="show" id="${tireInstance.id}">${0}</g:link></td>
                            </g:else>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
             	<g:paginate next="Neste" prev="Forrige" controller="tire"
            	action="list" total="${tireInstanceTotal}"></g:paginate>
            </div>
        </div>
    </body>
</html>
