<head>
	<title>Send SMS til kunde</title>
</head>
<body>
	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
		</g:if>
		
		<h1>Send SMS til kunde</h1>
		<g:hasErrors bean="${authority}">
			<div class="errors">
				<g:renderErrors bean="${authority}" as="list" />
			</div>
		</g:hasErrors>

		<g:form>
			<div class="dialog">
			<table>
				<tbody>
					<input type="hidden" name="USER" value="pitstop" />
				   	<input type="hidden" name="PW" value="ngriter7" />
				    <input type="hidden" name="SND" value="Pitstop" />
				    
					<tr class="prop">
						<td valign="top" class="name"><label for="RCV">Mottaker: </label></td>
						<td valign="top" class="value ${hasErrors(bean:authority,field:'authority','errors')}">
							<input type="text" id="RCV" name="RCV" value="47${customerInstanceList.phoneNumber}"/>
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
				//"http://sms.pswin.com/http4sms/send.asp"
				<g:submitToRemote url="[url:'/proxy?url=http://sms.pswin.com/http4sms/send.asp']" onSuccess="alert('Niks');"  update="[success:'MB_content', failure:'MB_content']" value="Send SMS" />
				<span class="button"><g:submitButton name="SUBMIT" class="save" value="Send sms"/></span>
			</div>
		</g:form>
	</div>
</body>
