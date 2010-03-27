<head>
	<meta name="layout" content="main" />
	<title>${message(code: 'role.show.label')}</title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><g:link class="list" action="list">${message(code: 'role.list.label')}</g:link></span>
		<span class="menuButton"><g:link class="create" action="create">${message(code: 'role.newRole.label')}</g:link></span>
	</div>

	<div class="body">
		<span class="backButton"><g:link class="back" controller="role"><g:message code="role.show.button.back.label" /></g:link></span>
		<h1>${message(code: 'role.show.label')}</h1>
		<g:if test="${flash.message}">
		<div class="message">${flash.message}</div>
		</g:if>
		<div class="dialog">
			<table>
			<tbody>

				<tr class="prop">
					<td valign="top" class="name">${message(code: 'role.id.label')}</td>
					<td valign="top" class="value">${authority.id}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">${message(code: 'role.roleName.label')}</td>
					<td valign="top" class="value">${authority.authority}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">${message(code: 'role.description.label')}</td>
					<td valign="top" class="value">${authority.description}</td>
				</tr>

				<tr class="prop">
					<td valign="top" class="name">${message(code: 'role.people.label')}</td>
					<td valign="top" class="value">${authority.people}</td>
				</tr>

			</tbody>
			</table>
		</div>

		<div class="buttons">
			<g:form>
				<input type="hidden" name="id" value="${authority?.id}" />
				<span class="button"><g:actionSubmit class="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
				<span class="button"><g:actionSubmit class="delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" value="${message(code: 'default.button.delete.label', default: 'Delete')}" /></span>
			</g:form>
		</div>

	</div>

</body>
