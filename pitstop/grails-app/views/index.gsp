<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
    <g:isNotLoggedIn>
    	${response.sendRedirect("login/auth") }
    </g:isNotLoggedIn>
    	<gui:resources components="tabView, columnChart"/>
        <title>PIT-STOP</title>
		<meta name="layout" content="main" />
		
    </head>
<body>
	<div class="nav" id="emptyNav">
	</div>
	<div class="indexContent" style="padding-left: 30px;">
		<br />
		<g:form controller="tire" action="fastSearchForListView" method="get">
			<div id="fastSearchInListView">
				S&oslash;k etter dekk: <br /><g:textField tabindex='1' name="txtFastSearch" /></td>
				<g:submitButton tabindex='2' class="searchButtons" name="btnSearch" value="${message(code: 'search.button.fastSearch.label')}" />
			</div>
		</g:form>
		<br />
		<g:form controller="customer" action="search" method="get">
			<div id="fastSearchInListView">
				S&oslash;k etter kunde:<br /><g:textField tabindex='1' name="search" /></td>
				<g:submitButton tabindex='2' class="searchButtons" name="btnSearch" value="${message(code: 'search.button.fastSearch.label')}" />
			</div>
			</g:form>
	</div>
</body>
</html>