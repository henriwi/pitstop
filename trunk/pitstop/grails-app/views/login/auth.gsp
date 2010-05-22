<head>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />

<!-- Tilpasser til iPhone -->
        <link rel="stylesheet" media="only screen and (max-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
        <link rel="stylesheet" media="only screen and (max-device-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
        <meta name="viewport" content="initial-scale=1.0, width=device-width, height=device-height, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<title><g:message code="login.title.label"></title>
</head>

<body>
	<div class="dialog" id="login">
		<h1><g:message code="login.header.label"></g:message></h1>
		<form action='${postUrl}' method='POST' id='loginForm'>
			<g:if test="${flash.message}">
	         	<div class="message">${flash.message}</div>
	     	</g:if>
			<table>
				<tbody>
					<tr class="prop">
						<td><label for='j_username'><g:message code="login.username.label"></g:message></label></td>
						<td><input type='text' class='text_' name='j_username' id='j_username' value='${request.remoteUser}' /></td>
					</tr>
					
					<tr class="prop">
						<td><label for='j_password'><g:message code="login.password.label"></g:message></label></td>
						<td><input type='password' class='text_' name='j_password' id='j_password' /></td>
					</tr>
					
					<tr class="prop">
						<td><label for='remember_me'><g:message code="login.rememberMe.label"></g:message></label></td>
						<td><input type='checkbox' class='chk' name='_spring_security_remember_me' id='remember_me' /></td>
					</tr>
					<tr>
						<td><input type='submit' class="login" value="${message(code: 'login.button.login.label')}" /></td>
					</tr>
				
					<g:if test='${hasCookie}'>checked='checked'</g:if>
				</tbody>
			</table>
				
		</form>
</body>
