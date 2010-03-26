<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
    <g:isNotLoggedIn>
    	${response.sendRedirect("login/auth") }
    </g:isNotLoggedIn>
    	<gui:resources components="tabView"/>
        <title>Velkommen til PIT-STOP</title>
		<meta name="layout" content="main" />
		<style type="text/css" media="screen">

			#nav {
				margin-top:20px;
				margin-left:30px;
				width:228px;
				float:left;

			}
			.homePagePanel * {
				margin:0px;
			}
			.homePagePanel .panelBody ul {
				list-style-type:none;
				margin-bottom:10px;
			}
			.homePagePanel .panelBody h1 {
				text-transform:uppercase;
				font-size:1.1em;
				margin-bottom:10px;
			}
			.homePagePanel .panelBody {
			    background: url(images/leftnav_midstretch.png) repeat-y top;
				margin:0px;
				padding:15px;
			}
			.homePagePanel .panelBtm {
			    background: url(images/leftnav_btm.png) no-repeat top;
				height:20px;
				margin:0px;
			}

			.homePagePanel .panelTop {
			    background: url(images/leftnav_top.png) no-repeat top;
				height:11px;
				margin:0px;
			}
			h2 {
				margin-top:15px;
				margin-bottom:15px;
				font-size:1.2em;
			}
			#pageBody {
				margin-left:280px;
				margin-right:20px;
			}
			#nav {
				width: 450px;
			}
		</style>
    </head>
<body>
<div class="indexContent" style="padding-left: 30px;">

			<h1>Velkommen til PIT-STOP</h1>
	        <br/>
	        <p>PIT-STOP kan tilby en rekke dekkmerker til alle typer biler, og til usl&aring;elige priser. 
	        Vi kan ogs&aring; gi sv&aelig;rt gode tilbud p&aring; felger.
	        Velkommen til en hyggelig dekkprat i gode faglige omgivelser.</p>
	        
	        <img src="${resource(dir:'images',file:'pig.jpg')}" alt="pitstopLogo" border="0" />
		
		<%-- <div id="nav">
			<g:form controller="tire" action="fastSearch" method="get">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="txtFastSearch"><g:message code="S&oslash;k etter dekktyper" /></label></td>
							<td valign="top"><g:textField tabindex='1' name="txtFastSearch" /></td>
							<td valign="top"><label>Eks: 195656v, Pirelli osv.</label></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name">
								<g:submitButton  tabindex='2' class="searchButtons" name="btnFastSearch"
									value="${message(code: 'search.button.fastSearch.label')}" />
							</td>
						</tr>

						</tr>
					</tbody>
				</table>
			  <br/><br/>
	  		  <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
			  <br/><br/>
              <span class="menuButton"><g:link controller="user" class="create" action="create"><g:message code="customer.create.title.label" /></g:link></span>
			  <br/><br/>
			  <span class="menuButton"><g:link controller="tireHotelOccurrence" class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link></span>
			
		</g:form>
		</div>--%>
		
</div>
		
    </body>
</html>