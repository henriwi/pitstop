<head>
	<meta name="layout" content="main" />
	<title><g:message code="user.list.label" /></title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><g:link controller = "user" class="list" action="list"><g:message code="user.list.label"/></g:link></span>
		<span class="menuButton"><g:link controller = "user" class="create" action="create"><g:message code="user.create.label"/></g:link></span>
	</div>

	<div class="body">
		<h1><g:message code="user.list.label" /></h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<div class="list">
			<table>
			<thead>
				<tr>
					<g:sortableColumn property="username" title="${message(code: 'user.username.table.label')}" />
					<g:sortableColumn property="userRealName" title="${message(code: 'user.userRealName.table.label')}"/>
					<g:sortableColumn property="enabled" title="${message(code: 'user.enabled.table.label')}" />
					<g:sortableColumn property="description" title="${message(code: 'user.description.table.label')}" />
                    <th><a class="notSortableColoumn">${message(code: 'tire.list.edit.label')}</a></th>
	                <th><a class="notSortableColoumn">${message(code: 'tire.list.delete.label')}</a></th>
				</tr>
			</thead>
			<tbody>
			
			
			
			<g:each in="${personList}" status="i" var="person">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
					<td><g:link action="show" id="${person.id}">${fieldValue(bean: person, field: "username")}</g:link> </td>
					<td><g:link action="show" id="${person.id}">${fieldValue(bean: person, field: "userRealName")}</g:link> </td>
					<td><g:link action="show" id="${person.id}">${person?.enabledLabel()}</g:link> </td>
					<td><g:link action="show" id="${person.id}">${fieldValue(bean: person, field: "description")}</g:link> </td>
					<td><g:link class="editTableItem" action="edit" id="${person?.id}">&nbsp;</g:link></td>
                    <td>
                    	<g:form method="post">
                        	<g:hiddenField name="id" value="${person?.id}" />
                           	<g:actionSubmit class="deleteTableItem" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');" />
                        </g:form>
                   	</td>   
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
