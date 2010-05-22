<%@ page import="no.pstop.webapp.CustomerOrder" %>
<div class="dialog">
	<div>
		<h4><g:message code="customerOrder.orderNumber.label" args="${[customerOrderInstance?.id]}"></g:message></h4>
		<span>${customerOrderInstance?.customer}</span>
		<span><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance?.orderDate}" /></span>
		<span class="tireNotice">${customerOrderInstance?.notice}</span>
	</div>
	
    <table>
	   	<thead>
	       	<tr>
	       		<th><a class="notSortableColoumn">${message(code: 'customerOrderLine.tire.table.label')}</a></th>
	       		
	            <th><a class="notSortableColoumn">${message(code: 'customerOrderLine.price.table.label')}</a></th>
	            
	            <th><a class="notSortableColoumn">${message(code: 'customerOrderLine.numberOfReservedTires.table.label')}</a></th>
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
    	<g:if test="${!customerOrderInstance?.deliveredDate}">
	   		<g:form action="deliverOrder">
	       		<span class="button"><g:submitToRemote class="receiveSupplierOrder" onComplete="Modalbox.resizeToContent()" controller="customerOrder" action="deliverOrderFromModalbox" id="${customerOrderInstance?.id}" value="${message(code: 'customerOrder.button.deliver.label')}" update="MB_content"/></span>
	       		<g:link url="#" onClick="Modalbox.hide()"><g:message code="createTire.button.cancel.label" /></g:link>
	   		</g:form>
		</g:if>
		<g:else>
			<span class="button"><g:link url="#" onClick="Modalbox.hide()" class="btnShowAll"><g:message code="default.button.close.label" /></g:link></span>
		</g:else>
	</div>
</div>