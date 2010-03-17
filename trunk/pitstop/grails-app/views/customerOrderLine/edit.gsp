
<%@ page import="no.pstop.webapp.CustomerOrderLine" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrderLine.label', default: 'CustomerOrderLine')}" />
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
            <g:hasErrors bean="${customerOrderLineInstance}">
            <div class="errors">
                <g:renderErrors bean="${customerOrderLineInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${customerOrderLineInstance?.id}" />
                <g:hiddenField name="version" value="${customerOrderLineInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="numberOfOrderedTireOccurrences"><g:message code="customerOrderLine.numberOfOrderedTireOccurrences.label" default="Number Of Ordered Tire Occurrences" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'numberOfOrderedTireOccurrences', 'errors')}">
                                    <g:textField name="numberOfOrderedTireOccurrences" value="${fieldValue(bean: customerOrderLineInstance, field: 'numberOfOrderedTireOccurrences')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="price"><g:message code="customerOrderLine.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: customerOrderLineInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="deliveryDate"><g:message code="customerOrderLine.deliveryDate.label" default="Delivery Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'deliveryDate', 'errors')}">
                                    <g:datePicker name="deliveryDate" precision="day" value="${customerOrderLineInstance?.deliveryDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tireOccurrence"><g:message code="customerOrderLine.tireOccurrence.label" default="Tire Occurrence" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'tireOccurrence', 'errors')}">
                                    <g:select name="tireOccurrence.id" from="${no.pstop.webapp.TireOccurrence.list()}" optionKey="id" value="${customerOrderLineInstance?.tireOccurrence?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="customerOrder"><g:message code="customerOrderLine.customerOrder.label" default="Customer Order" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerOrderLineInstance, field: 'customerOrder', 'errors')}">
                                    <g:select name="customerOrder.id" from="${no.pstop.webapp.CustomerOrder.list()}" optionKey="id" value="${customerOrderLineInstance?.customerOrder?.id}"  />
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
