
<%@ page import="no.pstop.webapp.TireHotelOccurence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence')}" />
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
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurenceInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.tireLocation.label" default="Tire Location" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurenceInstance, field: "tireLocation")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.registrationNumber.label" default="Registration Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurenceInstance, field: "registrationNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.carType.label" default="Car Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurenceInstance, field: "carType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.tireType.label" default="Tire Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurenceInstance, field: "tireType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.inDate.label" default="In Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tireHotelOccurenceInstance?.inDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.notice.label" default="Notice" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireHotelOccurenceInstance, field: "notice")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.outDate.label" default="Out Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${tireHotelOccurenceInstance?.outDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tireHotelOccurence.customer.label" default="Customer" /></td>
                            
                            <td valign="top" class="value"><g:link controller="customer" action="show" id="${tireHotelOccurenceInstance?.customer?.id}">${tireHotelOccurenceInstance?.customer?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${tireHotelOccurenceInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
