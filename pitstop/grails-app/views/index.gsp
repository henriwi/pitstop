<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
    <g:isNotLoggedIn>
    	${response.sendRedirect("login/auth") }
    </g:isNotLoggedIn>
    	<gui:resources components="tabView, columnChart"/>
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
	        
	        <!--  <img src="${resource(dir:'images',file:'pig.jpg')}" alt="pitstopLogo" border="0" /> -->
      <%
    	def labels = ['First','Second','Third']
    	def colors = ['FF0000','00ff00','0000ff']
    	def values = [35,45,10]
    	def values2 = [[35,45,10],[3,987,2]]
    	def values5 = [[0,16.7,23.3,33.3,60,76.7,83.3,86.7,93.3,96.7,100],[30,45,20,50,15,80,60,70,40,55,80],[0,10,16.7,26.7,33.3],[50,10,30,55,60]]
    	def values3 = [97,12,454,12,5,32,78,4,99,89,98,77,7,77]
    	def values4 = [[97,12,454,12,5,32,78,4,99,89,98,77,7,77],[1,6,42,15,78,94,26,45,12,10,21,22,33,33]]
    	def values6 = [[-500,30,700,253],[2,-5,3,6]]
    %>
    
    <g:barChart title='Sample Bar Chart' size="${[200,200]}" colors="FF0000|00ff00|0000ff" type="bvs"
		labels="${labels}" zeroLine="${'0.5'}" axes="x,y" axesLabels="${[0:['Jan','Feb','Mar'],1:[0,10,30,50]]}" fill="${'bg,s,efefef'}" dataType='simple' data='${values}' />
	<g:pieChart title='Sample Pie Chart' colors="${colors}" 
		labels="${labels}" fill="${'bg,s,efefef'}" dataType='simple' data='${values}' />
	 	
	 	<g:gmeter title='Lager' labels='${["Morn"]}' dataType='text' data='${[100]}' />

		<div id='columnChart' style="width:600px; height: 300px"></div>

	
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