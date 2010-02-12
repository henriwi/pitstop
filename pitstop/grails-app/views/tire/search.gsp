
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>S&oslash;k etter dekktype</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Hjem</a></span>
            <span class="menuButton"><g:link class="create" action="create">Ny dekktype</g:link></span>
            <span class="menuButton"><g:link class="search" action="search">S&oslash;k</g:link></span>
       	</div>
     		<div class="body">
            <h1>Dekks&oslash;k</h1>
                   <div class="dialog">
                    <table>
                        <tbody>
                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fastSearch">Hurtigs&oslash;k</label>
                                </td>
                                <td valign="top">
                                    <g:textField tabindex='1' name="fastSearch"/>
                                </td>
                                <td valign="top">
                                		<label>eks: 195656v</label>
                                </td>
                            	</tr>
                            	<tr class="prop">
                            	<td valign="top" class="name">
                            		<g:submitButton tabindex='11' name="S&oslash;k" />
                            	</td>
                            	</tr>
                    		</tbody>
                   	</table>  
                   </div>	

	     	</div>
	     	
					
    </body>
</html>
