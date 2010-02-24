
<%@ page import="no.pstop.webapp.TireOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireOccurrence.label', default: 'Dekkforekomst')}" />
        <title><g:message code="tireoccurrence.show.label" args="[entityName]" /> - ${tireOccurrenceInstance?.tire?.encodeAsHTML()}</title>
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
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.price.label" default="Pris:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireOccurrenceInstance, field: "price")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberInStock.label" default="Antall:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberOfReserved.label" default="Reservert:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberOfOrdered.label" default="Bestilt:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.numberOfAvailable.label:" default="Tilgjengelig:" /></td>
                            
                            <td valign="top" class="value">${tireOccurrenceInstance.numberInStock-tireOccurrenceInstance.numberOfReserved}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.registrationDate.label" default="Registreringsdato:" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireOccurrence.tire.label" default="Dekktype:" /></td>
                            
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
