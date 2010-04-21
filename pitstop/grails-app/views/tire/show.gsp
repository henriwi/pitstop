
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
		    <span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>
        </div>
        <div class="body">
        	<span class="backButton"><g:link class="back" controller="tire"><g:message code="tire.show.button.back.label" /></g:link></span>
            <h1><g:message code="showTire.title.label" /></h1>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="dialog" id="tireShowDialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.partNr.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "partNr")}</td>
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.brand.label"/></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "brand")}</td>
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.tireName.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "tireName")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.width.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "width")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.profile.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "profile")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.construction.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "construction")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.diameter.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "diameter")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.loadIndex.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "loadIndex")}${fieldValue(bean: tireInstance, field: "speedIndex")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.pattern.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "pattern")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.tireType.label" /></td>
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "tireType")}</td>
                        </tr>
                        
                       	<tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.retailPrice.label" /></td>
                             <td valign="top" class="value"><g:formatNumber number="${tireInstance?.retailPrice}" format="#.00 kr" /></td>
                        </tr>
                        
                       <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.numberInStock.label" /></td>
                             <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "numberInStock")}</td>
                        </tr>
                        
                       <tr class="prop">
                                <td valign="top" class="name"><label for="notice"><g:message code="tire.notice.label" /></label></td>
                                <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "notice")}</td>
                            </tr>
                    </tbody>
                </table>
	            <div class="buttons" id="tireEditButtons">
	                <g:form>
	                    <g:hiddenField name="id" value="${tireInstance?.id}" />
	                    <span class="menuButton" id="createTireOccurrenceButton"><g:link controller="tireOccurrence" class="create" params="[id:tireInstance?.id]" action="create"><g:message code="tire.button.newTireOccurrence.label" /></g:link></span>
	                    <span class="button" id="tireEditButton"><g:actionSubmit class="edit" action="edit" value="${message(code: 'tire.button.edit.label')}" /></span>
	                   	<g:ifAllGranted role="ROLE_ADMIN">
	                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'tire.button.delete.label')}" onclick="return confirm('${message(code: 'tire.button.delete.confirm.message')}');" /></span>
	               		</g:ifAllGranted>
	                </g:form>
	            </div>
            </div>
	        <div id="tireOccurrenceList">
	        	<g:set var="numberInStock" value="${0}"></g:set>
	            <g:set var="numberOfReserved" value="${0}"></g:set>
	            <g:set var="numberOfOrdered" value="${0}"></g:set>
	            <g:set var="numberOfAvailable" value="${0}"></g:set>
	            <g:each in="${tireOccurrenceInstanceTotalList}" status="i" var="tireOccurrenceInstance">
		        	<g:set var="numberInStock" value="${numberInStock + tireOccurrenceInstance.numberInStock}"></g:set>
		            <g:set var="numberOfReserved" value="${numberOfReserved + tireOccurrenceInstance.numberOfReserved}"></g:set>
		            <g:set var="numberOfOrdered" value="${numberOfOrdered + tireOccurrenceInstance.numberOfOrdered}"></g:set>
		            <g:set var="numberOfAvailable" value="${numberOfAvailable + (tireOccurrenceInstance.numberInStock-tireOccurrenceInstance.numberOfReserved)}"></g:set>
				</g:each>
				<g:if test="${tireOccurrenceInstanceTotalList}">
		            <div id="totalTireOccurrence">
		            	<table>
		                	<tr>
			                	<th>${message(code: 'tireOccurrence.table.numberInStock.label')}</th>
			                    <th>${message(code: 'tireOccurrence.table.numberOfReserved.label')}</th>
			                    <th>${message(code: 'tireOccurrence.table.numberOfOrdered.label')}</th>
			                    <th>${message(code: 'tireOccurrence.table.numberOfAvailable.label')}</th>
		                    </tr>
			                <tr>
			                	<td><%=numberInStock %></td>
			                	<td><%=numberOfReserved %></td>
			                    <td><%=numberOfOrdered %></td>
			                    <td><%=numberOfAvailable %></td>
		                    </tr>
						</table>
					</div>
		            <table id="tireOccurrences">
		            	<thead>
		                	<tr>
	                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.table.price.label')}" />
	                            
	                            <g:sortableColumn property="discount" title="${message(code: 'tireOccurrence.table.discount.label')}" />
	                            
	                            <g:sortableColumn property="environmentalFee" title="${message(code: 'tireOccurrence.table.environmentalFee.label')}" />
	                            
	                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.table.sum.label')}" />
	                        
	                            <g:sortableColumn property="numberInStock" title="${message(code: 'tireOccurrence.table.numberInStock.label')}" />
	                        
	                            <g:sortableColumn property="numberOfReserved" title="${message(code: 'tireOccurrence.table.numberOfReserved.label')}" />
	                        
	                            <g:sortableColumn property="numberOfOrdered" title="${message(code: 'tireOccurrence.table.numberOfOrdered.label')}" />
	                        
	                            <g:sortableColumn property="numberOfAvailable" title="${message(code: 'tireOccurrence.table.numberOfAvailable.label')}" />
	                        
	                        	<g:sortableColumn property="registrationDate" title="${message(code: 'tireOccurrence.table.registrationDate.label')}" />
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${tireOccurrenceInstanceList}" status="i" var="tireOccurrenceInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.price}" format="#.00 kr" /></g:link></td>
	                            
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.discount}" format="#" /> %</g:link></td>
	                            
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.environmentalFee}" format="# kr" /></g:link></td>
	
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.sum()}" format="#.00 kr" /></g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${tireOccurrenceInstance.numberOfAvailable()}</g:link></td>
	                            
	                        	<td><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
	                        </tr>
	                    </g:each>
	                    </tbody>
					</table>
		            <div class="paginateButtons" id="showTire">
		          		<g:paginate next="${message(code: 'default.paginate.next')}" prev="${message(code: 'default.paginate.prev')}" controller="tire" action="show" id="${tireInstance.id}" total="${tireOccurrenceInstanceTotalList.size()}"></g:paginate>
		        	</div>
		        </g:if>
		        <g:else>
		        	<span class="noListElements">
		        		<g:message code="tire.show.foundNoTireOccurrencesOfThisTireTire.message"/>
		        	</span>
		        </g:else>
            </div>
        </div>
    </body>
</html>
