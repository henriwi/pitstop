
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${message(code: 'tireList.title.label')}</title>
    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
		    <span class="menuButton"><g:link controller="tireOccurrence" class="create" action="create"><g:message code="default.button.newTireOccurrence.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>
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
                            <g:sortableColumn params="${params}" property="partNr" title="${message(code: 'tire.partNr.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="brand" title="${message(code: 'tire.brand.table.label')}" />

                            <g:sortableColumn params="${params}" property="tireName" title="${message(code: 'tire.tireName.table.label')}" />

                            <g:sortableColumn params="${params}" property="width" title="${message(code: 'tire.width.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="profile" title="${message(code: 'tire.profile.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="construction" title="${message(code: 'tire.construction.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="diameter" title="${message(code: 'tire.diameter.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="loadIndex" title="${message(code: 'tire.index.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="pattern" title="${message(code: 'tire.pattern.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="tireType" title="${message(code: 'tire.tireType.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="tireType" title="${message(code: 'tireOccurrence.numberOfAvailable.table.label')}" />
                        </tr>
                    </thead>
                    <tbody>
						
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
                            
                            <g:set var="numberOfAvailable" value="${0}"></g:set>
                            <g:each in="${tireInstance.tireOccurrences}" status="j" var="tireOccurrence">
                             	<g:set var="numberOfAvailable" value="${numberOfAvailable + (tireOccurrence.numberOfAvailable())}"></g:set>
                            </g:each>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${numberOfAvailable}</g:link></td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
             	<g:paginate next="Neste" prev="Forrige" controller="tire" action="list" params="${params}" total="${tireInstanceTotal}"></g:paginate>
            </div>
        </div>
    </body>
</html>
