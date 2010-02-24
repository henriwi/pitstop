
<%@ page import="no.pstop.webapp.Tire"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>${message(code: 'search.title.label', default: 'Søk etter dekktype')}</title>
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
		<h1>${message(code: 'search.header.fastSearch.label', default: 'Hurtigs&oslash;k for dekk')}</h1>
		<g:form action="fastSearch" method="get">
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="txtFastSearch"><g:message code="search.fastSearch.label" default="Hurtigsøk" /></label></td>
							<td valign="top"><g:textField tabindex='1' name="txtFastSearch" /></td>
							<td valign="top"><label>Eks: 195656v, Pirelli osv.</label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<g:submitButton tabindex='2' class="searchButtons" name="btnFastSearch"
									value="${message(code: 'search.button.fastSearch.label', default: 'Søk')}" />
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
							<td valign="top" class="name"><label for="width"><g:message code="tire.width.label" default="Bredde:" /></label></td>
							<td valign="top"><label for="profile"><g:message code="tire.profile.label" default="Profile:" /></label></td>
							<td valign="top"><label for="diameter"><g:message code="tire.diameter.label" default="Diameter:" /></label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><g:textField tabindex='3' name="width" /></td>
							<td valign="top"><g:textField tabindex='4' name="profile" /></td>
							<td valign="top"><g:textField tabindex='5' name="diameter" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for="speedIndex"><g:message code="tire.speedIndex.label" default="Hastighetsindeks:" /></label></td>
						<td valign="top"><label for="tireType"><g:message code="tire.tireType.label" default="Sesong:" /></label></td>
							<td valign="top"><label for="brand"><g:message code="tire.brand.label" default="Merke:" /></label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<g:select tabindex='6' name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}"
									value="${tireInstance?.speedIndex}" noSelection="['Alle':'Alle']" valueMessagePrefix="tire.speedIndex" />
							</td>
							<td valign="top">
								<g:set var="Sommer" value="${'Sommer'}"></g:set>
								<g:set var="Vinter" value="${'Vinter'}"></g:set>
								
								<select tabindex='7' name="tireType">
									<option value="Alle">Alle</option>
									<option value="Sommer">Sommer</option>
									<option value="Vinter">Vinter</option>
								</select>
							</td>
							<td valign="top"><g:textField tabindex='8' name="brand" /></td>
						</tr>
			
						<tr class="prop">
							<td valign="top" class="name">
								<g:submitButton tabindex='9' class="searchButtons" name="btnNormalSearch"
									value="${message(code: 'search.button.normalSearch.label', default: 'Søk')}" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</g:form>
	</div>
</body>
</html>
