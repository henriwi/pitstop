
<%@ page import="no.pstop.webapp.CustomerOrderLine" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrderLine.label', default: 'CustomerOrderLine')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="customerOrderLine.list.label" args="[entityName]" /></g:link></span>
            <!--  <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span> -->
        </div>
        <div class="body">
            <h1><g:message code="customerOrderLine.show.header.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customerOrderLine.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: customerOrderLineInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customerOrderLine.numberOfOrderedTireOccurrences.label" default="Number Of Ordered Tire Occurrences" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: customerOrderLineInstance, field: "numberOfReservedTires")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customerOrderLine.price.label" default="Price" /></td>
                            
                            
                            
                            <td valign="top" class="value"><g:formatNumber number="${customerOrderLineInstance.price}" format="#.00 kr" /></td>	<!--  ${fieldValue(bean: customerOrderLineInstance, field: "price")}</td>-->
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customerOrderLine.tireOccurrence.label" default="Tire Occurrence" /></td>
                            
                            <td valign="top" class="value"><g:link controller="tireOccurrence" action="show" id="${customerOrderLineInstance?.tire?.id}">${customerOrderLineInstance?.tire?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customerOrderLine.customerOrder.label" default="Customer Order" /></td>
                            
                            <td valign="top" class="value"><g:link controller="customerOrder" action="show" id="${customerOrderLineInstance?.customerOrder?.id}">${customerOrderLineInstance?.customerOrder?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${customerOrderLineInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
