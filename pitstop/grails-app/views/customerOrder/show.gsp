<%@ page import="no.pstop.webapp.CustomerOrder" %>
<div class="dialog">
    <table>
        <tbody>
			<g:each in="${customerOrderInstance.customerOrderLines}" var="customerOrderLineInstance">
				<tr>
					<td>${customerOrderLineInstance?.encodeAsHTML()}</td>
					<td>
						<g:form controller="customerOrder" action="deliverOrderLine" method="post">
							<g:hiddenField name="id" value="${customerOrderLineInstance?.id}" />
							<g:submitButton class="recieveSupplierOrder" title="${message(code: 'customerOrderLine.recieve.tooltip.label')}" name="deleteFromOrder" value="${message(code: 'list.button.table.label')}" onclick="return confirm('${message(code: 'customerOrder.button.delete.confirm.message')}');" />
						</g:form>
					</td>
				</td>
			</g:each>
        </tbody>
    </table>
 </div>