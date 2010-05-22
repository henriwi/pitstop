
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrder.label', default: 'SupplierOrder')}" />
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
            <g:hasErrors bean="${supplierOrderInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${supplierOrderInstance}" as="list" />
	            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${supplierOrderInstance?.id}" />
                <g:hiddenField name="version" value="${supplierOrderInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="supplierOrderLines"><g:message code="supplierOrder.supplierOrderLines.label" default="Supplier Order Lines" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'supplierOrderLines', 'errors')}">
                                    
									<ul>
										<g:each in="${supplierOrderInstance?.supplierOrderLines?}" var="s">
										    <li><g:link controller="supplierOrderLine" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
										</g:each>
									</ul>
									<g:link controller="supplierOrderLine" action="create" params="['supplierOrder.id': supplierOrderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="orderDate"><g:message code="supplierOrder.orderDate.label" default="Order Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'orderDate', 'errors')}">
                                    <g:datePicker name="orderDate" precision="day" value="${supplierOrderInstance?.orderDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="orderNumber"><g:message code="supplierOrder.orderNumber.label" default="Order Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'orderNumber', 'errors')}">
                                    <g:textField name="orderNumber" value="${supplierOrderInstance?.orderNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="supplier"><g:message code="supplierOrder.supplier.label" default="Supplier" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'supplier', 'errors')}">
                                    <g:textField name="supplier" value="${supplierOrderInstance?.supplier}" />
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
