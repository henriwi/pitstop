<html>
    <head>
    	<gui:resources components="tabView"/>
        <title>Welcome to Grails</title>
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
		</style>
    </head>
<body>
<div class="body yui-skin-sam">
	<gui:tabView >
	    <gui:tab label="Hjem" active="true">
	         <gui:tabView>
	    <gui:tab label="Test 1" active="true">
	        <h1>Inne i test 1</h1>     
	    </gui:tab>
	    <gui:tab label="Test 2">
	        <h1>Inne i test 2</h2>	        
	    </gui:tab>
	</gui:tabView> 
	                
         <h1>Velkommen til pitstop</h1>
	        <br/>
	        <p>PIT-STOP kan tilby en rekke dekkmerker til alle typer biler, og til usl&aring;elige priser. 
	        Vi kan ogs&aring; gi sv&aelig;rt gode tilbud p&aring; felger.
	        Velkommen til en hyggelig dekkprat i gode faglige omgivelser.</p>     
    </gui:tab>
    <gui:tab label="Dekk">
        <div id="controllerList" class="dialog">
				<h2>Tiljengelige kontroller:</h2>
	            <ul>
	              <g:each var="c" in="${grailsApplication.controllerClasses}">
	                    <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
	              </g:each>
	            </ul>
	        </div>
    </gui:tab>
</gui:tabView>
</div>
		<div id="nav">
			
		</div>
		
		<div id="pageBody">
	       
	          
		</div>
    </body>
</html>