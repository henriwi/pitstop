
<%@ page import="no.pstop.webapp.TireOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireOccurence.show.title.label"/> - ${tireOccurrenceInstance?.tire?.encodeAsHTML()}</title>
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
            <h1><g:message code="tireOccurence.show.title.label" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.price.label" /></td>
                            <td valign="top" class="value"><g:formatNumber number="${tireOccurrenceInstance.price}" format="#.00 kr" /></td>
                        </tr>
                       	<tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.discount.label" /></td>
                            <td valign="top" class="value"><g:formatNumber number="${tireOccurrenceInstance.discount}" format="#" /> %</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.environmentalFee.label" /></td>
                            <td valign="top" class="value"><g:formatNumber number="${tireOccurrenceInstance.environmentalFee}" format="# kr" /></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.sum.label" /></td>
                            <td valign="top" class="value"><g:formatNumber number="${tireOccurrenceInstance.sum()}" format="#.00 kr" /></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberInStock.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberOfReserved.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberOfOrdered.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberOfAvailable.label" /></td>
                            <td valign="top" class="value">${tireOccurrenceInstance.numberOfAvailable()}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.registrationDate.label" /></td>
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.tire.label" /></td>
                            <td valign="top" class="value"><g:link controller="tire" action="show" id="${tireOccurrenceInstance?.tire?.id}">${tireOccurrenceInstance?.tire?.encodeAsHTML()}</g:link></td>
                        </tr>
                        
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${tireOccurrenceInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
