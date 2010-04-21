
<%@ page import="no.pstop.webapp.SupplierOrderLine" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrderLine.label', default: 'SupplierOrderLine')}" />
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
                            <td valign="top" class="name"><g:message code="supplierOrderLine.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supplierOrderLineInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supplierOrderLine.price.label" default="Price" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supplierOrderLineInstance, field: "price")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supplierOrderLine.discount.label" default="Discount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supplierOrderLineInstance, field: "discount")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supplierOrderLine.environmentalFee.label" default="Environmental Fee" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supplierOrderLineInstance, field: "environmentalFee")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supplierOrderLine.supplierOrder.label" default="Supplier Order" /></td>
                            
                            <td valign="top" class="value"><g:link controller="supplierOrder" action="show" id="${supplierOrderLineInstance?.supplierOrder?.id}">${supplierOrderLineInstance?.supplierOrder?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supplierOrderLine.numberOfOrderedTires.label" default="Number Of Ordered Tires" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supplierOrderLineInstance, field: "numberOfOrderedTires")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supplierOrderLine.tire.label" default="Tire" /></td>
                            
                            <td valign="top" class="value"><g:link controller="tire" action="show" id="${supplierOrderLineInstance?.tire?.id}">${supplierOrderLineInstance?.tire?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supplierOrderLine.receivedDate.label" default="Received Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${supplierOrderLineInstance?.receivedDate}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${supplierOrderLineInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
