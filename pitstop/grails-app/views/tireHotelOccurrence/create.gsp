
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.create.label"/></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link></span>
<span class="menuButton"><g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="tireHotelOccurrence.create.label" /></h1>
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
                                    <label for="tireLocation"><g:message code="tireHotelOccurrence.create.tireLocation.label"  /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'tireLocation', 'errors')}">
                                    <g:textField name="tireLocation" value="${tireHotelOccurrenceInstance?.tireLocation}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="registrationNumber"><g:message code="tireHotelOccurrence.create.registrationNumber.label"  /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'registrationNumber', 'errors')}">
                                    <g:textField name="registrationNumber" value="${tireHotelOccurrenceInstance?.registrationNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="carType"><g:message code="tireHotelOccurrence.create.carType.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'carType', 'errors')}">
                                    <g:textField name="carType" value="${tireHotelOccurrenceInstance?.carType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireType"><g:message code="tireHotelOccurrence.create.tireType.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'tireType', 'errors')}">
                                    <g:textField name="tireType" value="${tireHotelOccurrenceInstance?.tireType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inDate"><g:message code="tireHotelOccurrence.create.inDate.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'inDate', 'errors')}">
                                    <g:datePicker name="inDate" precision="day" value="${tireHotelOccurrenceInstance?.inDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="notice"><g:message code="tireHotelOccurrence.create.notice.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'notice', 'errors')}">
                                    <g:textArea name="notice" cols="40" rows="5" value="${tireHotelOccurrenceInstance?.notice}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="outDate"><g:message code="tireHotelOccurrence.create.outDate.label"  /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'outDate', 'errors')}">
                                    <g:datePicker name="outDate" precision="day" value="${tireHotelOccurrenceInstance?.outDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customer"><g:message code="tireHotelOccurrence.create.customer.label" /></label>
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
