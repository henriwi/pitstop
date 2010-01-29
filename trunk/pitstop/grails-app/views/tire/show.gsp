
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tire.label', default: 'Tire')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.diameter.label" default="Diameter" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "diameter")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.partNr.label" default="Part Nr" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "partNr")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.width.label" default="Width" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "width")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.loadIndex.label" default="Load Index" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "loadIndex")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.pattern.label" default="Pattern" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "pattern")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.speedIndex.label" default="Speed Index" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "speedIndex")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.tireType.label" default="Tire Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "tireType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.construction.label" default="Construction" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "construction")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.profile.label" default="Profile" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "profile")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${tireInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
