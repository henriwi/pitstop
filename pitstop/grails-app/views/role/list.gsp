<head>
	<meta name="layout" content="main" />
	<title>${message(code: 'role.list.label')}</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><g:link class="list" action="list">${message(code: 'role.list.label')}</g:link></span>
		<span class="menuButton"><g:link class="create" action="create">${message(code: 'role.newRole.label')}</g:link></span>
	</div>

	<div class="body">
		<h1>${message(code: 'role.list.label')}</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<div class="list">
			<table>
			<thead>
				<tr>
					<g:sortableColumn property="id" title="${message(code: 'role.id.table.label')}" />
					<g:sortableColumn property="authority" title="${message(code: 'role.roleName.table.label')}" />
					<g:sortableColumn property="description" title="${message(code: 'role.description.table.label')}" />
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
			<g:each in="${authorityList}" status="i" var="authority">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
					<td>${authority.id}</td>
					<td>${authority.authority?.encodeAsHTML()}</td>
					<td>${authority.description?.encodeAsHTML()}</td>
					<td class="actionButtons">
						<span class="actionButton">
							<g:link action="show" id="${authority.id}">${message(code: 'role.button.show')}</g:link>
						</span>
					</td>
				</tr>
			</g:each>
			</tbody>
			</table>
		</div>

		<div class="paginateButtons">
			<g:paginate total="${no.pstop.webapp.Role.count()}" />
		</div>
	</div>
</body>
