
<%@ page import="no.pstop.webapp.TireOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireOccurrence.label', default: 'TireOccurrence')}" />
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
            <g:hasErrors bean="${tireOccurrenceInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireOccurrenceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="tireOccurrence.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: tireOccurrenceInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberInStock"><g:message code="tireOccurrence.numberInStock.label" default="Number In Stock" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberInStock', 'errors')}">
                                    <g:textField name="numberInStock" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberInStock')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfReserved"><g:message code="tireOccurrence.numberOfReserved.label" default="Number Of Reserved" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberOfReserved', 'errors')}">
                                    <g:textField name="numberOfReserved" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberOfReserved')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfOrdered"><g:message code="tireOccurrence.numberOfOrdered.label" default="Number Of Ordered" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberOfOrdered', 'errors')}">
                                    <g:textField name="numberOfOrdered" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberOfOrdered')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfAvailable"><g:message code="tireOccurrence.numberOfAvailable.label" default="Number Of Available" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberOfAvailable', 'errors')}">
                                    <g:textField name="numberOfAvailable" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberOfAvailable')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="date"><g:message code="tireOccurrence.date.label" default="Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'date', 'errors')}">
                                    <g:datePicker name="date" precision="day" value="${tireOccurrenceInstance?.date}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tire"><g:message code="tireOccurrence.tire.label" default="Tire" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'tire', 'errors')}">
                                    <g:select name="tire.id" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${tireOccurrenceInstance?.tire?.id}"  />
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
