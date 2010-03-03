
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurence')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
       		 <span class="menuButton"><g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link></span>
             <span class="menuButton"><g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link></span>        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.tireLocation.label" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.registrationNumber.label" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.carType.label"  /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.tireType.label"  /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.inDate.label"  /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tireHotelOccurrenceInstance?.inDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.notice.label"  /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "notice")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.outDate.label" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tireHotelOccurrenceInstance?.outDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.create.customer.label" /></td>
                            
                            <td valign="top" class="value"><g:link controller="customer" action="show" id="${tireHotelOccurrenceInstance?.customer?.id}">${tireHotelOccurrenceInstance?.customer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
