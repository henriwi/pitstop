
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Hjem</a></span>
            <span class="menuButton"><g:link class="create" action="create">Ny dekktype</g:link></span>
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
                            
                            <g:sortableColumn property="partNr" title="${message(code: 'tire.partNr.label', default: 'Varenummer')}" />
                        
                            <g:sortableColumn property="brand" title="${message(code: 'tire.brand.label', default: 'Merke')}" />

                            <g:sortableColumn property="width" title="${message(code: 'tire.width.label', default: 'Bredde')}" />
                        
                            <g:sortableColumn property="profile" title="${message(code: 'tire.profile.label', default: 'Profil')}" />
                        
                            <g:sortableColumn property="construction" title="${message(code: 'tire.construction.label', default: 'Konstruksjon')}" />
                        
                            <g:sortableColumn property="diameter" title="${message(code: 'tire.diameter.label', default: 'Felgdiameter')}" />
                            
                            <g:sortableColumn property="loadIndex" title="${message(code: 'tire.loadIndex.label', default: 'Belastningsindeks')}" />
                            
                            <g:sortableColumn property="speedIndex" title="${message(code: 'tire.speedIndex.label', default: 'Hastighetsindeks')}" />
                            
                            <g:sortableColumn property="pattern" title="${message(code: 'tire.loadIndex.label', default: 'M&oslash;nster')}" />
                            
                            <g:sortableColumn property="tireType" title="${message(code: 'tire.speedIndex.label', default: 'Dekktype')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireInstanceList}" status="i" var="tireInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "partNr")}</g:link></td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "brand")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "width")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "profile")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "construction")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "diameter")}</td>
                            
                            <td>${fieldValue(bean: tireInstance, field: "loadIndex")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "speedIndex")}</td>
                            
                            <td>${fieldValue(bean: tireInstance, field: "pattern")}</td>
                        
                            <td>${fieldValue(bean: tireInstance, field: "tireType")}</td>
                        
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
