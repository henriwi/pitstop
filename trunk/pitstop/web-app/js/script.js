function showAndHideElement(element1, element2) {
	document.getElementById(element1).style.display = "inherit";
	document.getElementById(element2).style.display = "none";
}

function sendSms(event) {
	/* Fungerer ikke og ødelegger for showAndHideElement()
	new Ajax.Request('http://sms.pswin.com/http4sms/send.asp', {
		method:'post',
		parameters: ${USER: 'pitstop',
					  PW: 'ngriter7',
					  SND: 'Pitstop',
					  RCV: '4741656686',
					  TXT: 'Test'}
	});
	event.preventDefault();
	*/
}