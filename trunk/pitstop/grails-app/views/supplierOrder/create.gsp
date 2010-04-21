
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrder.label', default: 'SupplierOrder')}" />
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
            <g:hasErrors bean="${supplierOrderInstance}">
            <div class="errors">
                <g:renderErrors bean="${supplierOrderInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="addToOrder" method="get" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="orderNumber"><g:message code="supplierOrder.orderNumber.label" default="Order Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'orderNumber', 'errors')}">
                                    <g:textField name="orderNumber" value="${order?.orderNumber}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="supplier"><g:message code="supplierOrder.supplier.label" default="Supplier" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'supplier', 'errors')}">
                                    <g:textField name="supplier" value="${order?.supplier}" />
                                </td>
                            </tr>
                        </tbody>
                       </table>
                       <table>
                        <tbody>
                               <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tire"><g:message code="supplierOrderLine.tire.label" default="Tire" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'tire', 'errors')}">
                                    <g:select name="tireId" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${params.tireId}"  />
                                </td>
                            </tr>
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
                                    <label for="numberOfOrderedTires"><g:message code="supplierOrderLine.numberOfOrderedTires.label" default="numberOfOrderedTires" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'numberOfOrderedTires', 'errors')}">
                                    <g:textField name="numberOfOrderedTires" value="${fieldValue(bean: supplierOrderLineInstance, field: 'numberOfOrderedTires')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    </g:form>
                </div>
                
                <div>
					<table>
                		<thead>
	                		<tr class="prop">
		                		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.tire.table.label')}</a></th>
	
		                		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.price.table.label')}</a></th>
		                		
		                		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.discount.table.label')}</a></th>
		                		
		                		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.environmentalFee.table.label')}</a></th>
		                		
		                		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.numberOfOrderedTires.table.label')}</a></th>
		                	</tr>
		                </thead>
	                	<tbody>
	                	
		                	<g:set var="orderLineIndex" value="${0}"></g:set>
							<g:each in="${orderLines}" status="i" var="orderLineInstance">
								<tr>
	                      			<td>${orderLineInstance?.tire}</td>
	                      			<td>${orderLineInstance?.price}</td>
	                      			<td>${orderLineInstance?.environmentalFee}</td>
	                      			<td>${orderLineInstance?.numberOfOrderedTires}</td>
									<td>
	                          			<g:form action="deleteFromOrder" method="get">
	                          				<g:hiddenField name="orderLineIndex" value="${orderLineIndex}" />
	                          				<g:submitButton class="deleteTableItem" name="deleteFromOrder" value="${message(code: 'customerOrder.button.delete.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
	                          			</g:form>
	                         		</td>  
								</tr>
								<g:set var="orderLineIndex" value="${orderLineIndex + 1}"></g:set>
							</g:each>
                   		</tbody>
            		</table>
                </div>
                
               	<g:form action="save" method="post" >
	               	<div class="buttons">
	                   	<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
	                   	<span class="button"><g:actionSubmit tabindex='13' class="cancel" action="list" value="${message(code: 'createTire.button.cancel.label')}" onclick="return confirm('${message(code: 'createTire.button.cancel.confirm.message')}');" /></span>
	               	</div>
           		</g:form>
        </div>
    </body>
</html>
