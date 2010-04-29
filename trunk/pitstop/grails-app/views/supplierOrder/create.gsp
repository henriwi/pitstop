
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrder.label', default: 'SupplierOrder')}" />
        <gui:resources components="autoComplete" />
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
            	<div id="supplierOrderDialog">
	            	<div id="supplierInfoAndNotice">
	            		<g:form action="save" method="post" >
		                    <table>
		                        <tbody>
		                            <tr class="prop">
		                                <td valign="top" class="name">
		                                    <label for="supplier"><g:message code="supplierOrder.supplier.label" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'supplier', 'errors')}">
		                                    <g:textField style="width: 150px;" name="supplier" value="${order?.supplier}" />
		                                </td>
		                            </tr>
		                            <tr class="prop">
		                                <td valign="top" class="name">
		                                    <label for="notice"><g:message code="supplierOrder.notice.label" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: supplierOrderInstance, field: 'notice', 'errors')}">
		                                    <g:textArea style="width: 150px; height: 50px;" value="${order?.notice }"tabindex='13' name="notice" rows="5" cols="10"/>
		                                </td>
		                            </tr>
		                        </tbody>
		                  	</table>
		         	</div>
		         	<div id="supplierOrderLines">
	                  <table>
                		<thead>
	                		<tr class="prop">
		                		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.tire.label')}</a></th>
	
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.price.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.discount.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.environmentalFee.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}</a></th>
		                		
		                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.treat.label')}</a></th>
		                	</tr>
		                </thead>
	                	<tbody>
	                	
							<g:each in="${orderLines}" status="i" var="orderLineInstance">
								<tr>
	                      			<td>${orderLineInstance?.tire}</td>
	                      			<td>${orderLineInstance?.price}</td>
	                      			<td>${orderLineInstance?.discount}</td>
	                      			<td>${orderLineInstance?.environmentalFee}</td>
	                      			<td>${orderLineInstance?.numberOfOrderedTires}</td>
									<td>
		                          		<g:hiddenField name="orderLineIndex" value="${i}" />
		                          		<g:actionSubmit action="deleteFromOrder" class="deleteTableItem" value=" ${i}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
	                         		</td>  
								</tr>
							</g:each>
							<tr>
							<g:if test="${params.id}">
								<g:hiddenField name="tire_id" value="${no.pstop.webapp.Tire.get(params.id)?.id}" />
								<td>${no.pstop.webapp.Tire.get(params.id)}</td>
							</g:if>
							<g:else>
								<td class="yui-skin-sam">
									<gui:autoComplete 
										id="tire" 
										controller="tire"
										action="tireAutoComplete"
										resultName="tires" />
								</td>
							</g:else>
								<td><g:textField class="supplierOrderHeaders" name="price" value="${fieldValue(bean: supplierOrderLineInstance, field: 'price')}" /></td>
								<td><g:textField class="supplierOrderHeaders" name="discount" value="${fieldValue(bean: supplierOrderLineInstance, field: 'discount')}" /></td>
								<td><g:textField class="supplierOrderHeaders" name="environmentalFee" value="${fieldValue(bean: supplierOrderLineInstance, field: 'environmentalFee')}" /></td>
								<td><g:textField class="supplierOrderHeaders" name="numberOfOrderedTires" value="${fieldValue(bean: supplierOrderLineInstance, field: 'numberOfOrderedTires')}" /></td>
								<td><span class="button"><g:actionSubmit action="addToOrder" class="save" value="${message(code: 'supplierOrder.addToOrder.label')}" /></span></td>
							</tr>
                   		</tbody>
            		</table>
            		</div>
	               	<div class="buttons">
	                   	<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'supplierOrder.button.create.label')}" /></span>
	                   	<span class="button"><g:actionSubmit tabindex='13' class="cancel" action="list" value="${message(code: 'createTire.button.cancel.label')}" onclick="return confirm('${message(code: 'createTire.button.cancel.confirm.message')}');" /></span>
	               	</div>
	           		</g:form>
	           	</div>
           </div>
    </body>
</html>