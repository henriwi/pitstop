<head>
	<meta name="layout" content="main" />
	<title><g:message code="user.create.title.label"/></title>
</head>
<body>
	<div class="nav">
		<span class="menuButton" ${(params.action == 'list' && params.controller == 'user' || params.action == 'save') ? "id='active'" : ""}  >
			<g:link controller="user" class="userList" action="list"><g:message code="user.list.label"/></g:link>
      	</span>
      	
		<span class="menuButton" ${(params.action == 'create' || params.action == 'save') ? "id='active'" : ""}  >
			<g:link controller = "user" class="createUser" action="create"><g:message code="user.create.label"/></g:link>
      	</span>
		
		<span class="menuButton" ${(params.action == 'list' && params.controller == 'log') ? "id='active'" : ""}  >
			<g:link controller = "log" class="log" action="list"><g:message code="log.list.label"/></g:link>
      	</span>
	</div>

	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<h1><g:message code="user.create.header.label" args="[entityName]" /></h1>
		<g:hasErrors bean="${person}">
			<div class="errors">
				<g:renderErrors bean="${person}" as="list" />
			</div>
		</g:hasErrors>
		<g:form action="save">
			<div class="dialog">
				<table>
					<tbody>
	
						<tr class="prop">
							<td valign="top" class="name">
								<label for="username"><g:message code="user.username.label"/></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:person,field:'username','errors')}">
								<input type="text" id="username" name="username" value="${person.username?.encodeAsHTML()}"/>
							</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">
								<label for="passwd"><g:message code="user.passwd.label"/></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:person,field:'passwd','errors')}">
								<input type="password" id="passwd" name="passwd" value="${person.passwd?.encodeAsHTML()}"/>
							</td>
						</tr>
						
						<tr class="prop">
							<td valign="top" class="name">
								<label for="userRealName"><g:message code="user.userRealName.label"/></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:person,field:'userRealName','errors')}">
								<input type="text" id="userRealName" name="userRealName" value="${person.userRealName?.encodeAsHTML()}"/>
							</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">
								<label for="enabled"><g:message code="user.enabled.label"/></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:person,field:'enabled','errors')}">
								<g:checkBox name="enabled" value="${person.enabled}" ></g:checkBox>
							</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">
								<label for="description"><g:message code="user.description.label"/></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:person,field:'description','errors')}">
								<input type="text" id="description" name="description" value="${person.description?.encodeAsHTML()}"/>
							</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name">
								<label for="email"><g:message code="user.email.label"/></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean:person,field:'email','errors')}">
								<input type="text" id="email" name="email" value="${person.email?.encodeAsHTML()}"/>
							</td>
						</tr>
	
						<tr class="prop">
							<td valign="top" class="name" align="left"><g:message code="user.assignRoles.label"/></td>
						</tr>
	
						<g:each in="${authorityList}">
							<tr>
								<td valign="top" class="name" align="left">${it.description.encodeAsHTML()}</td>
								<td align="left"><g:checkBox name="${it.authority}"/></td>
							</tr>
						</g:each>
	
					</tbody>
				</table>
			</div>

			<div class="buttons">
				<span class="button"><g:submitButton name="create" class="saveUser" value="${message(code: 'default.button.create.label')}" /></span>
                <span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'default.button.cancel.label')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');" /></span>
			</div>
		</g:form>
	</div>
</body>
