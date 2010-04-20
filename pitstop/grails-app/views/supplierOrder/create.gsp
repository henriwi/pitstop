
<%@ page import="no.pstop.webapp.SupplierOrder" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supplierOrder.label', default: 'SupplierOrder')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
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
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${supplierOrderInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${supplierOrderInstance}" as="list" />
	            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <g:form action="showTireOccurrences" method="get">
	                    <table>
	                        <tbody>
	                        	<tr class="prop">
	                                
	                            </tr>
	                        	
								<tr class="prop">
		                                <td valign="top" class="name">
		                                    <label for="tire"><g:message code="supplierOrderLine.tire.label" default="Dekk" /></label>
		                                </td>
		                                <td valign="top" class="value ${hasErrors(bean: supplierOrderLineInstance, field: 'tire', 'errors')}">
											<g:select noSelection="${[0:'Velg dekk']}" name="tireId" from="${tireList}" optionKey="id" value="${params?.tireId}" />
											<span class="button"><g:submitButton name="showTireOccurrences" class="next" value="${message(code: 'default.label', default: 'Vis')}" /></span>
										</td>
		                            </tr>
	                        </tbody>
	                    </table>
                    </g:form>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
