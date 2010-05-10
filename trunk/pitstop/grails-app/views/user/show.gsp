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
						<ul>
						<g:each in="${roleNames}" var='role'>
							<li>${role?.description}</li>
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
		
		<div class="loglist">
                <table>
                    <thead>
                        <tr>
                        
                            <th><a class="notSortableColoumn">${message(code: 'user.username.table.label')}</a></th>
                        
                            <th><a class="notSortableColoumn">${message(code: 'log.date.table.label')}</a></th>
                        
                            <th><a class="notSortableColoumn">${message(code: 'log.event.table.label')}</a></th>
                            
                            <th><a class="notSortableColoumn">${message(code: 'user.list.delete.label')}</a></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${logInstanceList}" status="i" var="logInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${logInstance?.user?.username}</td>
                        
                            <td><g:formatDate format="dd.MM.yyyy HH:mm:ss" date="${logInstance?.date}" /></td>
                        
                            <td>${logInstance?.event}</td>
                            
	                    	<td>
		                    	<g:form method="post">
		                        	<g:hiddenField name="id" value="${logInstance?.id}" />
		                           	<g:actionSubmit class="deleteTableItem" title="${message(code: 'log.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'log.button.delete.confirm.message')}');" />
		                        </g:form>
		                   	</td> 
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

	</div>
</body>
