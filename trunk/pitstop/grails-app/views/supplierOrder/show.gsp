
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<div class="dialog">
	<div>
		<h4><g:message code="supplierOrder.show.header.orderNumber.label" />${supplierOrderInstance?.id}</h4>
		<span><g:formatDate format="dd.MM.yyyy" date="${supplierOrderInstance?.orderDate}" /></span>
		<span class="tireNotice">${supplierOrderInstance?.notice}</span>
	</div>
	
    <table>
	   	<thead>
	       	<tr>
	       		<th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.tire.label')} </a></th>
	       		
	       		<th><a class="notSortableColoumn">${message(code: 'supplierOrder.table.orderDate.label')}</a></th>
	       	
	            <th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.price.label')}</a></th>
	            
	            <th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.discount.label')}</a></th>
	            
	            <th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.environmentalFee.label')}</a></th>
	            
	            <th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}</a></th>
	            
	            <th><a class="notSortableColoumn">${message(code: 'supplierOrderLine.table.numberOfReceived.label')}</a></th>
	            
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
		<g:if test="${!supplierOrderInstance?.delivered()}">
   			<g:form action="receiveOrder">
	       		<span class="button"><g:submitToRemote class="receiveSupplierOrder" onComplete="Modalbox.resizeToContent()" controller="supplierOrder" action="receiveOrder" id="${supplierOrderInstance?.id}" value="${message(code: 'supplierOrder.button.receive.label')}" update="MB_content"/></span>
       			<g:link url="#" onClick="Modalbox.hide()"><g:message code="createTire.button.cancel.label" /></g:link>
   			</g:form>
   		</g:if>
		<g:else>
			<span class="button"><g:link url="#" onClick="Modalbox.hide()" class="btnShowAll"><g:message code="default.button.close.label" /></g:link></span>
		</g:else>
   	</div>
</div>