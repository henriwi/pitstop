
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
			<span class="menuButton" id="${params.action == 'list' && params.controller == 'tire' || params.action == 'save' ? 'active' : ''}" >
       			<g:link controller="tire" class="tireList" action="list"><g:message code="default.button.tireList.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'create' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'search' && params.controller == 'tire' ? 'active' : ''}" >
	    		<g:link controller="tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <h1>${message(code: 'tire.list.title.label')}</h1>
         
            <g:form action="fastSearch" method="get">
 				<div id="fastSearchInListView">
					<g:textField tabindex='1' name="txtFastSearch" />
					<g:submitButton tabindex='2' class="searchButtons" name="btnSearch" value="${message(code: 'search.button.fastSearch.label')}" />
					<g:link action="list" class="btnShowAll"><g:message code="customer.search.showAll.label" /></g:link>	
				</div>
			</g:form>
			
            <div class="list" id="tireTableList">
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
	                     		<th><a class="notSortableColoumn">${message(code: 'tire.list.disable.table.label')}</a></th>
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
            
            <div class="iPhone">
            	<g:each in="${tireInstanceList}" status="i" var="tireInstance">
	            	<g:if test="${tireInstance.numberInStock}">
		            	<div class="tireInfoBox">
		            		<span class="headerName">
								<h3 class="tireBrand">${fieldValue(bean: tireInstance, field: "brand")} ${fieldValue(bean: tireInstance, field: "tireName")}</h3>
							 	- ${fieldValue(bean: tireInstance, field: "partNr")}
							</span>
		            		
		            		<span class="tireWidth">
		            			${fieldValue(bean: tireInstance, field: "width")}/${fieldValue(bean: tireInstance, field: "profile")}
								${fieldValue(bean: tireInstance, field: "construction")}${fieldValue(bean: tireInstance, field: "diameter")}
								${fieldValue(bean: tireInstance, field: "loadIndex")}${fieldValue(bean: tireInstance, field: "speedIndex")}
							</span>
							
							<span class="tireSeason">${fieldValue(bean: tireInstance, field: "tireType")}
								<g:if test="${tireInstance.pattern}">
									${fieldValue(bean: tireInstance, field: "pattern")}
								</g:if>
							</span>
							
							<span class="tirePrice">
								${message(code: 'tire.iPhone.retailPrice.label')}<g:formatNumber number="${tireInstance?.retailPrice}" format="kr #.00" />
							</span>
							
							<g:if test="${tireInstance.notice}">
								<span class="notice">
									${fieldValue(bean: tireInstance, field: "notice")}
								</span> 
							</g:if>
							
							<span class="tireNumbers">
								<span class="numberOfTiresInStock"><g:message code="tire.numberInStock.label" />${fieldValue(bean: tireInstance, field: "numberInStock")}</span>
								<span class="tireNumberOfAvailable"><g:message code="tire.numberOfAvailable.label" />${tireInstance?.numberOfAvailable()}</span>		
							</span>
		            	</div>
		            	
	                	<div style="clear:both;"></div>
	                </g:if>
            	</g:each>
			</div>
        </div>
    </body>
</html>
