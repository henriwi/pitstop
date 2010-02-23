
<%@ page import="no.pstop.webapp.Tire"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>S&oslash;k etter dekktype</title>
</head>
<body>
	<div class="nav">
		<span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Hjem</a></span>
        <span class="menuButton"><g:link class="list" action="list">Dekkliste</g:link></span>
        <span class="menuButton"><g:link class="create" action="create">Nytt dekk</g:link></span>
        <span class="menuButton"><g:link class="list" controller="tireOccurrence" action="list">Vis dekkforekomster</g:link></span>
        <span class="menuButton"><g:link class="search" action="search">S&oslash;k</g:link></span>
	</div>
	<div class="body">
		<h1>Hurtigs&oslash;k for dekk</h1>
		<g:form action="fastSearch" method="get">
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="txtFastSearch">Hurtigs&oslash;k:</label></td>
							<td valign="top"><g:textField tabindex='1' name="txtFastSearch" /></td>
							<td valign="top"><label>Eks: 195656v, Pirelli osv.</label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<g:submitButton tabindex='2' class="searchButtons" name="btnFastSearch"
									value="${message(code: 'default.button.search.label', default: 'Search')}" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</g:form>
		
		<h1>Normals&oslash;k for dekk</h1>
		<g:form action="normalSearch" method="get">
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="width">Bredde:</label></td>
							<td valign="top"><label for="profile">Profil:</label></td>
							<td valign="top"><label for="diameter">Diameter:</label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><g:textField tabindex='3' name="width" /></td>
							<td valign="top"><g:textField tabindex='4' name="profile" /></td>
							<td valign="top"><g:textField tabindex='5' name="diameter" /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for="speedIndex">Hastighetsindex:</label></td>
							<td valign="top"><label for="tireType">Sesong:</label></td>
							<td valign="top"><label for="brand">Merke:</label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<g:select tabindex='6' name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}"
									value="${tireInstance?.speedIndex}" noSelection="['Alle':'Alle']" valueMessagePrefix="tire.speedIndex" />
							</td>
							<td valign="top">
								<g:select tabindex='7' name="tireType" from="${tireInstance.constraints.tireType.inList}"
									value="${tireInstance?.tireType}" noSelection="['Alle':'Alle']" valueMessagePrefix="tire.tireType" /></td>
							<td valign="top"><g:textField tabindex='8' name="brand" /></td>
						</tr>
			
						<tr class="prop">
							<td valign="top" class="name">
								<g:submitButton tabindex='9' class="searchButtons" name="btnNormalSearch"
									value="${message(code: 'default.button.search.label', default: 'Search')}" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</g:form>
	</div>
</body>
</html>
