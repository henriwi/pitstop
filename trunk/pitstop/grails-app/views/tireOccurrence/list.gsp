
<%@ page import="no.pstop.webapp.TireOccurrence" %>

<%@page import="no.pstop.webapp.TireOccurrence"%><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireOccurrence.list.title.label" /></title>
    </head>
    <body>
        <div class="nav">
	    	<g:if test="${params.action == 'list' && params.controller == 'tire'}">
        		<span class="menuButton" id="active" >
        			<g:link controller="tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link controller="tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link>
        		</span>
	        </g:else>
	        
	        <g:if test="${params.action == 'create' && params.controller == 'tire'}">
        		<span class="menuButton" id="active" >
        			<g:link controller="tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link controller="tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link>
        		</span>
	        </g:else>
	        
	        <g:if test="${params.action == 'list' && params.controller == 'tireOccurrence'}">
        		<span class="menuButton" id="active" >
        			<g:link controller="tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label"/></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link controller="tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label"/></g:link>
        		</span>
	        </g:else>
	        
	        <g:if test="${params.action == 'search' && params.controller == 'tire'}">
        		<span class="menuButton" id="active" >
		    		<g:link controller="tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
		    		<g:link controller="tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link>
        		</span>
	        </g:else>
        </div>
        <div class="body">
            <h1><g:message code="tireOccurrence.list.title.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="tire" title="${message(code: 'tireOccurrence.tire.table.label', default: 'Dekktype')}" />
                                              	    
                            <g:sortableColumn property="price" title="${message(code: 'tireOccurrence.price.table.label', default: 'Pris')}" />
                            
                            <g:sortableColumn property="discount" title="${message(code: 'tireOccurrence.discount.table.label')}" />
                        
                        	<g:sortableColumn property="environmentalFee" title="${message(code: 'tireOccurrence.environmentalFee.table.label')}" />
	                            
							<g:sortableColumn property="price" title="${message(code: 'tireOccurrence.sum.table.label')}" />
	                            
                            <g:sortableColumn property="numberInStock" title="${message(code: 'tireOccurrence.numberInStock.table.label', default: 'Antall')}" />
                        
                            <g:sortableColumn property="numberOfReserved" title="${message(code: 'tireOccurrence.numberOfReserved.table.label', default: 'Reservert')}" />
                        
                            <g:sortableColumn property="numberOfOrdered" title="${message(code: 'tireOccurrence.numberOfOrdered.table.label', default: 'Bestilt')}" />
                        
                            <g:sortableColumn property="numberOfAvailable" title="${message(code: 'tireOccurrence.numberOfAvailable.table.label', default: 'Tiljengelig')}" />
                        
                        	<g:sortableColumn property="registrationDate" title="${message(code: 'tireOccurrence.registrationDate.table.label', default: 'Registreringsdato')}" />
                        	
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${tireOccurrenceInstanceList}" status="i" var="tireOccurrenceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                        	<td><g:link action="show" id="${tireOccurrenceInstance.id}">${fieldValue(bean: tireOccurrenceInstance, field: "tire")}</g:link></td>
                        	
                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.price}" format="#.00 kr" /></g:link></td>
                            
                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.discount}" format="#" /> %</g:link></td>
                            
                            <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.environmentalFee}" format="# kr" /></g:link></td>

	                        <td><g:link controller="tireOccurrence" action="show" id="${tireOccurrenceInstance.id}"><g:formatNumber number="${tireOccurrenceInstance.sum()}" format="#.00 kr" /></g:link></td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberInStock")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberOfReserved")}</td>
                        
                            <td>${fieldValue(bean: tireOccurrenceInstance, field: "numberOfOrdered")}</td>
                        
                            <td>${tireOccurrenceInstance.numberOfAvailable()}</td>
                            
                            <td><g:formatDate format="dd.MM.yyyy" date="${tireOccurrenceInstance?.registrationDate}" /></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate next="${message(code: 'default.paginate.next')}" prev="${message(code: 'default.paginate.prev')}" controller="tireOccurrence"
            action="list" total="${tireOccurrenceInstanceTotal}"></g:paginate>
            </div>
        </div>
    </body>
</html>
