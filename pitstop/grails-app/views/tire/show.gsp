
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
		    <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
		    <span class="menuButton"><g:link controller="tireOccurrence" class="create" action="create"><g:message code="default.button.newTireOccurrence.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>
        </div>
        <div class="body">
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
                    </tbody>
                </table>
	            <div class="buttons" id="tireEditButtons">
	                <g:form>
	                    <g:hiddenField name="id" value="${tireInstance?.id}" />
	                    <span class="menuButton"><g:link controller="tireOccurrence" class="create" params="[id:tireInstance?.id]" action="create"><g:message code="tire.button.newTireOccurrence.label" /></g:link></span>
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'tire.button.edit.label')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'tire.button.delete.label')}" onclick="return confirm('${message(code: 'tire.button.delete.confirm.message')}');" /></span>
	                </g:form>
	            </div>
            </div>
	            <div id="tireOccurrenceList">
	               <g:set var="antInStock" value="${0}"></g:set>
	               <g:set var="antReserved" value="${0}"></g:set>
	               <g:set var="antOrdered" value="${0}"></g:set>
	               <g:set var="antAvailable" value="${0}"></g:set>
	               <g:each in="${tireOccurrenceInstanceTotalList}" status="i" var="tireOccurrenceInstance">
		           	   <g:set var="antInStock" value="${antInStock + tireOccurrenceInstance.numberInStock}"></g:set>
		               <g:set var="antReserved" value="${antReserved + tireOccurrenceInstance.numberOfReserved}"></g:set>
		               <g:set var="antOrdered" value="${antOrdered + tireOccurrenceInstance.numberOfOrdered}"></g:set>
		               <g:set var="antAvailable" value="${antAvailable + (tireOccurrenceInstance.numberInStock-tireOccurrenceInstance.numberOfReserved)}"></g:set>
	               </g:each>
	               <div id="totalTireOccurrence">
	                    <table>
	                   		<tr>
		                    	<th>Antall</th>
		                    	<th>Reservert</th>
		                    	<th>Bestilt</th>
		                    	<th>Tilgjengelighet</th>
	                    	</tr>
		                    <tr>
		                    	<td><%=antInStock %></td>
		                    	<td><%=antReserved %></td>
		                    	<td><%=antOrdered %></td>
		                    	<td><%=antAvailable %></td>
	                    	</tr>
	                    </table>
	               </div>
	                <table>
	                    <thead>
	                        <tr>
	                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.price.label')}" />
	                        
	                            <g:sortableColumn property="numberInStock" title="${message(code: 'tireOccurrence.numberInStock.label')}" />
	                        
	                            <g:sortableColumn property="numberOfReserved" title="${message(code: 'tireOccurrence.numberOfReserved.label')}" />
	                        
	                            <g:sortableColumn property="numberOfOrdered" title="${message(code: 'tireOccurrence.numberOfOrdered.label')}" />
	                        
	                            <g:sortableColumn property="numberOfAvailable" title="${message(code: 'tireOccurrence.numberOfAvailable.label')}" />
	                        
	                        	<g:sortableColumn property="registrationDate" title="${message(code: 'tireOccurrence.registrationDate.label')}" />
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${tireOccurrenceInstanceList}" status="i" var="tireOccurrenceInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "price")}</g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</g:link></td>
	                        
	                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}">${tireOccurrenceInstance.numberInStock-tireOccurrenceInstance.numberOfReserved}</g:link></td>
	                            
	                        	<td><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	             <div class="paginateButtons" id="showTire">
	          		<g:paginate next="Neste" prev="Forrige" controller="tire" action="show" id="${tireInstance.id}" total="${tireOccurrenceInstanceTotalList.size()}"></g:paginate>
	        	</div>
            </div>
        </div>
    </body>
</html>
