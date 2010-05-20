<head>
	<title>Send SMS til kunde</title>
</head>
<body>
	<div class="body">

		<h1>Send SMS til kunde</h1>
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${authority}">
			<div class="errors">
				<g:renderErrors bean="${authority}" as="list" />
			</div>
		</g:hasErrors>

		<g:form method="post" action="sendSmsToCustomer">
			<div class="dialog">
			<table>
				<tbody>
					<input type="hidden" name="USER" value="pitstop" />
				   	<input type="hidden" name="PW" value="ngriter7" />
				    <input type="hidden" name="SND" value="Pitstop" />
				    
					<tr class="prop">
						<td valign="top" class="name"><label for="RCV">Mottaker: </label></td>
						<td valign="top" class="value ${hasErrors(bean:authority,field:'authority','errors')}">
							<input type="text" id="RCV" name="RCV" value="${customerInstanceList.phoneNumber}"/>
						</td>
					</tr>
		
					<tr class="prop">
						<td valign="top" class="name"><label for="TXT">Melding: </label></td>
						<td valign="top" class="value ${hasErrors(bean:authority,field:'description','errors')}">
							<g:textArea name="TXT" cols="40" rows="5"/>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
			<div class="buttons">
				<span class="button">
<!--<g:submitButton name="SUBMIT" class="save" value="Send sms"/>-->
					<g:submitToRemote name="SUBMIT" class="save" value="Send sms" update="MB_content" action="sendSmsToCustomer" value="Send SMS" />
				</span>
			</div>
		</g:form>
	</div>
</body>