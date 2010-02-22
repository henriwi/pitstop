<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
        <div id="pstopLogo" class="logo"><a href="http://www.pstop.no"><img src="${resource(dir:'images',file:'pitstopLogo.png')}" alt="pitstopLogo" border="0" /></a></div>
        <div id="mainMenu">
        <ul id="menuList">
        <li><g:link controller="tire">Dekktyper</g:link></li>
			<%-- <g:each var="c" in="${grailsApplication.controllerClasses}">
	                	<li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
	       	</g:each>--%>	
	    </ul>
        </div>
        <div id="content">
        	<g:layoutBody />
        </div>
        
        
        
    </body>
</html>