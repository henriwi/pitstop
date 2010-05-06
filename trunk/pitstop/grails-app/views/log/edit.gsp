
<%@ page import="no.pstop.webapp.Log" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'log.label', default: 'Log')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:hasErrors bean="${logInstance}">
            	<div class="errors">
            	    <g:renderErrors bean="${logInstance}" as="list" />
            	</div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${logInstance?.id}" />
                <g:hiddenField name="version" value="${logInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="log.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: logInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${no.pstop.webapp.User.list()}" optionKey="id" value="${logInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="date"><g:message code="log.date.label" default="Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: logInstance, field: 'date', 'errors')}">
                                    <g:datePicker name="date" precision="day" value="${logInstance?.date}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="event"><g:message code="log.event.label" default="Event" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: logInstance, field: 'event', 'errors')}">
                                    <g:textField name="event" value="${logInstance?.event}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
