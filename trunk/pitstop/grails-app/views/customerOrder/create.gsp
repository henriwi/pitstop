<%@ page import="no.pstop.webapp.CustomerOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrder.label', default: 'CustomerOrder')}" />
        <gui:resources components="autoComplete" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
       		<span class="menuButton" id="${params.action == 'pendingCustomerOrders' ? 'active' : ''}" >
       			<g:link class="pendingCustomerOrders" action="pendingCustomerOrders"><g:message code="customerOrder.pendingCustomerOrders.title.label" /></g:link>
       		</span>
       		<span class="menuButton" id="${params.action == 'list' ? 'active' : ''}" >
       			<g:link class="customerOrderList" action="list"><g:message code="customerOrder.list.title.label" /></g:link>
       		</span>
       		<span class="menuButton" id="${(params.action == 'create' || params.action == 'save') ? 'active' : ''}" >
       			<g:link class="createCustomerOrder" action="create"><g:message code="customerOrder.create.title.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <h1><g:message code="customerOrder.create.header.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${order}">
	            <div class="errors">
	                <g:renderErrors bean="${order}" as="list" />
	            </div>
            </g:hasErrors>
            <div id="customerOrderDialog">
            	<div id="customerAndNotice">
	                <g:form action="save" method="post" >
	                    <table>
	                        <tbody>
	                        	<tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="customer"><g:message code="customerOrder.customer.label" default="Customer" /></label>
	                                </td>
                                <g:if test="${order?.customer}">
	                                <td valign="top" class="value ${hasErrors(bean: order, field: 'customer', 'errors')}">
	                                    ${order?.customer}
	                                </td>
								</g:if>
								<g:else>
									<td class="yui-skin-sam">
										<div id="customerAutocomplete">
											<gui:autoComplete id="customer" controller="customer" action="customerAutoComplete" resultName="customers"/>
										</div>
									</td>
								</g:else>	                                
	                            </tr>
	                  			<tr class="prop">
	                                <td valign="top" class="notice">
	                                    <label for="notice"><g:message code="customerOrderLine.notice.label" /></label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean: order, field: 'notice', 'errors')}">
	                                	<g:textArea value="${order?.notice}" name="notice" rows="5" cols="10"/>
									</td>
		                    	</tr>
	                        </tbody>
	                    </table>
	                </div>
	                <div id="customerOrderLines">
		            	<table>
	                		<thead>
		                		<tr class="prop">
			                		<th><a class="notSortableColoumn">${message(code: 'customerOrderLine.tire.table.label')}</a></th>
		
			                		<th><a class="notSortableColoumn">${message(code: 'customerOrderLine.retailPrice.table.label')}</a></th>
			                		
			                		<th><a class="notSortableColoumn">${message(code: 'customerOrderLine.highestPrice.table.label')}</a></th>
			                		
			                		<th><a class="notSortableColoumn">${message(code: 'customerOrderLine.averagePrice.table.label')}</a></th>
			                		
			                		<th id="customerOrderDeleteHeader"><a class="notSortableColoumn">${message(code: 'customerOrderLine.numberOfReservedTires.table.label')}</a></th>
			                		
			                		<th><a class="notSortableColoumn">${message(code: 'customerOrderLine.price.table.label')}</a></th>
			                		
			                		<th id="customerOrderDeleteHeader"><a class="notSortableColoumn">${message(code: 'customerOrderLine.treat.table.label')}</a></th>
			                	</tr>
			                </thead>
		            		<g:hasErrors bean="${errorOrderLine}">
		                		<div class="errors">
		                			<g:renderErrors bean="${errorOrderLine}" as="list" field="tire"/>
	       							<g:renderErrors bean="${errorOrderLine}" as="list" field="price"/>
	       							<g:renderErrors bean="${errorOrderLine}" as="list" field="numberOfReservedTires"/>
	       						</div>
	     							</g:hasErrors>			                
	                		<tbody>
							<g:each in="${orderLines}" status="i" var="orderLineInstance">
								<tr>
	                      			<td>${orderLineInstance?.tire}</td>
	                      			<td><g:formatNumber number="${orderLineInstance?.tire?.retailPrice}" format="#.00 kr" /></td>
	                      			<td><g:formatNumber number="${orderLineInstance?.tire?.highestPrice()}" format="#.00 kr" /></td>
	                      			<td><g:formatNumber number="${orderLineInstance?.tire?.averagePrice()}" format="#.00 kr" /></td>
	                      			<td>${orderLineInstance?.numberOfReservedTires}</td>
	                      			<td><g:formatNumber number="${orderLineInstance?.price}" format="#.00 kr" /></td>
									<td>
	                          			<g:actionSubmit action="deleteFromOrder" class="deleteFromOrderTableItem" value=" ${i}" title="${message(code: 'order.deleteFromOrder.tooltip.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
	                         		</td>  
								</tr>
							</g:each>
							<tr>
								<td class="yui-skin-sam">
									<gui:autoComplete id="tire" controller="tire" action="tireAutoComplete" resultName="tires" />
							</td>
							<!-- <td>
								<richui:autoComplete name="tires" forceSelection="true" controller="tire" action="tireAutoComplete" 
	             						onItemSelect="${remoteFunction(action:'getTireInfoFromSelectedTire',update:'listPrice')}" />
								
							</td>-->
							<script>
							    YAHOO.util.Event.onDOMReady(function() {
							    	//GRAILSUI.tire.itemSelectEvent.subscribe(${remoteFunction(controller: 'tire', action:'getTireInfoFromSelectedTire',update:'listPrice')})
							    	var itemSelectHandler = function(sType, aArgs) {
								    	var tireId = aArgs[2][1]
								    	                      
								    	new Ajax.Updater('listPrice',"${createLink(uri: '/tire/getListPriceFromSelectedTire')}",{asynchronous:true,evalScripts:true,parameters:'tireId=' + tireId});
								    	new Ajax.Updater('highestPrice',"${createLink(uri: '/tire/getHighestPriceFromSelectedTire')}",{asynchronous:true,evalScripts:true,parameters:'tireId=' + tireId}); 
								    	new Ajax.Updater('averagePrice',"${createLink(uri: '/tire/getAveragePriceFromSelectedTire')}",{asynchronous:true,evalScripts:true,parameters:'tireId=' + tireId}); 
							    	};
								    GRAILSUI.tire.itemSelectEvent.subscribe(itemSelectHandler);
							    });
							</script>
							<td id="listPrice"></td>
							<td id="highestPrice"></td>
							<td id="averagePrice"></td>
							<td><g:textField class="orderTableTextField" maxlength="30" name="numberOfReservedTires" value="${errorOrderLine?.numberOfReservedTires}" /></td>
							<td><g:textField class="orderTableTextField" maxlength="30" name="price" value="${errorOrderLine?.price}" /></td>
							<td><span class="button"><g:actionSubmit action="addToOrder" class="addToOrderTableItem" id="addToOrderTableItem" value="${message(code: 'list.button.table.label')}" title="${message(code: 'order.addToOrder.tooltip.label')}"/></span></td>
	                  		</tbody>
	           		</table>
	           	</div>
              	<div class="buttons">
                  	<span class="button"><g:submitButton name="create" class="saveCustomerOrder" value="${message(code: 'customerOrder.button.create.label')}" /></span>
                  	<span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'createTire.button.cancel.label')}" onclick="return confirm('${message(code: 'createTire.button.cancel.confirm.message')}');" /></span>
              	</div>
	        </g:form>
		</div>		            	
    </body>
</html>
