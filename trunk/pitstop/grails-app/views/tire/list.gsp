
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tire.label', default: 'Tire')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'tire.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="diameter" title="${message(code: 'tire.diameter.label', default: 'Diameter')}" />
                        
                            <g:sortableColumn property="partNr" title="${message(code: 'tire.partNr.label', default: 'Part Nr')}" />
                        
                            <g:sortableColumn property="width" title="${message(code: 'tire.width.label', default: 'Width')}" />
                        
                            <g:sortableColumn property="loadIndex" title="${message(code: 'tire.loadIndex.label', default: 'Load Index')}" />
                        
                            <g:sortableColumn property="pattern" title="${message(code: 'tire.pattern.label', default: 'Pattern')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireInstanceList}" status="i" var="tireInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "diameter")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "partNr")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "width")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "loadIndex")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "pattern")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tireInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
