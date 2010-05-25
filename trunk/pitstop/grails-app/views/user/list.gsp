<head>
	<meta name="layout" content="main" />
	<title><g:message code="user.list.label" /></title>
</head>
<body>
	<div class="nav">
		<span class="menuButton" ${(params.action == 'list' && params.controller == 'user' || params.action == 'save') ? "id='active'" : ""}  >
			<g:link controller="user" class="userList" action="list"><g:message code="user.list.label"/></g:link>
      	</span>
      	
		<span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""}  >
			<g:link controller="user" class="createUser" action="create"><g:message code="user.create.label"/></g:link>
      	</span>
		
		<span class="menuButton" ${(params.action == 'list' && params.controller == 'log') ? "id='active'" : ""}  >
			<g:link controller="log" class="log" action="list"><g:message code="log.list.label"/></g:link>
      	</span>
	</div>
	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<h1><g:message code="user.list.header.label" /></h1>
		<div class="list">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="username" title="${message(code: 'user.username.table.label')}" />
						
						<g:sortableColumn property="userRealName" title="${message(code: 'user.userRealName.table.label')}"/>
						
						<g:sortableColumn property="enabled" title="${message(code: 'user.enabled.table.label')}" />
						
						<g:sortableColumn property="description" title="${message(code: 'user.description.table.label')}" />
						
						<g:sortableColumn property="description" title="${message(code: 'user.email.table.label')}" />
	                    
	                    <th><a class="notSortableColoumn">${message(code: 'user.list.edit.label')}</a></th>
		                
		                <g:ifAllGranted role="ROLE_ADMIN"> 
	                     	<th><a class="notSortableColoumn">${message(code: 'user.list.disable.label')}</a></th>
		               
		                	<th><a class="notSortableColoumn">${message(code: 'user.list.delete.label')}</a></th>
						</g:ifAllGranted>
					</tr>
				</thead>
				<tbody>
				
					<g:each in="${personList}" status="i" var="person">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td><g:link action="show" id="${person.id}">${fieldValue(bean: person, field: "username")}</g:link> </td>
							
							<td><g:link action="show" id="${person.id}">${fieldValue(bean: person, field: "userRealName")}</g:link> </td>
							
							<td><g:link action="show" id="${person.id}">${person?.enabledLabel()}</g:link> </td>
							
							<td><g:link action="show" id="${person.id}">${fieldValue(bean: person, field: "description")}</g:link> </td>
							
							<td><g:link action="show" id="${person.id}">${fieldValue(bean: person, field: "email")}</g:link> </td>
							
							<td><g:link class="editTableItem" action="edit" title="${message(code: 'user.list.edit.tooltip.label')}"  id="${person?.id}">&nbsp;</g:link></td>
		                    <g:ifAllGranted role="ROLE_ADMIN"> 
		                    
			                    <td>
			                    	<g:form method="post">
			                        	<g:hiddenField name="id" value="${person?.id}" />
			         
			                           	<g:if test="${person.enabled}">
			                           		<g:actionSubmit class="disableTableItem" title="${message(code: 'user.list.disable.tooltip.label')}" action="disableAndEnable" value="${message(code: 'list.button.disableAndEnable.label')}" />
			                       		</g:if>
			                       		<g:else>
			                          		<g:actionSubmit class="enableTableItem" title="${message(code: 'user.list.enable.tooltip.label')}" action="disableAndEnable" value="${message(code: 'list.button.disableAndEnable.label')}" />
			                       		</g:else>
			                        </g:form>
			                   	</td> 
			                    
			                    <td>
			                    	<g:form method="post">
			                        	<g:hiddenField name="id" value="${person?.id}" />
			                           	<g:actionSubmit class="deleteTableItem" title="${message(code: 'user.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'user.button.delete.confirm.message')}');" />
			                        </g:form>
			                   	</td> 
		                   	</g:ifAllGranted>  
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>

		<div class="paginateButtons">
			<g:paginate total="${no.pstop.webapp.User.count()}" />
		</div>
	</div>
</body>
