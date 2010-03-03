
<%@ page import="no.pstop.webapp.TireHotelOccurence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireHotelOccurence.label', default: 'TireHotelOccurence')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tireHotelOccurenceInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireHotelOccurenceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${tireHotelOccurenceInstance?.id}" />
                <g:hiddenField name="version" value="${tireHotelOccurenceInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tireLocation"><g:message code="tireHotelOccurence.tireLocation.label" default="Tire Location" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'tireLocation', 'errors')}">
                                    <g:textField name="tireLocation" value="${tireHotelOccurenceInstance?.tireLocation}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="registrationNumber"><g:message code="tireHotelOccurence.registrationNumber.label" default="Registration Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'registrationNumber', 'errors')}">
                                    <g:textField name="registrationNumber" value="${tireHotelOccurenceInstance?.registrationNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="carType"><g:message code="tireHotelOccurence.carType.label" default="Car Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'carType', 'errors')}">
                                    <g:textField name="carType" value="${tireHotelOccurenceInstance?.carType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tireType"><g:message code="tireHotelOccurence.tireType.label" default="Tire Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'tireType', 'errors')}">
                                    <g:textField name="tireType" value="${tireHotelOccurenceInstance?.tireType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="inDate"><g:message code="tireHotelOccurence.inDate.label" default="In Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'inDate', 'errors')}">
                                    <g:datePicker name="inDate" precision="day" value="${tireHotelOccurenceInstance?.inDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="notice"><g:message code="tireHotelOccurence.notice.label" default="Notice" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'notice', 'errors')}">
                                    <g:textArea name="notice" cols="40" rows="5" value="${tireHotelOccurenceInstance?.notice}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="outDate"><g:message code="tireHotelOccurence.outDate.label" default="Out Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'outDate', 'errors')}">
                                    <g:datePicker name="outDate" precision="day" value="${tireHotelOccurenceInstance?.outDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="customer"><g:message code="tireHotelOccurence.customer.label" default="Customer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurenceInstance, field: 'customer', 'errors')}">
                                    <g:select name="customer.id" from="${no.pstop.webapp.Customer.list()}" optionKey="id" value="${tireHotelOccurenceInstance?.customer?.id}"  />
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
