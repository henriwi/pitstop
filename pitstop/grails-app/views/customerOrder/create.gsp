<%@ page import="no.pstop.webapp.CustomerOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrder.label', default: 'CustomerOrder')}" />
        <gui:resources components="autoComplete" />
        <resource:autoComplete skin="default" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
       		<span class="menuButton" id="${params.action == 'list' ? 'active' : ''}" >
       			<g:link class="list" action="list"><g:message code="customer.listCustomerOrder.list.label" /></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'create' ? 'active' : ''}" >
       			<g:link class="create" action="create"><g:message code="customer.addOrder.new.label" /></g:link>
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
		                                <td valign="top" class="value ${hasErrors(bean: order, field: 'customer', 'errors')}">
		                                    ${order?.customer}
		                                </td>
		                            </tr>
		                  			<tr class="prop">
		                                <td valign="top" class="notice">
		                                    <label for="notice"><g:message code="customerOrderLine.notice.label" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: order, field: 'notice', 'errors')}">
		                                	<g:textArea value="${order?.notice}" tabindex='13' name="notice" rows="5" cols="10"/>
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
	                      			<td>${orderLineInstance?.tire?.retailPrice}</td>
	                      			<td>${orderLineInstance?.tire?.highestPrice()}</td>
	                      			<td>${orderLineInstance?.tire?.averagePrice()}</td>
	                      			<td>${orderLineInstance?.numberOfReservedTires}</td>
	                      			<td><g:formatNumber number="${orderLineInstance?.price}" format="#.00 kr" /></td>
									<td>
	                          			<g:actionSubmit action="deleteFromOrder" class="deleteFromOrderTableItem" value=" ${i}" title="${message(code: 'order.deleteFromOrder.tooltip.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
	                         		</td>  
								</tr>
						</g:each>
						<tr>
							<td class="yui-skin-sam">
								<gui:autoComplete 
									id="tire" 
									controller="tire"
									action="tireAutoComplete"
									resultName="tires"
									value="${errorOrderLine?.tire}"
								/>
							</td>
							<!-- <td>
								<richui:autoComplete name="tires" forceSelection="true" controller="tire" action="tireAutoComplete" 
              						onItemSelect="${remoteFunction(action:'getTireInfoFromSelectedTire',update:'listPrice')}" />
								
							</td>-->
							<script>
							    YAHOO.util.Event.onDOMReady(function() {
							    	//GRAILSUI.tire.itemSelectEvent.subscribe(${remoteFunction(controller: 'tire', action:'getTireInfoFromSelectedTire',update:'listPrice')})
							    	var itemSelectHandler = function(sType, aArgs) {
								    	var tireId = aArgs[2]
								    	new Ajax.Updater('listPrice','/pitstop/tire/getListPriceFromSelectedTire',{asynchronous:true,evalScripts:true,parameters:'tireId='+aArgs[2][1]});
								    	new Ajax.Updater('highestPrice','/pitstop/tire/getHighesttPriceFromSelectedTire',{asynchronous:true,evalScripts:true,parameters:'tireId='+aArgs[2][1]}); 
								    	new Ajax.Updater('averagePrice','/pitstop/tire/getAveragePriceFromSelectedTire',{asynchronous:true,evalScripts:true,parameters:'tireId='+aArgs[2][1]}); 
							    		YAHOO.log(sType); // this is a string representing the event;
							    		
							    					      // e.g., "itemSelectEvent"
							    		var oMyAcInstance = aArgs[0]; // your AutoComplete instance
							    		var elListItem = aArgs[1]; // the <li> element selected in the suggestion
							    		   					       // container
							    		var oData = aArgs[2]; // object literal of data for the result
							    		document.getElementById("listPrice").innerHTML = aArgs;
							    		//alert("odata:<"+oData+"> aArgs:<" + aArgs +">");
							    	};
							    	var test = function(sType,aArgs){
							    		document.getElementById("listPrice").innerHTML = aArgs[2][0];
								    }; 
							    	//GRAILSUI.tire.dataReturnEvent.subscribe(test);
							    	//resultName="tires', 'highest"
							    	//GRAILSUI.tire.responseSchema = {fields: ["name", "highest"]};
							    	
								    GRAILSUI.tire.itemSelectEvent.subscribe(itemSelectHandler);
								    
							    });
							</script>
							<td id="listPrice"></td>
							<td id="highestPrice"></td>
							<td id="averagePrice"></td>
							<td><g:textField class="orderTableTextField" maxlength="30" tabindex='12' name="numberOfReservedTires" value="${errorOrderLine?.numberOfReservedTires}" /></td>
							<td><g:textField class="orderTableTextField" maxlength="30" tabindex='12' name="price" value="${errorOrderLine?.price}" /></td>
							<td><span class="button"><g:actionSubmit action="addToOrder" class="addToOrderTableItem" value="${message(code: 'list.button.table.label')}" title="${message(code: 'order.addToOrder.tooltip.label')}"/></span></td>
	                   	</tbody>
	            		</table>
	            	</div>
                	<div class="buttons">
                    	<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'customerOrder.button.create.label')}" /></span>
                    	<span class="button"><g:actionSubmit tabindex='13' class="cancel" action="list" value="${message(code: 'createTire.button.cancel.label')}" onclick="return confirm('${message(code: 'createTire.button.cancel.confirm.message')}');" /></span>
                	</div>
		        </g:form>
		</div>		            	
    </body>
</html>
