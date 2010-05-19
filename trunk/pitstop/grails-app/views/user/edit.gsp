<head>
	<meta name="layout" content="main" />
	<title><g:message code="user.edit.title.label"/></title>
</head>

<body>
	<div class="nav">
		<g:if test="${params.action == 'list' && params.controller == 'user'}">
			<span class="menuButton" id="active" >
				<g:link controller = "user" class="list" action="list"><g:message code="user.list.label"/></g:link>
			</span>
		</g:if>
		<g:else>
			<span class="menuButton">
				<g:link controller = "user" class="list" action="list"><g:message code="user.list.label"/></g:link>
			</span>
		</g:else>
		
		<g:if test="${params.action == 'create'}">
			<span class="menuButton" id="active" >
				<g:link controller = "user" class="createUser" action="create"><g:message code="user.create.label"/></g:link>
			</span>
		</g:if>
		<g:else>
			<span class="menuButton">
				<g:link controller = "user" class="createUser" action="create"><g:message code="user.create.label"/></g:link>
			</span>
		</g:else>
		
		<g:if test="${params.action == 'list' && params.controller == 'log'}">
			<span class="menuButton" id="active" >
				<g:link controller = "log" class="log" action="list"><g:message code="log.list.label"/></g:link>
			</span>
		</g:if>
		<g:else>
			<span class="menuButton">
				<g:link controller = "log" class="log" action="list"><g:message code="log.list.label"/></g:link>
			</span>
		</g:else>
	</div>

	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<h1><g:message code="user.edit.header.label" /></h1>
		<g:hasErrors bean="${person}">
		<div class="errors">
			<g:renderErrors bean="${person}" as="list" />
		</div>
		</g:hasErrors>

		<g:form>
			<input type="hidden" name="id" value="${person?.id}" />
			<input type="hidden" name="version" value="${person?.version}" />
			<div class="dialog">
				<table>
				<tbody>

	                <tr class="prop">
	                    <td valign="top" class="name">
	                      <label for="username"><g:message code="user.username.label" /></label>
	                    </td>
	                    <td valign="top" class="value ${hasErrors(bean: person, field: 'username', 'errors')}">
	                        <g:textField maxlength="40"  name="username" value="${person?.username}" />
	                    </td>
	                </tr>

                  	<tr class="prop">
                        <td valign="top" class="name">
                          <label for="userRealName"><g:message code="user.userRealName.label" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: person, field: 'userRealName', 'errors')}">
                            <g:textField maxlength="40"  name="userRealName" value="${person?.userRealName}" />
                        </td>
                    </tr>

                 	<tr class="prop">
                        <td valign="top" class="name">
                          <label for="passwd"><g:message code="user.passwd.label" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: person, field: 'passwd', 'errors')}">
                            <g:passwordField name="passwd" value="${person?.passwd}" />
                        </td>
                    </tr>

					<tr class="prop">
						<td valign="top" class="name">
							<label for="enabled"><g:message code="user.enabled.label" /></label>
						</td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'enabled','errors')}">
							<g:checkBox name="enabled" value="${person?.enabled}"/>
						</td>
					</tr>

                  	<tr class="prop">
                        <td valign="top" class="name">
                          <label for="description"><g:message code="user.description.label" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: person, field: 'description', 'errors')}">
                            <g:textField maxlength="40"  name="description" value="${person?.description}" />
                        </td>
                    </tr>

                  	<tr class="prop">
                        <td valign="top" class="name">
                          <label for="email"><g:message code="user.email.label" /></label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: person, field: 'email', 'errors')}">
                            <g:textField maxlength="40"  name="email" value="${person?.email}" />
                        </td>
                    </tr>

					<tr class="prop">
						<td valign="top" class="name">
							<label for="authorities"><g:message code="user.roles.label" /></label>
						</td>
						<td valign="top" class="value ${hasErrors(bean:person,field:'authorities','errors')}">
							<ul>
							<g:each var="entry" in="${roleMap}">
								<li>${entry?.key?.description?.encodeAsHTML()}
									<g:checkBox name="${entry?.key?.authority}" value="${entry?.value}"/>
								</li>
							</g:each>
							</ul>
						</td>
					</tr>

				</tbody>
				</table>
			</div>

			<div class="buttons">
				<span class="button"><g:actionSubmit class="saveUser" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                <span class="button"><g:actionSubmit class="cancel" action="show" value="${message(code: 'default.button.cancel.label')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');" /></span>
                <g:ifAllGranted role="ROLE_ADMIN">
                	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:ifAllGranted>
			</div>

		</g:form>

	</div>
</body>
