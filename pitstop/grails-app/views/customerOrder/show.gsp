<%@ page import="no.pstop.webapp.CustomerOrder" %>
<div class="dialog">
    <table>
        <tbody>
			<ul>
				<g:each in="${customerOrderInstance.customerOrderLines}" var="c">
					<li><g:link controller="customerOrderLine" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
				</g:each>
			</ul>
        </tbody>
    </table>
 </div>