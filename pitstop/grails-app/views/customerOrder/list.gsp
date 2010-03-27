
<%@ page import="no.pstop.webapp.CustomerOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerOrder.label', default: 'CustomerOrder')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
        	<g:if test="${params.action == 'list'}">
        		<span class="menuButton" id="active" >
        			<g:link class="list" action="list"><g:message code="customer.listCustomerOrder.list.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="list" action="list"><g:message code="customer.listCustomerOrder.list.label" /></g:link>
        		</span>
	        </g:else>
	        
	        <g:if test="${params.action == 'create'}">
        		<span class="menuButton" id="active" >
        			<g:link class="create" action="create"><g:message code="customer.addOrder.new.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="create" action="create"><g:message code="customer.addOrder.new.label" /></g:link>
        		</span>
	        </g:else>
        </div>
        <div class="body">
            <h1><g:message code="customerOrder.list.header.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'customerOrder.list.table.orderNumber.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'customerOrder.list.table.orderDate.label', default: 'Order Date')}" />
                        
                            <th><g:message code="customerOrder.list.table.customer.label" default="Customer" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerOrderInstanceList}" status="i" var="customerOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerOrderInstance.id}">${fieldValue(bean: customerOrderInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate format="dd.MM.yyyy hh:mm" date="${customerOrderInstance.orderDate}" /></td>
                        
                            <td>${fieldValue(bean: customerOrderInstance, field: "customer")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
