
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>

<%@page import="no.pstop.webapp.TireHotelOccurrence"%><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.list.title.label" /></title>
    </head>
    <body>
        <div class="nav">
			<span class="menuButton"><g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="tireHotelOccurrence.list.header.label"/></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:form action="search" method="get">
			<div id="fastSearchInListView">
				<g:textField tabindex='1' name="search" /></td>
				<g:submitButton tabindex='2' class="searchButtons" name="btnSearch" value="${message(code: 'search.button.fastSearch.label')}" />
				<g:link action="list" class="btnShowAll"><g:message code="tireHotelOccurrence.search.showAll.label" /></g:link>							
			</div>
			</g:form>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label')}" />
                        
                            <g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label')}" />
                        
                            <g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label')}" />
                        
                            <g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label')}" />
                        
                            <g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label')}" />
                            
                            <g:sortableColumn property="outDate" title="${message(code: 'tireHotelOccurrence.list.outDate.label')}" />
                            
                            <g:sortableColumn property="customer" title="${message(code: 'tireHotelOccurrence.list.customer.label')}" />
                            
                            <th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.edit.label')}</a></th>
                            
                            <g:ifAllGranted role="ROLE_ADMIN">
                            	<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delete.label')}</a></th>
                            </g:ifAllGranted>
                            
                            <th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delivered.label')}</a></th>
                            
                            <th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.change.label')}</a></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></g:link></td>
                            
                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.outDate}" /></g:link></td>
                            
                            <td><g:link controller="customer" action="show" id="${tireHotelOccurrenceInstance?.customer?.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "customer")}</g:link></td>
                            
                            <td><g:link class="editTableItem" action="edit" id="${tireHotelOccurrenceInstance.id}">&nbsp;</g:link></td>
                            
                            <g:ifAllGranted role="ROLE_ADMIN">
	                            <td>
	                            	<g:form method="post">
	                            		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
	                            		<g:actionSubmit class="deleteTableItem" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');" />
	                            	</g:form>
	                            </td>
	                        </g:ifAllGranted>
                            
                            <td>
                            	<g:form method="post">
                            		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
									<g:hiddenField name="delivered" value="delivered" />
                            		<g:actionSubmit class="delivered" action="update" value="${message(code: 'tireHotelOccurrence.list.delivered.button')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
                            	</g:form>
                            </td>
                            
                            <td>
                            	<g:form method="post">
                            		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
                            		<g:actionSubmit class="change" action="change" value="${message(code: 'tireHotelOccurrence.list.change.button')}" />
                            	</g:form>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tireHotelOccurrenceInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
