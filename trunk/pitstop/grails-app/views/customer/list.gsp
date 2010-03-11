
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.list.title.label" /></title>
    </head>
    <body>
        <div class="nav">
        		<span class="menuButton"><g:link class="list" action="list"><g:message code="customer.list.label" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="customer.list.header.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="search" method="get">
			<div id="fastSearchInListView">
				<table 	>
					<tbody>
						<tr>
							<td width="50"><g:textField tabindex='1' name="search" /></td>
							<td width="10">
								<g:submitButton tabindex='2' class="searchButtons" name="btnSearch"
									value="${message(code: 'search.button.fastSearch.label')}" />
							</td>
							<td>
								<g:link action="list" class="btnShowAll"><g:message code="customer.search.showAll.label" /></g:link>							
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</g:form>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="firstName" title="${message(code: 'customer.firstName.table.label')}" />
                        
                            <g:sortableColumn property="lastName" title="${message(code: 'customer.lastName.table.label')}" />
                        
                            <g:sortableColumn property="phoneNumber" title="${message(code: 'customer.phoneNumber.table.label')}" />
                        
                            <g:sortableColumn property="address" title="${message(code: 'customer.address.table.label')}" />
                        
                            <g:sortableColumn property="postalCode" title="${message(code: 'customer.postalCode.table.label')}" />
                            
                            <g:sortableColumn property="city" title="${message(code: 'customer.city.table.label')}" />
                        
                        	<g:sortableColumn property="email" title="${message(code: 'customer.email.table.label')}" />
                        	
                        	<g:sortableColumn property="company" title="${message(code: 'customer.company.table.label')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerInstanceList}" status="i" var="customerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "firstName")}</g:link></td>
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "lastName")}</g:link></td>
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "phoneNumber")}</g:link></td>
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "address")}</g:link></td>
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "postalCode")}</g:link></td>
                            
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "city")}</g:link></td>
                            
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "email")}</g:link></td>
                            
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "company")}</g:link></td>
                            
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
