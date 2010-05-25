<h1><g:message code="user.show.title.log.label" /></h1>
<div class="list">
	<table>
    	<thead>
        	<tr>
				<util:remoteSortableColumn controller="user" action="updateLog" property="date" title="${message(code: 'log.date.table.label')}" update="userLogTable" params="[max: params.max, offset: params.offset]"/>                     
                        
				<util:remoteSortableColumn controller="user" action="updateLog" property="event" title="${message(code: 'log.event.table.label')}" update="userLogTable" params="[max: params.max, offset: params.offset]"/>                     
                            
            	<th><a class="notSortableColoumn">${message(code: 'user.list.delete.label')}</a></th>                    
       		</tr>
	   	</thead>
		<tbody>
	    	<g:each in="${logInstanceList}" status="i" var="logInstance">
	        	<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                     
	            	<td><g:formatDate format="dd.MM.yyyy HH:mm:ss" date="${logInstance?.date}" /></td>
	                     
	            	<td>${logInstance?.event}</td>
	                         
	             	<td>
	                   	<g:form controller="log" method="deleteLog" method="post">
	                       	<g:hiddenField name="id" value="${logInstance?.id}" />
                       		<g:hiddenField name="userId" value="${userInstance?.id}" />
                      		<g:hiddenField name="requestFromShowUserView" value="true" />	                       	
			                <g:actionSubmit class="deleteTableItem" title="${message(code: 'log.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'log.button.delete.confirm.message')}');" />
		            	</g:form>
		           	</td> 
	       		</tr>
	   		</g:each>
		</tbody>
	</table>
</div>
<div class="paginateButtons" id="showCustomer">
	<util:remotePaginate controller="user" action="updateLog" total="${logTotalList.size()}"
		update="userLogTable" params="[id: userInstance.id]" pageSizes="[5, 10, 100]"/>
</div>