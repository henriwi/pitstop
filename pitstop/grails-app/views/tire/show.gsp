<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="showTire.title.label"/></title>
        <g:javascript library="application" />
		<modalbox:modalIncludes />
    </head>
    <body>
        <div class="nav">
	    	<span class="menuButton" id="${params.action == 'list' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="tireList" action="list"><g:message code="default.button.tireList.label"/></g:link>
       		</span>
       		<span class="menuButton" id="${params.action == 'create' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link>
       		</span>
       		<span class="menuButton" id="${params.action == 'search' && params.controller == 'tire' ? 'active' : ''}" >
	    		<g:link controller="tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link>
       		</span>
       		<span class="menuButton" ${(tireInstance.id) ? "id='active'" : ""}  >
       			<g:link class="showTire" action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "brand")} ${fieldValue(bean: tireInstance, field: "tireName")}</g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div id="tireInfo">
            	<h1><g:message code="showTire.title.label" /></h1>
           		<div class="tireInfoBoxNew">
					<span class="headerName">
						<h3 class="tireBrandHeader">${fieldValue(bean: tireInstance, field: "brand")} ${fieldValue(bean: tireInstance, field: "tireName")}</h3>
						 - ${fieldValue(bean: tireInstance, field: "partNr")}
					</span>  
				
					<span class="tireWidth">${fieldValue(bean: tireInstance, field: "width")}/${fieldValue(bean: tireInstance, field: "profile")}
						${fieldValue(bean: tireInstance, field: "construction")}${fieldValue(bean: tireInstance, field: "diameter")}
						${fieldValue(bean: tireInstance, field: "loadIndex")}${fieldValue(bean: tireInstance, field: "speedIndex")}
					</span>
					
					<span class="tireSeason">${fieldValue(bean: tireInstance, field: "tireType")}
						<g:if test="${tireInstance.pattern}">${fieldValue(bean: tireInstance, field: "pattern")}</g:if>
					</span>
					
					<span class="tirePrice">
						<g:formatNumber number="${tireInstance?.retailPrice}" format="kr #.00" />
					</span>
					
					<g:if test="${tireInstance.notice}">
						<span class="tireNotice">
							${fieldValue(bean: tireInstance, field: "notice")}
						</span> 
					</g:if>
					
           			<div class="buttons" id="tireButtons">
	                	<g:form class="showTireButtons">
	                    	<g:hiddenField name="id" value="${tireInstance?.id}" />
	                    	<span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'tire.button.edit.label', default: 'Edit')}" /></span>
	                    	<span class="button" id="createSupplierOrderButton"><g:link controller="supplierOrder" class="create" params="[id:tireInstance?.id]" action="create"><g:message code="tire.button.newCustomerOrder.label" /></g:link></span>
						</g:form>
						
						<g:ifAllGranted role="ROLE_ADMIN"> 
	                    	<g:form method="post">
		                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'tire.button.delete.label')}" onclick="return confirm('${message(code: 'tire.button.delete.confirm.message')}');" /></span>
	                        	<g:hiddenField name="id" value="${tireInstance?.id}" />
	         			
                           	 	<g:if test="${tireInstance?.enabled}">
	                           		<g:actionSubmit id="disableTireItemFromCustomerView" title="${message(code: 'tire.list.disable.tooltip.label')}" action="disableAndEnableForShow" value="${message(code: 'tire.disabled.button.show.label')}" />
	                       		</g:if>
	                       		<g:else>
	                          		<g:actionSubmit id="enableTireItemFromCustomerView" title="${message(code: 'tire.list.enable.tooltip.label')}" action="disableAndEnableForShow" value="${message(code: 'tire.enabled.button.show.label')}" />
	                       		</g:else>
	                        </g:form>
                       	</g:ifAllGranted>	
					</div>	
				</div>
					
				<div class="tireNumberInStockInfoBox">
					<span class="tireLabelsInStockAndReserved">
						<span class="tireInStockLabels"><g:message code="tire.numberInStock.label" /></span>
						<span id="showNumberInStock">
							<span id="numberInStockLabel" class="tireInStockNumbers">${fieldValue(bean: tireInstance, field: "numberInStock")}</span>
							<a href="javascript:showAndHideElement('editNumberInStock', 'showNumberInStock');">
								<g:message code="tire.numberInStock.edit.label"></g:message>
							</a>
						</span>
						<span id="editNumberInStock" style="display: none;">
							<g:formRemote name="updateNumberInStockForm" url="${[action: 'saveNumberInStock']}" onSuccess="showAndHideElement('showNumberInStock', 'editNumberInStock');">
	                          	<g:hiddenField name="id" value="${tireInstance?.id}" />
								<g:textField id="numberInStockText" style="width: 50px;" name="numberInStock" value="${tireInstance?.numberInStock}" />
								<g:actionSubmit action="saveNumberInStock" class="receiveSupplierOrder" title="${message(code: 'supplierOrderLine.receive.tooltip.label')}" value="${message(code: 'list.button.delete.label')}" />
							</g:formRemote>
						</span>
					</span>
						
					<g:set var="numberOfReserved" value="${0}"></g:set>
           			<g:each in="${customerOrders}" status="i" var="customerOrderInstance">
           				<g:each in="${customerOrderInstance?.customerOrderLines}" status="j" var="customerOrderLineInstance">
	           				<g:set var="numberOfReserved" value="${numberOfReserved + customerOrderLineInstance?.numberOfReservedTires }"></g:set>
	           			</g:each>
	           		</g:each>
	           		<span class="reserved"><span class="tireInStockLabels"><g:message code="tire.numberOfReserved.label" /></span>
	           			<span class="tireInStockNumbers">${numberOfReserved}</span>
					</span>
					
         			<g:set var="numberOfOrdered" value="${0}"></g:set>
          			<g:each in="${supplierOrderLines}" status="i" var="supplierOrderLineInstance">
             			<g:set var="numberOfOrdered" value="${numberOfOrdered + (supplierOrderLineInstance?.numberOfOrderedTires - supplierOrderLineInstance?.numberOfReceivedTires)}"></g:set>
           			</g:each>
           			
           			<span class="tireLabelsInStockAndReserved"><span class="tireInStockLabels"><g:message code="tire.numberOfOrdered.label" /></span>
						<span class="tireInStockNumbers">${numberOfOrdered}</span>
					
						<g:set var="numberOfAvailable" value="${0}"></g:set>
						<span class="available"><span class="tireInStockLabels"><g:message code="tire.numberOfAvailable.label" /></span>
						<span class="tireInStockNumbers">${tireInstance?.numberOfAvailable()}</span></span>
					</span>
               	</div>
            </div> 
            	
           	<div id="supplierOrderLineList">
				<g:if test="${supplierOrderLines}">
	            	<h1><g:message code="tire.show.title.orders.label" /></h1>
		            <table id="tireOccurrences">
		            	<thead>
		                	<tr>
		                		<g:sortableColumn property="orderNumber" title="${message(code: 'supplierOrder.table.orderNumber.label')}" />
		                		
		                		<g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.table.orderDate.label')}" />
		                	
	                            <g:sortableColumn property="price" title="${message(code: 'supplierOrderLine.table.price.label')}" />
	                            
	                            <g:sortableColumn property="discount" title="${message(code: 'supplierOrderLine.table.discount.label')}" />
	                            
	                            <g:sortableColumn property="environmentalFee" title="${message(code: 'supplierOrderLine.table.environmentalFee.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfReceived.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.deliver.label')}" />
	                        </tr>
	                    </thead>
	                    <tbody>
		                    <g:each in="${supplierOrderLines}" status="i" var="supplierOrderLineInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                        	<td><modalbox:createLink controller="supplierOrder" action="show" id="${supplierOrderLineInstance?.supplierOrder?.id}" title="Dekkbestilling" width="900" overlayDuration="0" slideDownDuration="0" resizeDuration="0">${supplierOrderLineInstance?.supplierOrder?.id}</modalbox:createLink></td>
            						<!-- <td><a href='/ROOT/supplierOrder/show/${supplierOrderLineInstance?.supplierOrder?.id}' title='Dekkbestilling' onclick='Modalbox.show(this.href, {title: this.title, width: 900, overlayOpacity: 0.5, closeString: "Lukk vinduet", overlayClose: false, overlayDuration: 0, slideDownDuration: 0.5}); return false;'>${supplierOrderLineInstance?.supplierOrder?.id}</a></td>-->
            
		                        	<!-- <td><g:link controller="supplierOrder" action="show" id="${supplierOrderLineInstance?.supplierOrder?.id}">${supplierOrderLineInstance?.supplierOrder?.id}</g:link></td>-->
		                        	
		                        	<td><g:formatDate format="dd.MM.yyyy" date="${supplierOrderLineInstance?.supplierOrder?.orderDate}" /></td>
		                        	
		                            <td>${supplierOrderLineInstance.price}</td>
		                            
		                            <td>${supplierOrderLineInstance?.discount}</td>
		
		                            <td>${supplierOrderLineInstance?.environmentalFee}</td>
		                            
		                            <td>${supplierOrderLineInstance?.numberOfOrderedTires}</td>
		                            
		                            <td>${supplierOrderLineInstance?.numberOfReceivedTires}</td>
		                            
									<g:form action="receiveOrderLine" controller="supplierOrder" method="post">
		                            
			                            <td>
			                            	<g:textField id="numberOfReceivedTextField" name="numberOfReceived" value="${supplierOrderLineInstance?.numberOfOrderedTires - supplierOrderLineInstance?.numberOfReceivedTires}"/>
			                          		<g:hiddenField name="supplierOrderLineId" value="${supplierOrderLineInstance?.id}" />
			                          		<g:actionSubmit class="receiveSupplierOrder" title="${message(code: 'supplierOrderLine.receive.tooltip.label')}" action="receiveOrderLine" value="${message(code: 'list.button.delete.label')}" />
		    	                    	</td>
		       	                	</g:form>
		                		</tr>
		            		</g:each>
	            		</tbody>
					</table>
				</g:if>
			</div>
		</div>
    </body>
</html>
