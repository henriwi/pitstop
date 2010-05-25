<div class="list">
	<table>
		<thead>
			<tr>
				<util:remoteSortableColumn controller="customer" action="updateAllCustomerOrdersList" property="id" title="${message(code: 'customerOrder.list.table.orderNumber.label')}" update="allCustomerOrders" params="[max: params.max, offset: params.offset]"/>
			
				<util:remoteSortableColumn controller="customer" action="updateAllCustomerOrdersList" property="orderDate" title="${message(code: 'customerOrder.list.table.orderDate.label')}" update="allCustomerOrders" params="[max: params.max, offset: params.offset]"/>
				                       	
				<util:remoteSortableColumn controller="customer" action="updateAllCustomerOrdersList" property="deliveredDate" title="${message(code: 'customerOrder.list.table.deliveredDate.label')}" update="allCustomerOrders" params="[max: params.max, offset: params.offset]"/>
				
				<util:remoteSortableColumn controller="customer" action="updateAllCustomerOrdersList" property="notice" title="${message(code: 'customerOrder.list.table.notice.label')}" update="allCustomerOrders" params="[max: params.max, offset: params.offset]"/>
	
	            <g:ifAllGranted role="ROLE_ADMIN">
	            	<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delete.label')}</a></th>
	            </g:ifAllGranted>
	            
			</tr>
		</thead>
	    <tbody>
	    	<g:each in="${customerOrders}" status="i" var="customerOrderInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				
					<td><modalbox:createLink controller="customerOrder" action="show" id="${customerOrderInstance?.id}" title="Kundeordre" width="700">${customerOrderInstance?.id}</modalbox:createLink></td>
	                    
	            	<td><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance.orderDate}" /></td>
	                   
	                <td><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance.deliveredDate}" /></td>
	                   
	                <td>${customerOrderInstance?.showNoticeWith50FirstLetters()}</td>
	                   
		            <g:ifAllGranted role="ROLE_ADMIN">
	                	<td>
	                    	<g:form controller="customerOrder" method="post">
	                       		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
	                      		<g:hiddenField name="requestFromShowCustomerView" value="true" />
	                       		<g:hiddenField name="id" value="${customerOrderInstance?.id}" />
	                       		<g:actionSubmit class="deleteTableItem" title="${message(code: 'customerOrder.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
	                        </g:form>
	                   </td>
	               </g:ifAllGranted>
				</tr>
			</g:each>
		</tbody>
	</table>
</div>
<div class="paginateButtons" id="showCustomer">
	<util:remotePaginate controller="customer" action="updateAllCustomerOrdersList" total="${customerOrdersTotalList.size()}"
		update="allCustomerOrders" params="[id: customerInstance.id]" pageSizes="[5, 10, 100]"/>
</div>
