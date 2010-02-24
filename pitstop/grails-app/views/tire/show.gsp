
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tire.label', default: 'dekk')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label" default="Dekkliste" /></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label" default="Nytt dekk" /></g:link></span>
		    <span class="menuButton"><g:link controller="tireOccurrence" class="create" action="create"><g:message code="default.button.newTireOccurrence.label" default="Ny dekkforekomst"  /></g:link></span>
	    	<span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label" default="Dekkforekomster" /></g:link></span>
	    	<span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label" default="Søk" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog" id="tireShowDialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.partNr.label" default="Varenummer:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "partNr")}</td>
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.brand.label" default="Merke:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "brand")}</td>
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.tireName.label" default="Dekknavn:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "tireName")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.width.label" default="Bredde:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "width")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.profile.label" default="Profil:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "profile")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.construction.label" default="Konstruksjon:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "construction")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.diameter.label" default="Felgdiameter:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "diameter")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.loadIndex.label" default="Indeks:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "loadIndex")}${fieldValue(bean: tireInstance, field: "speedIndex")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.pattern.label" default="M&oslash;nster:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "pattern")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="tire.tireType.label" default="Dekktype:" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: tireInstance, field: "tireType")}</td>
                        </tr>
                    </tbody>
                </table>
	            <div class="buttons" id="tireEditButtons">
	                <g:form>
	                    <g:hiddenField name="id" value="${tireInstance?.id}" />
	                    <span class="menuButton"><g:link controller="tireOccurrence" class="create" action="create"><g:message code="Ny dekkforekomst" args="[entityName]" /></g:link></span>
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Endre')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Slett')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Er du sikker?')}');" /></span>
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
	                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.price.label', default: 'Pris')}" />
	                        
	                            <g:sortableColumn property="numberInStock" title="${message(code: 'tireOccurrence.numberInStock.label', default: 'Antall')}" />
	                        
	                            <g:sortableColumn property="numberOfReserved" title="${message(code: 'tireOccurrence.numberOfReserved.label', default: 'Reservert')}" />
	                        
	                            <g:sortableColumn property="numberOfOrdered" title="${message(code: 'tireOccurrence.numberOfOrdered.label', default: 'Bestilt')}" />
	                        
	                            <g:sortableColumn property="numberOfAvailable" title="${message(code: 'tireOccurrence.numberOfAvailable.label', default: 'Tiljengelighet')}" />
	                        
	                        	<g:sortableColumn property="registrationDate" title="${message(code: 'tireOccurrence.registrationDate.label', default: 'Registreringsdato')}" />
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
