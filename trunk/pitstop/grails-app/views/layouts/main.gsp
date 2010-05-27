<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
    	
        <title><g:layoutTitle default="PIT-STOP" /></title>
        <link rel="shortcut icon" href="${resource(dir:'images', file:'pitstop.ico')}" type="image/x-icon" />
        <link rel="stylesheet" href="${resource(dir:'css', file:'main.css')}" />
		<link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'print.css')}" media="print" /> 

        <link rel="stylesheet" media="only screen and (max-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
        <link rel="stylesheet" media="only screen and (max-device-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
        <meta name="viewport" content="width=device-width, user-scalable=no" />
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes"  />
        
        <g:layoutHead />
        <g:javascript library="application" />
        <g:javascript library="script" />
        <g:javascript library="yui" />
        <g:javascript library="prototype" />

        <modalbox:modalIncludes />
        <!-- <gui:resources components="autoComplete" />-->
        <resource:dateChooser />
    </head>
    <body>
		<div id="container">
        	<div id="pstopLogo" class="logo">
        		<a href="${createLink(uri: '/')}"><img src="${resource(dir:'images', file:'pitstopLogo.png')}" alt="pitstopLogo"/></a>
	        	<span id="userInfoLabel">Logget inn som: <g:loggedInUserInfo field="username" /></span>
        	</div>
        	<div id="mainMenu">
				<g:link class="logoutButton" controller="logout">${message(code: 'main.menu.logout.label')}</g:link>
				
		        <ul id="menuList">
		        	<li id="mainMenuItem"><a class="${(params.controller == 'index') ? 'active' : ''}" href="${createLink(uri: '/')}">${message(code: 'main.menu.home.label')}</a></li>
			        
		        	<li id="tireMenuItem"><g:link class="${(params.controller == 'tire') ? 'active' : ''}" controller="tire">${message(code: 'main.menu.tires.label')}</g:link></li>
			        
			        <li id="customerMenuItem"><g:link class="${(params.controller == 'customer') ? 'active' : ''}" controller="customer">${message(code: 'main.menu.customers.label')}</g:link></li>
			        
			        <li id="tireHotelMenuItem"><g:link class="${(params.controller == 'tireHotelOccurrence') ? 'active' : ''}" controller="tireHotelOccurrence">${message(code: 'main.menu.tireHotel.label')}</g:link></li>
			        
		        	<li id="customerOrderMenuItem"><g:link class="${(params.controller == 'customerOrder') ? 'active' : ''}" controller="customerOrder" action="pendingCustomerOrders">${message(code: 'main.menu.customerOrder.label')}</g:link></li>
			        
		        	<li id="supplierOrderMenuItem"><g:link class="${(params.controller == 'supplierOrder') ? 'active' : ''}" controller="supplierOrder" action="pendingSupplierOrders">${message(code: 'main.menu.supplierOrder.label')}</g:link></li>
		        	
			        <g:ifAllGranted role="ROLE_ADMIN">
	        			<li id="adminMenuItem"><g:link class="${(params.controller == 'user') ? 'active' : ''}" controller="user">${message(code: 'main.menu.admin.label')}</g:link></li>
			   		</g:ifAllGranted>
			    </ul>
	        </div>
	        <div id="content">
	        	<g:layoutBody />
	        </div>
	        <span id="iPhoneLogout" class="iPhone"><g:link class="logoutButton"  controller="logout">${message(code: 'main.menu.logout.label')}</g:link></span>
        	<div style="clear:both"></div>
        </div>
    </body>
</html>