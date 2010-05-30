
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrder.label')}" />
        <gui:resources components="autoComplete" />
        <title><g:message code="supplierOrder.create.title.label"/></title>
    </head>
    <body>
    	<div class="nav">
       		<span class="menuButton" id="${params.action == 'pendingSupplierOrders' ? 'active' : ''}" >
       			<g:link class="pendingSupplierOrders" action="pendingSupplierOrders"><g:message code="supplierOrder.pendingSupplierOrders.title.label" /></g:link>
       		</span>
       		<span class="menuButton" ${params.action == 'list' || params.action == 'save' ? "id='active'" : ""} >
            	<g:link class="supplierOrderList" action="list"><g:message code="supplier.listSupplierOrder.list.label" /></g:link>
            </span>
            <span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""} >
            	<g:link class="createSupplierOrder" action="create"><g:message code="supplier.addOrder.new.label" /></g:link>
            </span>        		
     	</div>
        <div class="body">
            <h1><g:message code="supplierOrder.create.title.label" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${order}">
            	<div class="errors">
             	   <g:renderErrors bean="${order}" as="list" />
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
	                                <td valign="top" class="value ${hasErrors(bean: order, field: 'supplier', 'errors')}">
	                                    <g:textField style="width: 150px;" name="supplier" value="${order?.supplier}" />
	                                </td>
	                            </tr>
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="notice"><g:message code="supplierOrder.notice.label" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: order, field: 'notice', 'errors')}">
	                                    <g:textArea style="width: 150px; height: 50px;" value="${order?.notice }" name="notice" rows="5" cols="10"/>
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
			                		
			                		<th class="supplierOrderHeaders"><a id="discount" class="notSortableColoumn">${message(code: 'supplierOrderLine.table.discount.label')}</a></th>
			                		
			                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.environmentalFee.label')}</a></th>
			                		
			                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}</a></th>
			                		
			                		<th class="supplierOrderHeaders"><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.treat.label')}</a></th>
			                	</tr>
		                	</thead>
	                		<tbody>
	                			<g:hasErrors bean="${errorOrderLine}">
				                	<div class="errors">
				                		<g:renderErrors bean="${errorOrderLine}" as="list" field="tire"/>
			       						<g:renderErrors bean="${errorOrderLine}" as="list" field="price"/>
			       						<g:renderErrors bean="${errorOrderLine}" as="list" field="discount"/>
			       						<g:renderErrors bean="${errorOrderLine}" as="list" field="environmentalFee"/>
			       						<g:renderErrors bean="${errorOrderLine}" as="list" field="numberOfOrderedTires"/>
			       					</div>
     							</g:hasErrors>
								<g:each in="${orderLines}" status="i" var="orderLineInstance">
       								 
								<tr>
	                      			<td>${orderLineInstance?.tire}</td>
	                      			<td>${orderLineInstance?.price}</td>
	                      			<td>${orderLineInstance?.discount}</td>
	                      			<td>${orderLineInstance?.environmentalFee}</td>
	                      			<td>${orderLineInstance?.numberOfOrderedTires}</td>
									<td>
		                          		<g:actionSubmit id="${i}" action="deleteFromOrder" class="deleteFromOrderTableItem" value=" ${i}" title="${message(code: 'order.deleteFromOrder.tooltip.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
	                         		</td>  
								</tr>
								</g:each>
								<tr>
									<g:if test="${params.id}">
										<g:hiddenField name="tire_id" value="${no.pstop.webapp.Tire.get(params.id)?.id}" />
										<td>${no.pstop.webapp.Tire.get(params.id)}</td>
									</g:if>
									<g:else>
										<td class="yui-skin-sam ${hasErrors(bean: errorOrderLine, field: 'tire', 'errors')}">
											<gui:autoComplete id="tire" controller="tire" action="tireAutoComplete" resultName="tires" />
										</td>
									</g:else>
									<td valign="top" class="value ${hasErrors(bean: errorOrderLine, field: 'price', 'errors')}">
										<g:textField class="supplierOrderHeaders" name="price" value="${errorOrderLine?.price}" />
									</td>
									<td valign="top" class="value ${hasErrors(bean: errorOrderLine, field: 'discount', 'errors')}">
										<g:textField class="supplierOrderHeaders" name="discount" value="${errorOrderLine?.discount}" />
									</td>
									<td valign="top" class="value ${hasErrors(bean: errorOrderLine, field: 'environmentalFee', 'errors')}">
										<g:textField class="supplierOrderHeaders" name="environmentalFee" value="${errorOrderLine?.environmentalFee}" />
									</td>
									<td valign="top" class="value ${hasErrors(bean: errorOrderLine, field: 'numberOfOrderedTires', 'errors')}">
										<g:textField class="supplierOrderHeaders" name="numberOfOrderedTires" value="${errorOrderLine?.numberOfOrderedTires}" />
									</td>
									<td><span class="button"><g:actionSubmit action="addToOrder" class="addToOrderTableItem" value="${message(code: 'list.button.table.label')}" title="${message(code: 'order.addToOrder.tooltip.label')}" /></span></td>
								</tr>
                   			</tbody>
            			</table>
            		</div>
	               	<div class="buttons">
	                   	<span class="button"><g:submitButton name="create" class="saveSupplierOrder" value="${message(code: 'supplierOrder.button.create.label')}" /></span>
	        	</g:form>
                    <span class="button"><a class="cancel" href="javascript:history.back()" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');">${message(code: 'default.button.cancel.label')}</a></span>
	           		</div>
	    	</div>
        </div>
	</body>
</html>