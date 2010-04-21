<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="shortcut icon" href="${resource(dir:'images', file:'pitstop.ico')}" type="image/x-icon" />
        <link rel="stylesheet" href="${resource(dir:'css', file:'main.css')}" />

<!-- Tilpasser til iPhone -->
        <link rel="stylesheet" media="only screen and (max-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
        <link rel="stylesheet" media="only screen and (max-device-width: 480px)" href="${resource(dir:'css',file:'iphone.css')}" type= "text/css" />
        <meta name = "viewport" content="width=device-width">
        <meta name="apple-mobile-web-app-capable"  content="yes"  />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
        
        <g:layoutHead />
        <g:javascript library="application" />
        <g:javascript library="script" />
        <g:javascript library="yui" />
        <modalbox:modalIncludes />
    </head>
    <body onload="showElement('onlyActiveTireHotelOccurrences');">
		<div id="container">
        	<div id="pstopLogo" class="logo">
        		<a href="${createLink(uri: '/')}"><img src="${resource(dir:'images', file:'pitstopLogo.png')}" alt="pitstopLogo" border="0" /></a>
        	</div>
        	<div id="mainMenu">
        		<g:isLoggedIn>
					<g:link class="logoutButton" controller="logout">${message(code: 'main.menu.logout.label')}</g:link>
				</g:isLoggedIn>
				
		        <ul id="menuList">
		        	<g:if test="${params.controller == null}">
		        		<li><a class="active" href="${createLink(uri: '/')}">${message(code: 'main.menu.home.label')}</a></li>
		        	</g:if>
			        <g:else>
			        	<li><a href="${createLink(uri: '/')}">${message(code: 'main.menu.home.label')}</a></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'tire' || params.controller == 'tireOccurrence'}">
		        		<li><g:link class="active" controller="tire">${message(code: 'main.menu.tires.label')}</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="tire">${message(code: 'main.menu.tires.label')}</g:link></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'customer'}">
			        	<li><g:link class="active" controller="customer">${message(code: 'main.menu.customers.label')}</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="customer">${message(code: 'main.menu.customers.label')}</g:link></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'tireHotelOccurrence'}">
			        	<li><g:link class="active" controller="tireHotelOccurrence">${message(code: 'main.menu.tireHotel.label')}</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="tireHotelOccurrence">${message(code: 'main.menu.tireHotel.label')}</g:link></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'customerOrder'}">
			        	<li><g:link class="active" controller="customerOrder">${message(code: 'main.menu.customerOrder.label')}</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="customerOrder">${message(code: 'main.menu.customerOrder.label')}</g:link></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'supplierOrder'}">
			        	<li><g:link class="active" controller="supplierOrder">${message(code: 'main.menu.supplierOrder.label')}</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="supplierOrder">${message(code: 'main.menu.supplierOrder.label')}</g:link></li>
			        </g:else>
			        
			   		<g:if test="${params.controller == 'user'}">
		        		<li><g:link class="active" controller="user">${message(code: 'main.menu.admin.label')}</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="user">${message(code: 'main.menu.admin.label')}</g:link></li>
			        </g:else>
			   		
			        <%--
					<g:each var="c" in="${grailsApplication.controllerClasses}">
			        	<li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
			       	</g:each>
			       	--%>	
			    </ul>
	        </div>
	        <div id="content">
	        	<g:layoutBody />
	        </div>
	        	<div style="clear:both"></div>
	        </div>
		</div>
    </body>
</html>