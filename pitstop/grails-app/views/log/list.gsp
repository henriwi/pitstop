<%@ page import="no.pstop.webapp.Log" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="log.list.label" /></title>
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
					<g:link controller = "log" class="list" action="list"><g:message code="log.list.label"/></g:link>
				</span>
			</g:if>
			<g:else>
				<span class="menuButton">
					<g:link controller = "log" class="list" action="list"><g:message code="log.list.label"/></g:link>
				</span>
			</g:else>
        </div>
        <div class="body">
            <h1><g:message code="log.list.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <th><a class="notSortableColoumn">${message(code: 'user.username.table.label')}</a></th>
                        
                            <g:sortableColumn property="date" title="${message(code: 'log.date.table.label')}" />
                        
                            <g:sortableColumn property="event" title="${message(code: 'log.event.table.label')}" />
                            
                            <th><a class="notSortableColoumn">${message(code: 'user.list.delete.label')}</a></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${logInstanceList}" status="i" var="logInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${logInstance.id}">${logInstance?.user?.username}</g:link></td>
                        
                            <td><g:link action="show" id="${logInstance.id}"><g:formatDate format="dd.MM.yyyy HH:mm:ss" date="${logInstance?.date}" /></g:link></td>
                        
                            <td><g:link action="show" id="${logInstance.id}">${logInstance?.event}</g:link></td>
                            
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
            <div class="paginateButtons">
                <g:paginate total="${logInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
