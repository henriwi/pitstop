
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.show.title.label"/></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link></span>
        </div>
        <div class="body">
        	<span class="backButton"><g:link class="back" controller="tireHotelOccurrence"><g:message code="tireHotelOccurrence.show.button.back.label" /></g:link></span>
            <h1><g:message code="tireHotelOccurrence.show.title.label"/></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.tireLocation.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.registrationNumber.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.carType.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.tireType.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.inDate.label" /></td>
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance?.inDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.notice.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurrenceInstance, field: "notice")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.outDate.label" /></td>
                            <td valign="top" class="value"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance?.outDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurrence.customer.label" /></td>
                            <td valign="top" class="value"><g:link controller="customer" action="show" id="${tireHotelOccurrenceInstance?.customer?.id}">${tireHotelOccurrenceInstance?.customer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form method="post">
                    <g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label' )}" /></span>
                    <span class="button"><g:actionSubmit class="change" action="change" value="${message(code: 'default.button.change.label')}" /></span>
                    <g:ifAllGranted role="ROLE_ADMIN">
                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label' )}" onclick="return confirm('${message(code: 'tireHotelOccurrence.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:ifAllGranted>
                </g:form>
            </div>
        </div>
    </body>
</html>
