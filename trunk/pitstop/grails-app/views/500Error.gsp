<html>
<head>
	<title>500 - Feil</title>
	<link rel="shortcut icon" href="${resource(dir:'images', file:'pitstop.ico')}" type="image/x-icon" />
	<link rel="stylesheet" href="${resource(dir:'css', file:'main.css')}" />
	<link rel="stylesheet" media="only screen and (max-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
	<link rel="stylesheet" media="only screen and (max-device-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
    <meta name = "viewport" content="width=device-width" />
    <meta name="apple-mobile-web-app-capable"  content="yes"  />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
</head>
<body>
	<div id="errorContainer">
		<h1>Feil!</h1>
		<img id="errorImage" src="${resource(dir:'images', file:'flat_tire.png')}" alt="Flatt dekk"/>
		<div id="errorMessage">
			<p>Beklager, men det skjedde en feil.</p>
			<p><a href="${createLink(uri: '/')}">G&aring; til startsiden</a></p>
		</div>
	</div>
</body>
</html>