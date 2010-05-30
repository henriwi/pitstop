
<%@page import="no.pstop.webapp.TireHotelOccurrence"%>
<html>
    <head>
        <g:javascript library="application" />
        <g:javascript library="yui" />
		<modalbox:modalIncludes />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'print.css')}" media="print" />
        <title><g:message code="tireHotelOccurrence.list.title.label" /></title>
    </head>
    <body>
        <div class="nav">
			<span class="menuButton" ${(params.action == 'list' || params.action == 'save') ? "id='active'" : ""}  >
	        	<g:link class="tireHotelOccurrenceList" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link>
       		</span>
	        
	        <span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""}  >
	        	<g:link class="createTireHotelOccurrence" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="tireHotelOccurrence.list.header.label"/></h1>
            <g:form action="search" method="get">
				<div id="fastSearchInListView">
					<g:textField tabindex='1' name="search" /></td>
					<g:submitButton tabindex='2' class="searchButtons" name="btnSearch" value="${message(code: 'search.button.fastSearch.label')}" />
					<g:link action="list" class="btnShowAll" title="${message(code: 'tireHotelOccurence.list.showAll.link.tooltip')}"><g:message code="tireHotelOccurrence.search.showAll.label" /></g:link>							
				</div>
			</g:form>
			<!-- <modalbox:createLink controller="tireHotelOccurrence" action="create" title="Show book!" width="500" overlayDuration="0" slideDownDuration="0" resizeDuration="0">Book</modalbox:createLink>-->
            <div class="list" id="tireHotelTableList">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label')}" />
                        
                            <g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label')}" />
                        
                            <g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label')}" />
                        
                            <g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label')}" />
                        
                            <g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label')}" />
                            
                            <g:sortableColumn property="outDate" title="${message(code: 'tireHotelOccurrence.list.outDate.label')}" />
                            
                            <g:sortableColumn property="customer" title="${message(code: 'tireHotelOccurrence.list.customer.label')}" />
                            
                            <g:sortableColumn property="notice" title="${message(code: 'tireHotelOccurrence.list.notice.label')}" />
                            
                            <th class="buttonRow"><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.edit.label')}</a></th>
                            
                            <th class="buttonRow"><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delivered.label')}</a></th>
                            
                            <th class="buttonRow"><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.change.label')}</a></th>

                            <g:ifAllGranted role="ROLE_ADMIN">
                            	<th class="buttonRow"><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delete.label')}</a></th>
                            </g:ifAllGranted>
                        
                        </tr>
                    </thead>
                    <tbody>
	                    <g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                        
	                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</g:link></td>
	                        
	                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</g:link></td>
	                        
	                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</g:link></td>
	                        
	                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</g:link></td>
	                        
	                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></g:link></td>
	                            
	                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.outDate}" /></g:link></td>
	                            
	                            <td><g:link controller="customer" action="show" id="${tireHotelOccurrenceInstance?.customer?.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "customer")}</g:link></td>
	                            
	                            <td><g:link action="show" id="${tireHotelOccurrenceInstance.id}">${tireHotelOccurrenceInstance?.showNoticeWith10FirstLetters()}</g:link></td>
	                            
	                            <td class="buttonRow"><g:link class="editTireHotelOccurrenceTableItem" action="edit" title="${message(code: 'tireHotelOccurrence.list.edit.tooltip.label')}" id="${tireHotelOccurrenceInstance.id}">&nbsp;</g:link></td>
	                            
	                            <td class="buttonRow">
	                            	<g:form method="post">
	                            		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
										<g:hiddenField name="delivered" value="delivered" />
	                            		<g:actionSubmit class="delivered" title="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" action="update" value="${message(code: 'tireHotelOccurrence.list.delivered.button')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
	                            	</g:form>
	                            </td>
	                            
	                            <td class="buttonRow">
	                            	<g:form method="post">
	                            		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
	                            		<g:actionSubmit class="change" action="change" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.change.button')}" />
	                            	</g:form>
	                            </td>
	                            
	                            <g:ifAllGranted role="ROLE_ADMIN">
		                            <td class="buttonRow">
		                            	<g:form method="post">
		                            		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
		                            		<g:actionSubmit class="deleteTableItem" title="${message(code: 'tireHotelOccurrence.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'tireHotelOccurrence.button.delete.confirm.message')}');" />
		                            	</g:form>
		                            </td>
		                        </g:ifAllGranted>
	                        </tr>
	                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tireHotelOccurrenceInstanceTotal}" />
            </div>
            
            <div class="iPhone">
            	<g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
	            	<div class="tireHotelOccurrenceInfoBox">
	            		<span class="tireHotelOccurrenceTitle">
							<h3 class="tireHotelOccurrenceTitle">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</h3>
						 	- ${fieldValue(bean: tireHotelOccurrenceInstance, field: "customer")}<br />
						</span>
						 	<span class="carInfo">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")} ${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</span>
						 	<span class="tireType">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</span>
						 	<span class="inDate">Dato inn: <g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></span>
						 	<span class="notice">${fieldValue(bean: tireHotelOccurrenceInstance, field: "notice")}</span>
	                	<div style="clear:both;"></div>
	                </div>
                </g:each>
            </div>
        </div>
    </body>
</html>
