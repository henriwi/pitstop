<head>
	<meta name="layout" content="main" />
	<title><g:message code="user.show.header.label" /></title>
</head>

<body>

	<div class="nav">
		<span class="menuButton"><g:link controller = "user" class="list" action="list"><g:message code="user.list.label"/></g:link></span>
		<span class="menuButton"><g:link controller = "user" class="createUser" action="create"><g:message code="user.create.label"/></g:link></span>
	</div>

	<div class="body">
		<span class="backButton"><g:link class="back" controller="user"><g:message code="user.show.button.back.label" /></g:link></span>
		<h1><g:message code="user.show.header.label" args="[entityName]" /></h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<div class="dialog">
			<table>
				<tbody>
	
	                <tr class="prop">
	                    <td valign="top" class="name"><g:message code="user.username.label" /></td>
	                    <td valign="top" class="value">${fieldValue(bean: person, field: "username")}</td>
	                </tr>
	
	                <tr class="prop">
	                    <td valign="top" class="name"><g:message code="user.userRealName.label" /></td>
	                    <td valign="top" class="value">${fieldValue(bean: person, field: "userRealName")}</td>
	                </tr>
	
	                <tr class="prop">
	                    <td valign="top" class="name"><g:message code="user.enabled.label" /></td>
	                    <td valign="top" class="value">${person?.enabledLabel()}</td>
	                </tr>
	
	                <tr class="prop">
	                    <td valign="top" class="name"><g:message code="user.description.label" /></td>
	                    <td valign="top" class="value">${fieldValue(bean: person, field: "description")}</td>
	                </tr>
	
	                <tr class="prop">
	                    <td valign="top" class="name"><g:message code="user.email.label" /></td>
	                    <td valign="top" class="value">${fieldValue(bean: person, field: "email")}</td>
	                </tr>
	
					<tr class="prop">
						<td valign="top" class="name"><g:message code="user.roles.label" /></td>
						<td valign="top" class="value">
							<ul>
								<g:each in="${roleNames}" var='name'>
									<li>${name}</li>
								</g:each>
							</ul>
						</td>
					</tr>
	
				</tbody>
			</table>
		</div>

		<div class="buttons">
			<g:form>
				<input type="hidden" name="id" value="${person.id}" />
                <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
               	<g:ifAllGranted role="ROLE_ADMIN">
               		<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'user.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
               	</g:ifAllGranted>
			</g:form>
		</div>

	</div>
</body>
