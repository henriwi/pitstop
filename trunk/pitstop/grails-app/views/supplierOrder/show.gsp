
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<div class="dialog">
	<div>
		<h4>Ordrenummer: ${supplierOrderInstance?.id}</h4>
		<span><g:formatDate format="dd.MM.yyyy" date="${supplierOrderInstance?.orderDate}" /></span>
		<span class="tireNotice">${supplierOrderInstance?.notice}</span>
	</div>
	
    <table>
	   	<thead>
	       	<tr>
	       		<g:sortableColumn property="orderNumber" title="${message(code: 'supplierOrderLine.table.tire.label')}" />
	       		
	       		<g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.table.orderDate.label')}" />
	       	
	            <g:sortableColumn property="price" title="${message(code: 'supplierOrderLine.table.price.label')}" />
	            
	            <g:sortableColumn property="discount" title="${message(code: 'supplierOrderLine.table.discount.label')}" />
	            
	            <g:sortableColumn property="environmentalFee" title="${message(code: 'supplierOrderLine.table.environmentalFee.label')}" />
	            
	            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}" />
	            
	            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfReceived.label')}" />
	            
	        </tr>
		</thead>
	    <tbody>
	    	<g:each in="${supplierOrderInstance?.supplierOrderLines}" status="i" var="supplierOrderLineInstance">
	        	<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	 
	            	<td>${supplierOrderLineInstance?.tire}</td>
	               	
	               	<td><g:formatDate format="dd.MM.yyyy" date="${supplierOrderLineInstance?.supplierOrder?.orderDate}" /></td>
	               	
	                <td>${supplierOrderLineInstance.price}</td>
	                
	                <td>${supplierOrderLineInstance?.discount}</td>
	
	                <td>${supplierOrderLineInstance?.environmentalFee}</td>
	                   
		           	<td>${supplierOrderLineInstance?.numberOfOrderedTires}</td>
	                   
	                <td>${supplierOrderLineInstance?.numberOfReceivedTires}</td>
	                       
	           </tr>
	        </g:each>
		</tbody>
    </table>
	<div class="buttons">
		
   		<g:form action="receiveOrder">
       		<span class="button"><g:submitToRemote class="receiveSupplierOrder" onComplete="Modalbox.resizeToContent()" controller="supplierOrder" action="receiveOrder" id="${supplierOrderInstance?.id}" value="${message(code: 'supplierOrder.button.receive.label')}" update="MB_content"/></span>
       		<g:link url="#" onClick="Modalbox.hide()"><g:message code="createTire.button.cancel.label" /></g:link>
   		</g:form>
   	</div>
</div>