<head>
	<meta name="layout" content="main" />
	<title>${message(code: 'role.create.label')}</title>
</head>
<body>
	<div class="nav">
		<span class="menuButton"><g:link class="list" action="list">${message(code: 'role.list.label')}</g:link></span>
		<span class="menuButton"><g:link class="create" action="create">${message(code: 'role.newRole.label')}</g:link></span>
	</div>
	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<h1>${message(code: 'role.create.label')}</h1>
		<g:hasErrors bean="${authority}">
			<div class="errors">
				<g:renderErrors bean="${authority}" as="list" />
			</div>
		</g:hasErrors>

		<g:form action="save">
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="authority">${message(code: 'role.roleName.label')}</label></td>
							<td valign="top" class="value ${hasErrors(bean:authority,field:'authority','errors')}">
								<input type="text" id="authority" name="authority" value="${authority?.authority?.encodeAsHTML()}"/>
							</td>
						</tr>
			
						<tr class="prop">
							<td valign="top" class="name"><label for="description">${message(code: 'role.description.label')}</label></td>
							<td valign="top" class="value ${hasErrors(bean:authority,field:'description','errors')}">
								<input type="text" id="description" name="description" value="${authority?.description?.encodeAsHTML()}"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="buttons">
				<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label')}" /></span>
	            <span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'default.button.cancel.label')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');" /></span>
			</div>
		</g:form>
	</div>
</body>
