
<%@ page import="no.pstop.webapp.TireOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireOccurrence.label', default: 'dekkforekomst')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label" default="Dekkliste" /></g:link></span>
	        <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label" default="Nytt dekk" /></g:link></span>
	        <span class="menuButton"><g:link controller="tireOccurrence" class="create" action="create"><g:message code="Ny dekkforekomst" args="[entityName]" /></g:link></span>
	        <span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label" default="Dekkforekomster" /></g:link></span>
	        <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label" default="S&oslash;k" /></g:link></span>       
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
                                    <label for="tire"><g:message code="tireOccurrence.tire.label" default="Dekktype" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'tire', 'errors')}">
                                    <g:select name="tire.id" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${tireOccurrenceInstance?.tire?.id}"  />
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
                                    <label for="price"><g:message code="tireOccurrence.price.label" default="Innkj&oslash;pspris" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: tireOccurrenceInstance, field: 'price')}" />
                                </td>
                            </tr>                                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="registrationDate"><g:message code="tireOccurrence.registrationDate.label" default="Ankomstdato" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'registrationDate', 'errors')}">
<!-- TODO finne �rstall automatisk eller � finne en ny datechooser -->
                                    <g:datePicker name="registrationDate" precision="day" years="${2010..2030}" value="${tireOccurrenceInstance?.registrationDate}" />
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
