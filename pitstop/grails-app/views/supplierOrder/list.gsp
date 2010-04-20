
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrder.label')}" />
        <title><g:message code="supplierOrder.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
        	<g:if test="${params.action == 'list'}">
        		<span class="menuButton" id="active" >
        			<g:link class="list" action="list"><g:message code="supplier.listSupplierOrder.list.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="list" action="list"><g:message code="supplier.listSupplierOrder.list.label" /></g:link>
        		</span>
	        </g:else>
        	
        	<g:if test="${params.action == 'create'}">
        		<span class="menuButton" id="active" >
        			<g:link class="create" action="create"><g:message code="supplier.addOrder.new.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="create" action="create"><g:message code="supplier.addOrder.new.label" /></g:link>
        		</span>
	        </g:else>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'supplierOrder.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="notice" title="${message(code: 'supplierOrder.notice.label', default: 'Notice')}" />
                        
                            <g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.orderDate.label', default: 'Order Date')}" />
                        
                            <g:sortableColumn property="supplier" title="${message(code: 'supplierOrder.supplier.label', default: 'Supplier')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${supplierOrderInstanceList}" status="i" var="supplierOrderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${supplierOrderInstance.id}">${fieldValue(bean: supplierOrderInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: supplierOrderInstance, field: "notice")}</td>
                        
                            <td><g:formatDate date="${supplierOrderInstance.orderDate}" /></td>
                        
                            <td>${fieldValue(bean: supplierOrderInstance, field: "supplier")}</td>
                        
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
