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
		<div class="nav" id="emptyNav"></div>
		<div class="indexContent">
			<br />
			<g:form controller="tire" action="fastSearch" method="get">
				<div class="search">
					${message(code: 'index.tire.search.label')}<br /><g:textField tabindex='1' name="txtFastSearch" />
					<g:submitButton tabindex='2' class="searchButtons" name="btnTireSearch" value="${message(code: 'search.button.fastSearch.label')}" />
				</div>
			</g:form>
			<br />
			<g:form controller="customer" action="search" method="get">
				<div class="search">
					${message(code: 'index.customer.search.label')}<br /><g:textField tabindex='3' name="search" />
					<g:submitButton tabindex='4' class="searchButtons" name="btnCustomerSearch" value="${message(code: 'search.button.fastSearch.label')}" />
				</div>
			</g:form>
			<br />
			<g:form controller="tireHotelOccurrence" action="search" method="get">
				<div class="search">
					${message(code: 'index.tireHotelOccurrence.search.label')}<br /><g:textField tabindex='5' name="search" />
					<g:submitButton tabindex='6' class="searchButtons" name="btnTireHotelOccurrenceSearch" value="${message(code: 'search.button.fastSearch.label')}" />
				</div>
			</g:form>
			<br />
			<div id="pendingCustomerOrders">
				${message(code: 'index.pendingCustomerOrders.label')} ${numberOfPendingCustomerOrders}
				<g:if test="${numberOfPendingCustomerOrders != 0}">
					<g:link tabindex='7' controller="customerOrder" action="pendingCustomerOrders" class="btnShowAll"><g:message code="index.button.show.label"></g:message></g:link>
				</g:if>
				<br />
			</div>
			<br />
			<div id="pendingSupplierOrders">
				${message(code: 'index.pendingSupplierOrders.label')} ${numberOfPendingSupplierOrders}
				<g:if test="${numberOfPendingSupplierOrders != 0}">
					<g:link tabindex='8' controller="supplierOrder" action="pendingSupplierOrders" class="btnShowAll"><g:message code="index.button.show.label"></g:message></g:link>
				</g:if>
				<br />
			</div>
		</div>
	</body>
</html>