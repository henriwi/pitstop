
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tireHotelOccurrence.label', default: 'TireHotelOccurence')}" />
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
            <g:hasErrors bean="${tireHotelOccurrenceInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireHotelOccurrenceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireLocation"><g:message code="tireHotelOccurrence.tireLocation.label" default="Tire Location" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'tireLocation', 'errors')}">
                                    <g:textField name="tireLocation" value="${tireHotelOccurrenceInstance?.tireLocation}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="registrationNumber"><g:message code="tireHotelOccurrence.registrationNumber.label" default="Registration Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'registrationNumber', 'errors')}">
                                    <g:textField name="registrationNumber" value="${tireHotelOccurrenceInstance?.registrationNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="carType"><g:message code="tireHotelOccurrence.carType.label" default="Car Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'carType', 'errors')}">
                                    <g:textField name="carType" value="${tireHotelOccurrenceInstance?.carType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireType"><g:message code="tireHotelOccurrence.tireType.label" default="Tire Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'tireType', 'errors')}">
                                    <g:textField name="tireType" value="${tireHotelOccurrenceInstance?.tireType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inDate"><g:message code="tireHotelOccurrence.inDate.label" default="In Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'inDate', 'errors')}">
                                    <g:datePicker name="inDate" precision="day" value="${tireHotelOccurrenceInstance?.inDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="notice"><g:message code="tireHotelOccurrence.notice.label" default="Notice" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'notice', 'errors')}">
                                    <g:textArea name="notice" cols="40" rows="5" value="${tireHotelOccurrenceInstance?.notice}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="outDate"><g:message code="tireHotelOccurrence.outDate.label" default="Out Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'outDate', 'errors')}">
                                    <g:datePicker name="outDate" precision="day" value="${tireHotelOccurrenceInstance?.outDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer"><g:message code="tireHotelOccurrence.customer.label" default="Customer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'customer', 'errors')}">
                                    <g:select name="customer.id" from="${no.pstop.webapp.Customer.list()}" optionKey="id" value="${tireHotelOccurrenceInstance?.customer?.id}"  />
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
