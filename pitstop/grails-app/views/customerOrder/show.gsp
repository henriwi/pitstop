<%@ page import="no.pstop.webapp.CustomerOrder" %>
<div class="dialog">
	<g:hasErrors bean="${customerOrderInstance}">
		<div class="errors">
     		<g:renderErrors bean="${customerOrderInstance}" as="list" />
 		</div>
	</g:hasErrors>
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
	       		<span class="button"><a id="cancelModalBox" onclick="Modalbox.hide()"><g:message code="createTire.button.cancel.label" /></a></span>
	       		<span class="button"><g:submitToRemote class="delete" onComplete="Modalbox.resizeToContent()" controller="customerOrder" action="delete" id="${customerOrderInstance?.id}" value="${message(code: 'supplierOrder.button.delete.label')}" update="MB_content"/></span>
	   		</g:form>
		</g:if>
		<g:else>
			<span class="button"><a onclick="Modalbox.hide()" class="btnShowAll"><g:message code="default.button.close.label" /></a></span>
		</g:else>
	</div>
</div>