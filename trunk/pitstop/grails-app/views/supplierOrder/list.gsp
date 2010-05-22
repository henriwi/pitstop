
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="supplierOrder.list.title.label" /></title>
    </head>
    <body>
    	<div class="nav">
       		<span class="menuButton" id="${params.action == 'pendingSupplierOrders' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link class="pendingSupplierOrders" action="pendingSupplierOrders"><g:message code="tire.pendingSupplierOrders.title.label" /></g:link>
       		</span>
            <span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""} >
            	<g:link class="create" action="create"><g:message code="supplier.addOrder.new.label" /></g:link>
            </span>       		
    		<span class="menuButton" ${params.action == 'list' || params.action == 'save' ? "id='active'" : ""} >
            	<g:link class="list" action="list"><g:message code="supplier.listSupplierOrder.list.label" /></g:link>
            </span>
     	</div>
        <div class="body">
            <h1><g:message code="supplierOrder.list.title.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'supplierOrder.table.orderNumber.label')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.table.orderDate.label')}" />
                        
                            <g:sortableColumn property="supplier" title="${message(code: 'supplierOrder.table.supplier.label')}" />
                            
                            <g:sortableColumn property="supplier" title="${message(code: 'supplierOrder.table.notice.label')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${supplierOrderInstanceList}" status="i" var="supplierOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
	                       	<td><modalbox:createLink controller="supplierOrder" action="show" id="${supplierOrderInstance?.id}" title="Dekkbestilling" width="700">${supplierOrderInstance?.id}</modalbox:createLink></td>
                        
                            <td><g:formatDate format="dd.MM.yyyy HH:mm" date="${supplierOrderInstance.orderDate}" /></td>
                        
                            <td>${fieldValue(bean: supplierOrderInstance, field: "supplier")}</td>
                            
                            <td>${supplierOrderInstance?.showNoticeWith10FirstLetters()}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${supplierOrderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
