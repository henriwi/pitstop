
<%@ page import="no.pstop.webapp.Tire"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>${message(code: 'search.title.label')}</title>
</head>
<body>
	<div class="nav">
	    <span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link></span>
	    <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
	    <span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label"/></g:link></span>
	    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>
	</div>
	<div class="body">
		<h1>${message(code: 'search.header.fastSearch.label')}</h1>
		
		<g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
        </g:if>
            
		<g:form action="fastSearch" method="get">
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="txtFastSearch"><g:message code="search.fastSearch.label" /></label></td>
							<td valign="top"><g:textField tabindex='1' name="txtFastSearch" /></td>
							<td valign="top"><label>Eks: 195656v, Pirelli osv.</label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<g:submitButton tabindex='2' class="searchButtons" name="btnFastSearch"
									value="${message(code: 'search.button.fastSearch.label')}" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</g:form>
		
		<h1><g:message code="search.header.normalSearch.label" default="Normalsøk for dekk" /></h1>
		<g:form action="normalSearch" method="get">
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="width"><g:message code="tire.width.label" /></label></td>
							<td valign="top"><label for="profile"><g:message code="tire.profile.label" /></label></td>
							<td valign="top"><label for="diameter"><g:message code="tire.diameter.label" /></label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><g:textField tabindex='3' name="width" /></td>
							<td valign="top"><g:textField tabindex='4' name="profile" /></td>
							<td valign="top"><g:textField tabindex='5' name="diameter" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for="speedIndex"><g:message code="tire.speedIndex.label" /></label></td>
						<td valign="top"><label for="tireType"><g:message code="tire.tireType.label" /></label></td>
							<td valign="top"><label for="brand"><g:message code="tire.brand.label" /></label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<g:select tabindex='6' name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}"
									value="${tireInstance?.speedIndex}" noSelection="['Alle':'Alle']" valueMessagePrefix="tire.speedIndex" />
							</td>
							<td valign="top">
							 <g:select tabindex='7' noSelection="${['Alle':'Alle']}" name="tireType" from="${tireInstance.constraints.tireType.inList}" value="${tireInstance?.tireType}" valueMessagePrefix="tire.tireType" />
							</td>
							<td valign="top"><g:textField tabindex='8' name="brand" /></td>
						</tr>
			
						<tr class="prop">
							<td valign="top" class="name">
								<g:submitButton tabindex='9' class="searchButtons" name="btnNormalSearch"
									value="${message(code: 'search.button.normalSearch.label')}" />
								<input type="reset" value="Nullstill" class="searchButtons"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</g:form>
	</div>
</body>
</html>
