
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tire.label', default: 'Tire')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tireInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="partNr"><g:message code="tire.partNr.label" default="Part Nr" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'partNr', 'errors')}">
                                    <g:textField name="partNr" value="${tireInstance?.partNr}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="width"><g:message code="tire.width.label" default="Width" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'width', 'errors')}">
                                    <g:textField name="width" value="${fieldValue(bean: tireInstance, field: 'width')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="profile"><g:message code="tire.profile.label" default="Profile" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'profile', 'errors')}">
                                    <g:textField name="profile" value="${fieldValue(bean: tireInstance, field: 'profile')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="construction"><g:message code="tire.construction.label" default="Construction" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'construction', 'errors')}">
                                    <g:textField name="construction" value="${tireInstance?.construction}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="diameter"><g:message code="tire.diameter.label" default="Diameter" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'diameter', 'errors')}">
                                    <g:textField name="diameter" value="${fieldValue(bean: tireInstance, field: 'diameter')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loadIndex"><g:message code="tire.loadIndex.label" default="Load Index" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'loadIndex', 'errors')}">
                                    <g:textField name="loadIndex" value="${fieldValue(bean: tireInstance, field: 'loadIndex')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="speedIndex"><g:message code="tire.speedIndex.label" default="Speed Index" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'speedIndex', 'errors')}">
                                    <g:select name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}" value="${tireInstance?.speedIndex}" valueMessagePrefix="tire.speedIndex"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pattern"><g:message code="tire.pattern.label" default="Pattern" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'pattern', 'errors')}">
                                    <g:textField name="pattern" value="${tireInstance?.pattern}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireType"><g:message code="tire.tireType.label" default="Tire Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'tireType', 'errors')}">
                                    <g:select name="tireType" from="${tireInstance.constraints.tireType.inList}" value="${tireInstance?.tireType}" valueMessagePrefix="tire.tireType"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
