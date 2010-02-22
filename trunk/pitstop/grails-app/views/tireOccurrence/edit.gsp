
<%@ page import="no.pstop.webapp.TireOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireOccurrence.label', default: 'TireOccurrence')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tireOccurrenceInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireOccurrenceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${tireOccurrenceInstance?.id}" />
                <g:hiddenField name="version" value="${tireOccurrenceInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="price"><g:message code="tireOccurrence.price.label" default="Pris" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: tireOccurrenceInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numberInStock"><g:message code="tireOccurrence.numberInStock.label" default="Antall" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberInStock', 'errors')}">
                                    <g:textField name="numberInStock" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberInStock')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numberOfReserved"><g:message code="tireOccurrence.numberOfReserved.label" default="Reservert" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberOfReserved', 'errors')}">
                                    <g:textField name="numberOfReserved" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberOfReserved')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numberOfOrdered"><g:message code="tireOccurrence.numberOfOrdered.label" default="Bestilt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberOfOrdered', 'errors')}">
                                    <g:textField name="numberOfOrdered" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberOfOrdered')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numberOfAvailable"><g:message code="tireOccurrence.numberOfAvailable.label" default="Tilgjengelig" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberOfAvailable', 'errors')}">
                                    <g:textField name="numberOfAvailable" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberOfAvailable')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="registrationDate"><g:message code="tireOccurrence.registrationDate.label" default="Dato" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'registrationDate', 'errors')}">
                                    <g:datePicker name="registrationDate" precision="day" value="${tireOccurrenceInstance?.registrationDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tire"><g:message code="tireOccurrence.tire.label" default="Dekktype" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'tire', 'errors')}">
                                    <g:select name="tire.id" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${tireOccurrenceInstance?.tire?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
					<span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Er du sikker?')}');" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
