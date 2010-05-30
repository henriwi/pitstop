
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="supplierOrder.list.title.label" /></title>
    </head>
    <body>
    	<div class="nav">
       		<span class="menuButton" id="${params.action == 'pendingSupplierOrders' ? 'active' : ''}" >
       			<g:link class="pendingSupplierOrders" action="pendingSupplierOrders"><g:message code="supplierOrder.pendingSupplierOrders.title.label" /></g:link>
       		</span>
       		<span class="menuButton" ${params.action == 'list' || params.action == 'save' ? "id='active'" : ""} >
            	<g:link class="supplierOrderList" action="list"><g:message code="supplier.listSupplierOrder.list.label" /></g:link>
            </span>
            <span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""} >
            	<g:link class="createSupplierOrder" action="create"><g:message code="supplier.addOrder.new.label" /></g:link>
            </span>       		
     	</div>
        <div class="body">
            <h1><g:message code="supplierOrder.list.title.label" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${supplierOrderInstanceList}">
	            <div class="list">
	                <table>
	                    <thead>
	                        <tr>
	                        
	                            <g:sortableColumn property="id" title="${message(code: 'supplierOrder.table.orderNumber.label')}" params="[max: params.max, offset: params.offset]" />
	                        
	                            <g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.table.orderDate.label')}" params="[max: params.max, offset: params.offset]" />
	                        
	                            <g:sortableColumn property="supplier" title="${message(code: 'supplierOrder.table.supplier.label')}" params="[max: params.max, offset: params.offset]" />
	                            
	                            <g:sortableColumn property="supplier" title="${message(code: 'supplierOrder.table.notice.label')}" params="[max: params.max, offset: params.offset]" />
	                            
	                            <th><a class="notSortableColoumn"><g:message code="supplierOrder.table.delivered.label" /></a></th>
	                        
	                        </tr>
	                    </thead>
	                    <tbody>
		                    <g:each in="${supplierOrderInstanceList}" status="i" var="supplierOrderInstance">
		                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                        
			                       	<td><modalbox:createLink controller="supplierOrder" action="show" id="${supplierOrderInstance?.id}" title="${message(code: 'pendingSupplierOrder.modalBox.title.label')}" width="800">${supplierOrderInstance?.id}</modalbox:createLink></td>
		                        
		                            <td><g:formatDate format="dd.MM.yyyy HH:mm" date="${supplierOrderInstance.orderDate}" /></td>
		                        
		                            <td>${fieldValue(bean: supplierOrderInstance, field: "supplier")}</td>
		                            
		                            <td>${supplierOrderInstance?.showNoticeWith10FirstLetters()}</td>
		                            
		                            <g:if test="${supplierOrderInstance?.delivered()}">
		                            	<td><g:message code="default.boolean.true" /></td>
		                            </g:if>
		                            <g:else>
		                            	<td><g:message code="default.boolean.false" /></td>
		                            </g:else>
		                            
		                        </tr>
		                    </g:each>
	                    </tbody>
	                </table>
	            </div>
	            <div class="paginateButtons">
	                <g:paginate total="${supplierOrderInstanceTotal}" />
	            </div>
            </g:if>
            <g:else>
				<p class="noSupplierOrders"><g:message code="supplierOrder.pendingSupplierOrders.noOrders.label" /></p>
			</g:else>
        </div>
    </body>
</html>
