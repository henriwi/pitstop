
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="showTire.title.label"/></title>
    </head>
    <body>
        <div class="nav">
	    	<span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>
		    <span class="menuButton"><g:link class="pendingSupplierOrders" action="pendingSupplierOrders"><g:message code="tire.pendingSupplierOrders.title.label" /></g:link></span>
        </div>
        <div class="body">
        	<span class="backButton"><g:link class="back" controller="tire"><g:message code="tire.show.button.back.label" /></g:link></span>
            <h1><g:message code="showTire.title.label" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <!--  <h3 class="customerName"> -->
            
            <div class="tireInfoBoxNew">
						<span class="headerName">
							<h3 class="tireBrandHeader">${fieldValue(bean: tireInstance, field: "brand")} ${fieldValue(bean: tireInstance, field: "tireName")}</h3>
							 - ${fieldValue(bean: tireInstance, field: "partNr")}
						</span>  
						<g:if test="${tireInstance.width}">
							<span class="tireWidth">${fieldValue(bean: tireInstance, field: "width")}/${fieldValue(bean: tireInstance, field: "profile")}
							 ${fieldValue(bean: tireInstance, field: "construction")}${fieldValue(bean: tireInstance, field: "diameter")}
							 ${fieldValue(bean: tireInstance, field: "loadIndex")}${fieldValue(bean: tireInstance, field: "speedIndex")}
							</span>
						</g:if>
						<span class="tireSeason">${fieldValue(bean: tireInstance, field: "tireType")} <g:if test="${tireInstance.pattern}">${fieldValue(bean: tireInstance, field: "pattern")}</g:if>
						</span>
						<span class="tirePrice">
						<g:formatNumber number="${tireInstance?.retailPrice}" format="#.00 kr" />
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
		                    
		                    <g:ifAllGranted role="ROLE_ADMIN">
		                    		<span class="menuButton"><g:actionSubmit class="delete" action="delete" value="${message(code: 'tire.button.delete.label')}" onclick="return confirm('${message(code: 'tire.button.delete.confirm.message')}');" /></span>
		                    	 <span id="createSupplierOrderButton"><g:link controller="supplierOrder" class="create" params="[id:tireInstance?.id]" action="create"><g:message code="tire.button.newCustomerOrder.label" /></g:link></span>
		                    </g:ifAllGranted>
						</g:form>
        	</div>
				</div>
						
						<div class="tireNumberInStockInfoBox">
						
						<span class="tireLabelsInStockAndReserved">
							<span class="tireInStockLabels"><g:message code="tire.numberInStock.label" /></span>
							<span class="tireInStockNumbers">${fieldValue(bean: tireInstance, field: "numberInStock")}</span>
							
							<g:set var="numberOfReserved" value="${0}"></g:set>
		           <g:each in="${customerOrderLines}" status="i" var="customerOrderLineInstance">
		           	<g:set var="numberOfReserved" value="${numberOfReserved + customerOrderLineInstance?.numberOfReservedTires }"></g:set>
		           </g:each>
							<span class="reserved"><span class="tireInStockLabels"><g:message code="tire.numberOfReserved.label" /></span>
							<span class="tireInStockNumbers">${numberOfReserved}</span></span>
						</span>
						
          	<g:set var="numberOfOrdered" value="${0}"></g:set>
           	<g:each in="${supplierOrderLines}" status="i" var="supplierOrderLineInstance">
              	<g:set var="numberOfOrdered" value="${numberOfOrdered + (supplierOrderLineInstance?.numberOfOrderedTires - supplierOrderLineInstance?.numberOfReceivedTires)}"></g:set>
            </g:each>
            <span class="tireLabelsInStockAndReserved"><span class="tireInStockLabels"><g:message code="tire.numberOfOrdered.label" /></span>
						<span class="tireInStockNumbers">${numberOfReserved}</span>
						
						<g:set var="numberOfAvailable" value="${0}"></g:set>
						<span class="available"><span class="tireInStockLabels"><g:message code="tire.numberOfAvailable.label" /></span>
						<span class="tireInStockNumbers">${tireInstance?.numberInStock - numberOfOrdered}</span></span>
						</span>
     
                </div> 
            </div>
        </div>
        <div id="supplierOrderLineList">
				<g:if test="${supplierOrderLines}">
		            <table id="tireOccurrences">
		            	<thead>
		                	<tr>
		                		<g:sortableColumn property="orderNumber" title="${message(code: 'supplierOrder.table.orderNumber.label')}" />
		                		
		                		<g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.table.orderDate.label')}" />
		                	
	                            <g:sortableColumn property="price" title="${message(code: 'supplierOrderLine.table.price.label')}" />
	                            
	                            <g:sortableColumn property="discount" title="${message(code: 'supplierOrderLine.table.discount.label')}" />
	                            
	                            <g:sortableColumn property="environmentalFee" title="${message(code: 'supplierOrderLine.table.environmentalFee.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfRecieved.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.deliver.label')}" />
	                            
	                            <g:sortableColumn property="numberOfReceivedTires" title="${message(code: 'supplierOrderLine.table.deliver.label')}" />
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${supplierOrderLines}" status="i" var="supplierOrderLineInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        	<td><g:link controller="supplierOrder" action="show" id="${supplierOrderLineInstance?.supplierOrder?.id}">${supplierOrderLineInstance?.supplierOrder?.id}</g:link></td>
	                        	
	                        	<td><g:formatDate format="dd.MM.yyyy" date="${supplierOrderLineInstance?.supplierOrder?.orderDate}" /></td>
	                        	
	                            <td>${supplierOrderLineInstance.price}</td>
	                            
	                            <td>${supplierOrderLineInstance?.discount}</td>
	
	                            <td>${supplierOrderLineInstance?.environmentalFee}</td>
	                            
	                            <td>${supplierOrderLineInstance?.numberOfOrderedTires}</td>
	                            
	                            <td>${supplierOrderLineInstance?.numberOfReceivedTires}</td>
	                            
	                            <g:form action="recieveOrder" controller="supplierOrder" method="post">
	                            
	                            	<td><g:textField id="numberOfRecievedTextField" name="numberOfRecieved" value="${supplierOrderLineInstance?.numberOfOrderedTires - supplierOrderLineInstance?.numberOfReceivedTires}"/></td>
	                          		<td>
	                          			<g:hiddenField name="supplierOrderLineId" value="${supplierOrderLineInstance?.id}" />
    	                      			<g:submitButton class="recieveSupplierOrder" name="recieveOrder" title="${message(code: 'supplierOrder.recieve.tooltip.label')}" value="${message(code: 'list.button.table.label')}" />
    	                      		</td>
       	                  		</g:form>
	                        </tr>
	                    </g:each>
	                    </tbody>
					</table>
		        </g:if>
            </div>
    </body>
</html>
