<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
    <g:isNotLoggedIn>
    	${response.sendRedirect("login/auth") }
    </g:isNotLoggedIn>
    	<gui:resources components="tabView, columnChart"/>
        <title>${message(code: 'index.title.label')}</title>
		<meta name="layout" content="main" />
    </head>
	<body>
		<div class="nav" id="emptyNav">
		</div>
		<div class="indexContent" style="padding-left: 30px;">
			<br />
			<g:form controller="tire" action="fastSearchForListView" method="get">
				<div id="fastSearchInListView">
					${message(code: 'index.tire.search.label')}<br /><g:textField tabindex='1' name="txtFastSearch" /></td>
					<g:submitButton tabindex='2' class="searchButtons" name="btnTireSearch" value="${message(code: 'search.button.fastSearch.label')}" />
				</div>
			</g:form>
			<br />
			<g:form controller="customer" action="search" method="get">
				<div id="fastSearchInListView">
					${message(code: 'index.customer.search.label')}<br /><g:textField tabindex='3' name="search" /></td>
					<g:submitButton tabindex='4' class="searchButtons" name="btnCustomerSearch" value="${message(code: 'search.button.fastSearch.label')}" />
				</div>
			</g:form>
			<br />
			<g:form controller="customer" action="pendingCustomerOrders" method="get">
				<div>
					${message(code: 'index.pendingCustomerOrders.label')} ${numberOfPendingCustomerOrders}
					<g:submitButton tabindex='5' class="searchButtons" name="btnShowPendingCustomerOrders" value="${message(code: 'index.button.show.label')}" />
					<br />
				</div>
			</g:form>
			<br />
			<g:form controller="tire" action="pendingSupplierOrders" method="get">
				<div>
					${message(code: 'index.pendingSupplierOrders.label')} ${numberOfPendingSupplierOrders}
					<g:submitButton tabindex='5' class="searchButtons" name="btnShowPendingSupplierOrders" value="${message(code: 'index.button.show.label')}" />
					<br />
				</div>
			</g:form>
		</div>
	</body>
</html>