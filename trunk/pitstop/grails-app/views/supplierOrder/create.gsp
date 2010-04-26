
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
            	<div id="orderNumberAndSupplierInfo">
            		<g:form action="save" method="post" >
	                    <table>
	                        <tbody>
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="orderNumber"><g:message code="supplierOrder.orderNumber.label" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'orderNumber', 'errors')}">
	                                    <g:textField name="orderNumber" value="${order?.orderNumber}" />
	                                </td>
	                            </tr>
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="supplier"><g:message code="supplierOrder.supplier.label" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'supplier', 'errors')}">
	                                    <g:textField name="supplier" value="${order?.supplier}" />
	                                </td>
	                            </tr>
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="notice"><g:message code="supplierOrder.notice.label" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'notice', 'errors')}">
	                                    <g:textArea value="${order?.notice }"tabindex='13' name="notice" rows="5" cols="10"/>
	                                </td>
	                            </tr>
	                        </tbody>
	                       </table>
		               	<div class="buttons">
		                   	<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'supplierOrder.button.create.label')}" /></span>
		                   	<span class="button"><g:actionSubmit tabindex='13' class="cancel" action="list" value="${message(code: 'createTire.button.cancel.label')}" onclick="return confirm('${message(code: 'createTire.button.cancel.confirm.message')}');" /></span>
		               	</div>
	           		</g:form>
	           	</div>
	           	<div id="supplierOrderLines">
                	<g:form action="addToOrder" method="post" >
                       <table>
                        <tbody>
                               <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tire"><g:message code="supplierOrderLine.tire.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'tire', 'errors')}">
                                    <g:select name="tireId" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${params.tireId}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="supplierOrderLine.price.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: supplierOrderLineInstance, field: 'price')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="discount"><g:message code="supplierOrderLine.discount.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'discount', 'errors')}">
                                    <g:textField name="discount" value="${fieldValue(bean: supplierOrderLineInstance, field: 'discount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="environmentalFee"><g:message code="supplierOrderLine.environmentalFee.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'environmentalFee', 'errors')}">
                                    <g:textField name="environmentalFee" value="${fieldValue(bean: supplierOrderLineInstance, field: 'environmentalFee')}" />
                                </td>
                            </tr>
                            
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberOfOrderedTires"><g:message code="supplierOrderLine.numberOfOrderedTires.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'numberOfOrderedTires', 'errors')}">
                                    <g:textField name="numberOfOrderedTires" value="${fieldValue(bean: supplierOrderLineInstance, field: 'numberOfOrderedTires')}" />
                                </td>
                            </tr>
                        <tr><td><span class="button"><g:submitButton name="create" class="save" value="${message(code: 'supplierOrder.addToOrder.label')}" /></span></td></tr>
                        </tbody>
                    </table>
              	</g:form>
                <div id="supplierOrderedItems">
					<table>
                		<thead>
	                		<tr class="prop">
		                		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.tire.label')}</a></th>
	
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.price.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.discount.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.environmentalFee.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.delete.label')}</a></th>
		                	</tr>
		                </thead>
	                	<tbody>
	                	
		                	<g:set var="orderLineIndex" value="${0}"></g:set>
							<g:each in="${orderLines}" status="i" var="orderLineInstance">
								<tr>
	                      			<td>${orderLineInstance?.tire}</td>
	                      			<td>${orderLineInstance?.price}</td>
	                      			<td>${orderLineInstance?.discount}</td>
	                      			<td>${orderLineInstance?.environmentalFee}</td>
	                      			<td>${orderLineInstance?.numberOfOrderedTires}</td>
									<td>
	                          			<g:form action="deleteFromOrder" method="get">
	                          				<g:hiddenField name="orderLineIndex" value="${orderLineIndex}" />
	                          				<g:submitButton class="deleteTableItem" name="deleteFromOrder" value="${message(code: 'list.button.table.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
	                          			</g:form>
	                         		</td>  
								</tr>
								<g:set var="orderLineIndex" value="${orderLineIndex + 1}"></g:set>
							</g:each>
                   		</tbody>
            		</table>
           		</div>
           </div>
    </body>
</html>
