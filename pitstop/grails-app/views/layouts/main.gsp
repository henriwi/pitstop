<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
		<div id="container">
        	<div id="pstopLogo" class="logo">
        		<a href="${createLink(uri: '/')}"><img src="${resource(dir:'images',file:'pitstopLogo.png')}" alt="pitstopLogo" border="0" /></a>
        	</div>
        	<div id="mainMenu">
		        <ul id="menuList">
		        	<g:if test="${params.controller == null}">
		        		<li><a class="active" href="${createLink(uri: '/')}">Hjem</a></li>
		        	</g:if>
			        <g:else>
			        	<li><a href="${createLink(uri: '/')}">Hjem</a></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'tire' || params.controller == 'tireOccurrence'}">
		        		<li><g:link class="active" controller="tire">Dekkoversikt</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="tire">Dekkoversikt</g:link></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'customer'}">
			        	<li><g:link class="active" controller="customer">Kunder</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="customer">Kunder</g:link></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'tireHotelOccurrence'}">
			        	<li><g:link class="active" controller="tireHotelOccurrence">Dekkhotell</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="tireHotelOccurrence">Dekkhotell</g:link></li>
			        </g:else>
			        
			        <g:if test="${params.controller == 'customerOrder'}">
			        	<li><g:link class="active" controller="customerOrder">Kundebestilling</g:link></li>
		        	</g:if>
			        <g:else>
			        	<li><g:link controller="tireHotelOccurrence">Kundebestilling</g:link></li>
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