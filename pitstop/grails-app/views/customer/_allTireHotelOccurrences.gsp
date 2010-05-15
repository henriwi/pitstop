<table>
	<thead>
		<tr>
			<util:remoteSortableColumn controller="customer" action="updateAllTireHotelOccurrencesList" property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label')}" update="allTireHotelOccurrences" params="[max: params.max, offset: params.offset]"/>
			                       	
			<util:remoteSortableColumn controller="customer" action="updateAllTireHotelOccurrencesList" property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label')}" update="allTireHotelOccurrences" params="[max: params.max, offset: params.offset]"/>
			
			<util:remoteSortableColumn controller="customer" action="updateAllTireHotelOccurrencesList" property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label')}" update="allTireHotelOccurrences" params="[max: params.max, offset: params.offset]"/>

			<util:remoteSortableColumn controller="customer" action="updateAllTireHotelOccurrencesList" property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label')}" update="allTireHotelOccurrences" params="[max: params.max, offset: params.offset]"/>
			                       	
			<util:remoteSortableColumn controller="customer" action="updateAllTireHotelOccurrencesList" property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label')}" update="allTireHotelOccurrences" params="[max: params.max, offset: params.offset]"/>

			<util:remoteSortableColumn controller="customer" action="updateAllTireHotelOccurrencesList" property="outDate" title="${message(code: 'tireHotelOccurrence.list.outDate.label')}" update="allTireHotelOccurrences" params="[max: params.max, offset: params.offset]"/>

			<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delivered.label')}</a></th>
                     		
           	<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.change.label')}</a></th>
                     		
            <g:ifAllGranted role="ROLE_ADMIN">
            	<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delete.label')}</a></th>
            </g:ifAllGranted>
            
		</tr>
	</thead>
    <tbody>
    	<g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    
            	<td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</td>
                   
                <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</td>
                   
                <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</td>
                   
                <td>${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</td>
                   
                <td><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></td>
                       
                <td><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.outDate}" /></td>
                   		
                <td>
                	<g:if test="${!tireHotelOccurrenceInstance.outDate}">
                    	<g:form controller="tireHotelOccurrence" method="post">
                      		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
                       		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
							<g:hiddenField name="delivered" value="delivered" />
                       		<g:actionSubmit class="delivered" title="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" action="deliverTireHotelOccurenceFromCustomerView" value="${message(code: 'tireHotelOccurrence.list.delivered.button')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
                       	</g:form>
                    </g:if>
               	</td>
                      			
                <td>
                	<g:if test="${!tireHotelOccurrenceInstance.outDate}">
                    	<g:form controller="tireHotelOccurrence" method="post">
                      		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
                      		<g:hiddenField name="requestFromShowCustomerView" value="true" />
                      		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
                      		<g:actionSubmit class="change" action="change" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.change.button')}" />
                    	</g:form>
               		</g:if>
               	</td>
                      			
	            <g:ifAllGranted role="ROLE_ADMIN">
                	<td>
                    	<g:form controller="tireHotelOccurrence" method="post">
                       		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
                      		<g:hiddenField name="requestFromShowCustomerView" value="true" />
                       		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
                       		<g:actionSubmit class="deleteTableItem" title="${message(code: 'tireHotelOccurrence.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'tireHotelOccurrence.button.delete.confirm.message')}');" />
                        </g:form>
                   </td>
               </g:ifAllGranted>
			</tr>
		</g:each>
	</tbody>
</table>
<div class="paginateButtons" id="showCustomer">
	<util:remotePaginate controller="customer"  action="updateAllTireHotelOccurrencesList" total="${tireHotelOccurrenceInstanceTotalList.size()}"
		update="allTireHotelOccurrences" params="[id: customerInstance.id]" pageSizes="[5, 10, 100]"/>
</div>
