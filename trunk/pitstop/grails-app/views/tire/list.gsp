
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${message(code: 'tire.list.title.label')}</title>
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
            <h1>${message(code: 'tire.list.title.label')}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
         
             <g:form action="fastSearchForListView" method="get">
 				<div id="fastSearchInListView">
					<g:textField tabindex='1' name="txtFastSearch" /></td>
					<g:submitButton  tabindex='2' class="searchButtons" name="btnSearch"
					value="${message(code: 'search.button.fastSearch.label')}" />
					<g:link action="list" class="btnShowAll"><g:message code="customer.search.showAll.label" /></g:link>							
				</div>
			
			</g:form>
			
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn params="${params}" property="partNr" title="${message(code: 'tire.partNr.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="brand" title="${message(code: 'tire.brand.table.label')}" />

                            <g:sortableColumn params="${params}" property="tireName" title="${message(code: 'tire.tireName.table.label')}" />

                            <g:sortableColumn params="${params}" property="width" title="${message(code: 'tire.width.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="profile" title="${message(code: 'tire.profile.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="construction" title="${message(code: 'tire.construction.table.label')}" />
                        
                            <g:sortableColumn params="${params}" property="diameter" title="${message(code: 'tire.diameter.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="loadIndex" title="${message(code: 'tire.index.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="pattern" title="${message(code: 'tire.pattern.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="tireType" title="${message(code: 'tire.tireType.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="notice" title="${message(code: 'tire.notice.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="numberOfAvailable" title="${message(code: 'tireOccurrence.numberOfAvailable.table.label')}" />
                           <%--  <th><a class="notSortableColoumn">${message(code: 'tireOccurrence.numberOfAvailable.table.label')}</a></th> --%>
                            
                            <th><a class="notSortableColoumn">${message(code: 'tire.list.add.label')}</a></th>
                            
                            <th><a class="notSortableColoumn">${message(code: 'tire.list.edit.label')}</a></th>

           	                <g:ifAllGranted role="ROLE_ADMIN"> 
                            <th><a class="notSortableColoumn">${message(code: 'tire.list.delete.label')}</a></th>
                        	</g:ifAllGranted>
                        </tr>
                    </thead>
                    <tbody>
						
	                    <g:each in="${tireInstanceList}" status="i" var="tireInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "partNr")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "brand")}</g:link></td>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "tireName")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "width")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "profile")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "construction")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "diameter")}</g:link></td>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "loadIndex")}${fieldValue(bean: tireInstance, field: "speedIndex")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "pattern")}</g:link></td>
                        
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "tireType")}</g:link></td>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${tireInstance?.showNoticeWith10FirstLetters()}</g:link></td>
                            
                            <g:set var="numberOfAvailable" value="${0}"></g:set>
                            <g:each in="${tireInstance.tireOccurrences}" status="j" var="tireOccurrence">
                             	<g:set var="numberOfAvailable" value="${numberOfAvailable + (tireOccurrence.numberOfAvailable())}"></g:set>
                            </g:each>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${numberOfAvailable}</g:link></td>
                            
                            <td><g:link controller="tireOccurrence" class="saveTableItem" action="create" title="${message(code: 'tire.list.create.tooltip.label')}" id="${tireInstance.id}">${message(code: 'list.button.delete.label')}</g:link></td>
                            
                            <td><g:link class="editTableItem" action="edit" title="${message(code: 'tire.list.edit.tooltip.label')}" id="${tireInstance.id}">&nbsp;</g:link></td>
                            
           	                <g:ifAllGranted role="ROLE_ADMIN"> 
                            <td>
                            	<g:form method="post">
                            		<g:hiddenField name="id" value="${tireInstance?.id}" />
                            		<g:actionSubmit class="deleteTableItem" action="delete" title="${message(code: 'tire.list.delete.tooltip.label')}" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'tire.button.delete.confirm.message')}');" />
                            	</g:form>
                            </td>   
                            </g:ifAllGranted>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
             	<g:paginate next="${message(code: 'default.paginate.next')}" prev="${message(code: 'default.paginate.prev')}" controller="tire" action="list" params="${params}" total="${tireInstanceTotal}"></g:paginate>
            </div>
        </div>
    </body>
</html>
