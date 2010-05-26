<head>
	<meta name="layout" content="main" />
	<title><g:message code="user.show.header.label" /></title>
</head>

<body>
	<div class="nav">
		<span class="menuButton" ${(params.action == 'list' && params.controller == 'user' || params.action == 'save') ? "id='active'" : ""}  >
			<g:link controller="user" class="userList" action="list"><g:message code="user.list.label"/></g:link>
      	</span>
      	
		<span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""}  >
			<g:link controller = "user" class="createUser" action="create"><g:message code="user.create.label"/></g:link>
      	</span>
		
		<span class="menuButton" ${(params.action == 'list' && params.controller == 'log') ? "id='active'" : ""}  >
			<g:link controller = "log" class="log" action="list"><g:message code="log.list.label"/></g:link>
      	</span>
		
		<span class="menuButton" ${(person.id) ? "id='active'" : ""}  >
			<g:link class="showUser" action="show" id="${person.id}">${fieldValue(bean: person, field: "username")} (${fieldValue(bean: person, field: "userRealName")})</g:link>
		</span>
	</div>

	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<h1><g:message code="user.show.header.label" args="[entityName]" /></h1>
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
							<g:each in="${roleNames}" var='role'>
								${role?.description}
							</g:each>
						</td>
					</tr>
	
				</tbody>
			</table>
		</div>

		<div class="buttons">
			<g:form>
				<input type="hidden" name="id" value="${person.id}" />
                <span class="button"><g:actionSubmit class="editUser" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
               	<g:ifAllGranted role="ROLE_ADMIN">
               		<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'user.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
               	</g:ifAllGranted>
			</g:form>
		</div>
		
		<br />
	</div>
	
	<g:if test="${logInstanceList }">
		<div id="userLogTable">
			<g:render template="/user/log"
				model="[logInstanceList: logInstanceList,
				logTotalList: logTotalList,
				userInstance: person]">
			</g:render>
		</div>
	</g:if>
</body>
