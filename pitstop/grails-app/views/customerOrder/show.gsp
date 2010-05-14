<%@ page import="no.pstop.webapp.CustomerOrder" %>
<div class="dialog">
	<div>
		<h4>Ordrenummer: ${customerOrderInstance?.id}</h4>
		<span>${customerOrderInstance?.customer}</span>
		<span><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance?.orderDate}" /></span>
		<span class="tireNotice">${customerOrderInstance?.notice}</span>
	</div>
	
    <table>
	   	<thead>
	       	<tr>
	       		<g:sortableColumn property="tire" title="${message(code: 'customerOrderLine.tire.table.label')}" />
	       		
	            <g:sortableColumn property="price" title="${message(code: 'customerOrderLine.price.table.label')}" />
	            
	            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'customerOrderLine.numberOfReservedTires.table.label')}" />
	        </tr>
		</thead>
	    <tbody>
	    	<g:each in="${customerOrderInstance?.customerOrderLines}" status="i" var="customerOrderLineInstance">
	        	<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	 
	            	<td>${customerOrderLineInstance?.tire}</td>
	               	
	                <td>${customerOrderLineInstance.price}</td>
	                
		           	<td>${customerOrderLineInstance?.numberOfReservedTires}</td>
		           	
	           </tr>
	        </g:each>
		</tbody>
    </table>
	<div class="buttons">
		
   		<g:form action="deliverOrder">
       		<span class="button"><g:submitToRemote class="receiveSupplierOrder" onComplete="Modalbox.resizeToContent()" controller="customerOrder" action="deliverOrderFromModalbox" id="${customerOrderInstance?.id}" value="${message(code: 'customerOrder.button.deliver.label')}" update="MB_content"/></span>
       		<g:link url="#" onClick="Modalbox.hide()"><g:message code="createTire.button.cancel.label" /></g:link>
   		</g:form>
   	</div>
</div>