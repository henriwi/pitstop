
<%@ page import="no.pstop.webapp.SupplierOrderLine" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine')}" />
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
            <g:hasErrors bean="${supplierOrderLineInstance}">
            <div class="errors">
                <g:renderErrors bean="${supplierOrderLineInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="supplierOrderLine.price.label" default="Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: supplierOrderLineInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="discount"><g:message code="supplierOrderLine.discount.label" default="Discount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'discount', 'errors')}">
                                    <g:textField name="discount" value="${fieldValue(bean: supplierOrderLineInstance, field: 'discount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="environmentalFee"><g:message code="supplierOrderLine.environmentalFee.label" default="Environmental Fee" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'environmentalFee', 'errors')}">
                                    <g:textField name="environmentalFee" value="${fieldValue(bean: supplierOrderLineInstance, field: 'environmentalFee')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="supplierOrder"><g:message code="supplierOrderLine.supplierOrder.label" default="Supplier Order" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'supplierOrder', 'errors')}">
                                    <g:select name="supplierOrder.id" from="${no.pstop.webapp.SupplierOrder.list()}" optionKey="id" value="${supplierOrderLineInstance?.supplierOrder?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfOrderedTires"><g:message code="supplierOrderLine.numberOfOrderedTires.label" default="Number Of Ordered Tires" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'numberOfOrderedTires', 'errors')}">
                                    <g:textField name="numberOfOrderedTires" value="${fieldValue(bean: supplierOrderLineInstance, field: 'numberOfOrderedTires')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tire"><g:message code="supplierOrderLine.tire.label" default="Tire" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'tire', 'errors')}">
                                    <g:select name="tire.id" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${supplierOrderLineInstance?.tire?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receivedDate"><g:message code="supplierOrderLine.receivedDate.label" default="Received Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'receivedDate', 'errors')}">
                                    <g:datePicker name="receivedDate" precision="day" value="${supplierOrderLineInstance?.receivedDate}"  />
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
