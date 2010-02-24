
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tire.label', default: 'dekktype')}" />
        <title>${message(code: 'create.title.label', default: 'Opprett dekktype')}</title>
        
        <script type="text/javascript">
        	/* Tillater at kun tall skrives inn */
			function onlyNumbers(evt) {
			    evt = (evt) ? evt : window.event
			    var charCode = (evt.which) ? evt.which : evt.keyCode
			    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
			        return false
			    }
			    return true
			}
		</script>

    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label" default="Dekkliste" /></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label" default="Nytt dekk" /></g:link></span>
		    <span class="menuButton"><g:link controller="tireOccurrence" class="create" action="create"><g:message code="default.button.newTireOccurrence.label" default="Ny dekkforekomst"  /></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label" default="Dekkforekomster" /></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label" default="Søk" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tireInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="partNr"><g:message code="tire.partNr.label" default="Varenummer:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'partNr', 'errors')}">
                                    <g:textField tabindex='1' name="partNr" value="${tireInstance?.partNr}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="brand"><g:message code="tire.brand.label" default="Merke:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'brand', 'errors')}">
                                    <g:textField tabindex='2' name="brand" value="${tireInstance?.brand}" />
                                </td>
                            </tr>
                        	
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireName"><g:message code="tire.tireName.label" default="Dekknavn:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'tireName', 'errors')}">
                                    <g:textField tabindex='3' name="tireName" value="${tireInstance?.tireName}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="width"><g:message code="tire.width.label" default="Bredde:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'width', 'errors')}">
                                    <g:textField tabindex='4' name="width" value="${fieldValue(bean: tireInstance, field: 'width')}"
                                    	onKeyPress="return onlyNumbers(event)" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="profile"><g:message code="tire.profile.label" default="Profil:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'profile', 'errors')}">
                                    <g:textField tabindex='5' name="profile" value="${fieldValue(bean: tireInstance, field: 'profile')}"
                                    	onKeyPress="return onlyNumbers(event)" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="construction"><g:message code="tire.construction.label" default="Konstruksjon:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'construction', 'errors')}">
                                    <g:select name="construction" from="${tireInstance.constraints.construction.inList}" value="${tireInstance?.construction}" valueMessagePrefix="tire.construction"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="diameter"><g:message code="tire.diameter.label" default="Felgdiameter:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'diameter', 'errors')}">
                                    <g:textField tabindex='6' name="diameter" value="${fieldValue(bean: tireInstance, field: 'diameter')}" 
                                    	onKeyPress="return onlyNumbers(event)" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loadIndex"><g:message code="tire.index.label" default="Indeks:" /></label>
                                </td>
                                <td>
	                                <span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'loadIndex', 'errors')}">
	                                    <g:textField tabindex='7' name="loadIndex" value="${fieldValue(bean: tireInstance, field: 'loadIndex')}" 
                                    		onKeyPress="return onlyNumbers(event)" />
	                                </span>
	                                <span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'speedIndex', 'errors')}">
	                                    <g:select tabindex='8' name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}" value="${tireInstance?.speedIndex}" valueMessagePrefix="tire.speedIndex" />
	                                </span>
	                            </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pattern"><g:message code="tire.pattern.label" default="M&oslash;nster:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'pattern', 'errors')}">
                                    <g:textField tabindex='9' name="pattern" value="${tireInstance?.pattern}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireType"><g:message code="tire.tireType.label" default="Dekktype:" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'tireType', 'errors')}">
                                    <g:select tabindex='10' name="tireType" from="${tireInstance.constraints.tireType.inList}" value="${tireInstance?.tireType}" valueMessagePrefix="tire.tireType" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton tabindex='11' name="create" class="save" value="${message(code: 'create.button.create.label', default: 'Opprett')}" /></span>
                    <span class="button"><g:actionSubmit tabindex='12' class="cancel" action="list" value="${message(code: 'create.button.cancel.label', default: 'Avbryt')}" onclick="return confirm('${message(code: 'create.button.cancel.confirm.message', default: 'Er du sikker?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
