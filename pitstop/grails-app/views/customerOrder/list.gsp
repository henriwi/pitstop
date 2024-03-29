
<%@ page import="no.pstop.webapp.CustomerOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'print.css')}" media="print" />
        <g:set var="entityName" value="${message(code: 'customerOrder.label', default: 'CustomerOrder')}" />
        <title><g:message code="customerOrder.list.header.label" /></title>
    </head>
    <body>
        <div class="nav">
       		<span class="menuButton" id="${params.action == 'pendingCustomerOrders' ? 'active' : ''}" >
       			<g:link class="pendingCustomerOrders" action="pendingCustomerOrders"><g:message code="customerOrder.pendingCustomerOrders.title.label" /></g:link>
       		</span>
       		<span class="menuButton" id="${params.action == 'list' ? 'active' : ''}" >
       			<g:link class="customerOrderList" action="list"><g:message code="customerOrder.list.title.label" /></g:link>
       		</span>
       		<span class="menuButton" id="${(params.action == 'create' || params.action == 'save') ? 'active' : ''}" >
       			<g:link class="createCustomerOrder" action="create"><g:message code="customerOrder.create.title.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <h1><g:message code="customerOrder.list.header.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
			<g:if test="${customerOrderInstanceList}">
	            <div class="list">
	                <table>
	                    <thead>
	                        <tr>
	                            <g:sortableColumn property="id" title="${message(code: 'customerOrder.list.table.orderNumber.label')}" params="[max: params.max, offset: params.offset]" />
	                        
	                            <g:sortableColumn property="orderDate" title="${message(code: 'customerOrder.list.table.orderDate.label')}" params="[max: params.max, offset: params.offset]" />
	                            
	                            <g:sortableColumn property="deliveredDate" title="${message(code: 'customerOrder.list.table.deliveredDate.label')}" params="[max: params.max, offset: params.offset]" />
	                            
	                            <th><g:message code="customerOrder.list.table.customer.label" default="Customer" /></th>
								
								<g:sortableColumn property="notice" title="${message(code: 'customerOrder.list.table.notice.label')}" />
	                        </tr>
	                    </thead>
	                    <tbody>
		                    <g:each in="${customerOrderInstanceList}" status="i" var="customerOrderInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                        
									<td><modalbox:createLink controller="customerOrder" action="show" id="${customerOrderInstance?.id}" title="${message(code: 'pendingCustomerOrder.modalBox.title.label')}" width="800">${customerOrderInstance?.id}</modalbox:createLink></td>
		                        
		                            <td><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance.orderDate}" /></td>
		                            
									<td><g:formatDate format="dd.MM.yyyy" date="${customerOrderInstance.deliveredDate}" /></td>
										                        
		                            <td>${fieldValue(bean: customerOrderInstance, field: "customer")}</td>
		                            
		                            <td>${customerOrderInstance?.showNoticeWith50FirstLetters()}</td>
		                        </tr>
		                    </g:each>
	                    </tbody>
	                </table>
	            </div>
	            <div class="paginateButtons">
	                <g:paginate total="${customerOrderInstanceTotal}" />
	            </div>
			</g:if>
			<g:else>
				<p class="noCustomerOrders"><g:message code="customerOrder.allCustomerOrders.noOrders.label" /></p>
			</g:else>
        </div>
    </body>
</html>
