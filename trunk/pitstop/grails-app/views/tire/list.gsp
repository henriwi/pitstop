
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${message(code: 'tire.list.title.label')}</title>
        <g:javascript library="prototype" />
    </head>
    <body>
        <div class="nav">
			<span class="menuButton" id="${params.action == 'list' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="tireList" action="list"><g:message code="default.button.tireList.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'create' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'search' && params.controller == 'tire' ? 'active' : ''}" >
	    		<g:link controller="tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link>
       		</span>
       		
       		<span class="menuButton" id="${params.action == 'pendingSupplierOrders' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link class="pendingSupplierOrders" action="pendingSupplierOrders"><g:message code="tire.pendingSupplierOrders.title.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <h1>${message(code: 'tire.list.title.label')}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
         
             <g:form action="fastSearchForListView" method="get">
 				<div id="fastSearchInListView">
					<g:textField tabindex='1' name="txtFastSearch" /></td>
					<g:submitButton name="active" value="${message(code: 'search.button.fastSearch.label')}" class="searchButtons"    /></td>
       			   <%--  <g:submitButton name="deactive" value="${message(code: 'search.button.fastSearchDeactive.label')}" class="searchButtons"  /></td>--%>
					<g:link action="listShowAll" class="btnShowAll"><g:message code="customer.search.showAll.label" /></g:link>	
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
                            
                            <g:sortableColumn params="${params}" property="retailPrice" title="${message(code: 'tire.retailPrice.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="numberInStock" title="${message(code: 'tire.numberInStock.table.label')}" />
                            
                            <g:sortableColumn params="${params}" property="notice" title="${message(code: 'tire.notice.table.label')}" />
                            
                           <%--  <th><a class="notSortableColoumn">${message(code: 'tireOccurrence.numberOfAvailable.table.label')}</a></th> --%>
                            
                            <th><a class="notSortableColoumn">${message(code: 'tire.list.edit.label')}</a></th>

           	                <g:ifAllGranted role="ROLE_ADMIN"> 
	                     	<th><a class="notSortableColoumn">${message(code: 'tire.list.disable.label')}</a></th>
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
                            
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "retailPrice")}</g:link></td>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${fieldValue(bean: tireInstance, field: "numberInStock")}</g:link></td>
                            
                            <td><g:link action="show" id="${tireInstance.id}">${tireInstance?.showNoticeWith10FirstLetters()}</g:link></td>
                            
                            <td><g:link class="editTableItem" action="edit" title="${message(code: 'tire.list.edit.tooltip.label')}" id="${tireInstance.id}">&nbsp;</g:link></td>
                            
           	                <g:ifAllGranted role="ROLE_ADMIN"> 
                            <td>
			                    	<g:form method="post">
			                        	<g:hiddenField name="id" value="${tireInstance?.id}" />
			         
			                           	<g:if test="${tireInstance?.enabled}">
			                           		<g:actionSubmit class="disableTireItem" title="${message(code: 'tire.list.disable.tooltip.label')}" action="disableAndEnable" value="${message(code: 'list.button.disableAndEnable.label')}" />
			                       		</g:if>
			                       		<g:else>
			                          		<g:actionSubmit class="enableTireItem" title="${message(code: 'tire.list.enable.tooltip.label')}" action="disableAndEnable" value="${message(code: 'list.button.disableAndEnable.label')}" />
			                       		</g:else>
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
