
<%@ page import="no.pstop.webapp.Tire"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>${message(code: 'search.title.label')}</title>
</head>
<body>
	<div class="nav">
		<span class="menuButton" id="${params.action == 'list' && params.controller == 'tire' ? 'active' : ''}" >
   			<g:link controller="tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link>
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
		<g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
        </g:if>
            
		
		
		<h1><g:message code="search.header.normalSearch.label" default="Normal tire search" /></h1>
		<g:form action="normalSearch" method="get">
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top"><label for="brand"><g:message code="tire.brand.label" /></label></td>
							<td valign="top" class="name"><label for="width"><g:message code="tire.width.label" /></label></td>
							<td valign="top"><label for="profile"><g:message code="tire.profile.label" /></label></td>
						</tr>
						<tr class="prop">
							<td valign="top"><g:textField tabindex='3' name="brand" /></td>
							<td valign="top" class="name"><g:textField tabindex='4' name="width" /></td>
							<td valign="top"><g:textField tabindex='5' name="profile" /></td>
						</tr>
						<tr class="prop">
							<td valign="top"><label for="diameter"><g:message code="tire.diameter.label" /></label></td>
							<td valign="top" class="name"><label for="speedIndex"><g:message code="tire.speedIndex.label" /></label></td>
							<td valign="top"><label for="tireType"><g:message code="tire.tireType.label" /></label></td>
						</tr>
						<tr class="prop">
							<td valign="top"><g:textField tabindex='6' name="diameter" /></td>
							<td valign="top" class="name">
								<g:select tabindex='7' name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}"
								value="${tireInstance?.speedIndex}" noSelection="['Alle':'Alle']" valueMessagePrefix="tire.speedIndex" />
							</td>
							<td valign="top"><g:select tabindex='8' noSelection="${['Alle':'Alle']}" name="tireType" from="${tireInstance.constraints.tireType.inList}" value="${tireInstance?.tireType}" valueMessagePrefix="tire.tireType" /></td>
						</tr>
			
						<tr class="prop">
							<td valign="top" class="name">
       			    			<g:submitButton name="active" value="${message(code: 'search.button.fastSearchActive.label')}" class="searchButtons"  /></td>
							</td>
							<td valign="top" class="name">
       			    			<g:submitButton name="deactive" value="${message(code: 'search.button.fastSearchDeactive.label')}" class="searchButtons"  /></td>
							</td>
							<td valign="top" class="name">
								<input type="reset" value=${message(code: 'search.button.clear')} class="searchButtons"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</g:form>
	</div>
</body>
</html>
