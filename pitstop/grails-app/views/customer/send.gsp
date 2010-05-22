<head>
	<title><g:message code="customer.sendSms.title" /></title>
</head>
<body>
	<div class="body">

		<h1><g:message code="customer.sendSms.header" /></h1>
		<g:hasErrors bean="${customerInstance}">
        <div class="errors">
        	<g:renderErrors bean="${customerInstance}" as="list" />
        </div>
        </g:hasErrors>

		<g:form method="post" action="sendSmsToCustomer">
			<div class="dialog">
			<table>
				<tbody>
				    
					<tr class="prop">
						<td valign="top" class="name"><label for="RCV"><g:message code="customer.sendSms.receiver.label" /></label></td>
						<td valign="top" class="value ${hasErrors(bean:authority,field:'authority','errors')}">
							<input type="text" id="RCV" name="RCV" value="${customerInstance?.phoneNumber}"/>
						</td>
					</tr>
		
					<tr class="prop">
						<td valign="top" class="name"><label for="TXT"><g:message code="customer.sendSms.message.label" /></label></td>
						<td valign="top" class="value ${hasErrors(bean:authority,field:'description','errors')}">
							<g:textArea name="TXT" cols="40" rows="5"/>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
			<div class="buttons">
				<span class="button">
					<g:hiddenField name="customerId" value="${customerInstance?.id}" />
					<g:submitToRemote name="SUBMIT" class="sendSmsToCustomer" onComplete="Modalbox.resizeToContent()" update="MB_content" action="sendSmsToCustomer" value="${message(code: 'customer.sendSms.button')}" />
				</span>
			</div>
		</g:form>
	</div>
</body>