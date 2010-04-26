
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="showTire.title.label"/></title>
    </head>
    <body>
        <div class="nav">
	    	<span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>
        </div>
        <div class="body">
        	<span class="backButton"><g:link class="back" controller="tire"><g:message code="tire.show.button.back.label" /></g:link></span>
            <h1><g:message code="showTire.title.label" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="dialog" id="tireShowDialog">
               	<div class="tireInfoBox">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.partNr.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "partNr")}</td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><label for="toString"><g:message code="tire.info.label" /></label></td>
                            <td valign="top" class="value">${tireInstance?.toString()}</td>
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.pattern.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "pattern")}</td>
                        </tr>
                    

                        
                       	<tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.retailPrice.label" /></td>
                             <td valign="top" class="value"><g:formatNumber number="${tireInstance?.retailPrice}" format="#.00 kr" /></td>
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><label for="notice"><g:message code="tire.notice.label" /></label></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "notice")}</td>
                        </tr>
                     </tbody>
                </table>
                </div>
                
                <div class="dialog" id="tireShowDialogWindow2">
               	<div class="tireInfoBox">
                <table>
                    <tbody>
                       <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.numberInStock.label" /></td>
                             <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "numberInStock")}</td>
                        </tr>
                        
                    <g:set var="numberOfReserved" value="${0}"></g:set>
                        <g:each in="${customerOrderLines}" status="i" var="customerOrderLineInstance">
                        	<g:set var="numberOfReserved" value="${numberOfReserved + customerOrderLineInstance?.numberOfReservedTires }"></g:set>
                        </g:each>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.numberOfReserved.label" /></td>
                             <td valign="top" class="value">${numberOfReserved}</td>
                        </tr>
                        
                        <g:set var="numberOfOrdered" value="${0}"></g:set>
                        <g:each in="${supplierOrderLines}" status="i" var="supplierOrderLineInstance">
                        	<g:set var="numberOfOrdered" value="${numberOfOrdered + (supplierOrderLineInstance?.numberOfOrderedTires - supplierOrderLineInstance?.numberOfReceivedTires)}"></g:set>
                        </g:each>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.numberOfOrdered.label" /></td>
                             <td valign="top" class="value">${numberOfOrdered}</td>
                        </tr>
                            
                     </tbody>
                 </table>
                </div>           

            
	            <div class="buttons" id="tireEditButtons">
	                <g:form>
	                    <g:hiddenField name="id" value="${tireInstance?.id}" />
	                    <!--  <span class="menuButton" id="createTireOccurrenceButton"><g:link controller="tireOccurrence" class="create" params="[id:tireInstance?.id]" action="create"><g:message code="tire.button.newTireOccurrence.label" /></g:link></span> -->
	                    <span class="menuButton" id="createTireOccurrenceButton"><g:link controller="supplierOrder" class="create" params="[id:tireInstance?.id]" action="create"><g:message code="tire.button.newCustomerOrder.label" /></g:link></span>
	                    <span class="button" id="tireEditButton"><g:actionSubmit class="edit" action="edit" value="${message(code: 'tire.button.edit.label')}" /></span>
	                   	<g:ifAllGranted role="ROLE_ADMIN">
	                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'tire.button.delete.label')}" onclick="return confirm('${message(code: 'tire.button.delete.confirm.message')}');" /></span>
	               		</g:ifAllGranted>
	                </g:form>
	            </div>
            </div>
        </div>
        <div id="supplierOrderLineList">
				<g:if test="${supplierOrderLines}">
		            <table id="tireOccurrences">
		            	<thead>
		                	<tr>
		                		<g:sortableColumn property="orderNumber" title="${message(code: 'supplierOrder.table.orderNumber.label')}" />
		                		
		                		<g:sortableColumn property="orderDate" title="${message(code: 'supplierOrder.table.orderDate.label')}" />
		                	
	                            <g:sortableColumn property="price" title="${message(code: 'supplierOrderLine.table.price.label')}" />
	                            
	                            <g:sortableColumn property="discount" title="${message(code: 'supplierOrderLine.table.discount.label')}" />
	                            
	                            <g:sortableColumn property="environmentalFee" title="${message(code: 'supplierOrderLine.table.environmentalFee.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfOrderedTires.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.numberOfRecieved.label')}" />
	                            
	                            <g:sortableColumn property="numberOfOrderedTires" title="${message(code: 'supplierOrderLine.table.deliver.label')}" />
	                            
	                            <g:sortableColumn property="numberOfReceivedTires" title="${message(code: 'supplierOrderLine.table.deliver.label')}" />
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${supplierOrderLines}" status="i" var="supplierOrderLineInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        	<td><g:link controller="supplierOrder" action="show" id="${supplierOrderLineInstance?.supplierOrder?.id}">${supplierOrderLineInstance?.supplierOrder?.orderNumber}</g:link></td>
	                        	
	                        	<td><g:formatDate format="dd.MM.yyyy" date="${supplierOrderLineInstance?.supplierOrder?.orderDate}" /></td>
	                        	
	                            <td>${supplierOrderLineInstance.price}</td>
	                            
	                            <td>${supplierOrderLineInstance?.discount}</td>
	
	                            <td>${supplierOrderLineInstance?.environmentalFee}</td>
	                            
	                            <td>${supplierOrderLineInstance?.numberOfOrderedTires}</td>
	                            
	                            <td>${supplierOrderLineInstance?.numberOfReceivedTires}</td>
	                            
	                            <g:form action="recieveOrder" controller="supplierOrder" method="post">
	                            
	                            	<td><g:textField id="numberOfRecievedTextField" name="numberOfRecieved" value="${supplierOrderLineInstance?.numberOfOrderedTires - supplierOrderLineInstance?.numberOfReceivedTires}"/></td>
	                          		<td>
	                          			<g:hiddenField name="supplierOrderLineId" value="${supplierOrderLineInstance?.id}" />
    	                      			<g:submitButton class="recieveSupplierOrder" name="recieveOrder" title="${message(code: 'supplierOrder.recieve.tooltip.label')}" value="${message(code: 'list.button.table.label')}" />
    	                      		</td>
       	                  		</g:form>
	                        </tr>
	                    </g:each>
	                    </tbody>
					</table>
		        </g:if>
            </div>
    </body>
</html>
