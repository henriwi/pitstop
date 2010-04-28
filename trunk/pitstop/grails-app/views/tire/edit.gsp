
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tire.label', default: 'dekk')}" />
        <title><g:message code="editTire.title.label" default="Endre dekk" /></title>
        
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
	    	<span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>
		    <span class="menuButton"><g:link class="pendingSupplierOrders" action="pendingSupplierOrders"><g:message code="tire.pendingSupplierOrders.title.label" /></g:link></span>
        </div>
        
        <div class="body">
            <h1><g:message code="editTire.title.label" default="Endre dekk" /></h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <g:hasErrors bean="${tireInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${tireInstance}" as="list" />
	            </div>
            </g:hasErrors>
            
            <g:form method="post" >
                <g:hiddenField name="id" value="${tireInstance?.id}" />
                <g:hiddenField name="version" value="${tireInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name"><label for="partNr"><g:message code="tire.partNr.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'partNr', 'errors')}">
                                    <g:textField maxlength="40" name="partNr" value="${tireInstance?.partNr}" /></td>
                            </tr>
                        	
                        	<tr class="prop">
                                <td valign="top" class="name"><label for="brand"><g:message code="tire.brand.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'brand', 'errors')}">
                                    <g:textField maxlength="30" name="brand" value="${tireInstance?.brand}" /></td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><label for="tireName"><g:message code="tire.tireName.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'tireName', 'errors')}">
                                    <g:textField maxlength="30" name="tireName" value="${tireInstance?.tireName}" /></td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><label for="width"><g:message code="tire.width.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'width', 'errors')}">
                                    <g:textField maxlength="20" name="width" value="${fieldValue(bean: tireInstance, field: 'width')}" onKeyPress="return onlyNumbers(event)" /></td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><label for="profile"><g:message code="tire.profile.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'profile', 'errors')}">
                                    <g:textField maxlength="20" name="profile" value="${fieldValue(bean: tireInstance, field: 'profile')}" onKeyPress="return onlyNumbers(event)" /></td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><label for="construction"><g:message code="tire.construction.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'construction', 'errors')}">
                                    R<g:hiddenField name="construction" value="R" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><label for="diameter"><g:message code="tire.diameter.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'diameter', 'errors')}">
                                    <g:textField maxlength="20" name="diameter" value="${fieldValue(bean: tireInstance, field: 'diameter')}" onKeyPress="return onlyNumbers(event)" /></td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><label for="loadIndex"><g:message code="tire.index.label" /></label></td>
                                <td>
	                                <span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'loadIndex', 'errors')}">
	                                    <g:textField maxlength="3" name="loadIndex" value="${fieldValue(bean: tireInstance, field: 'loadIndex')}" onKeyPress="return onlyNumbers(event)" /></span>
	                            	<span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'speedIndex', 'errors')}">
	                                    <g:select name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}" value="${tireInstance?.speedIndex}" valueMessagePrefix="tire.speedIndex"  /></span>
	                            </td>
							</tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><label for="pattern"><g:message code="tire.pattern.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'pattern', 'errors')}">
                                    <g:textField maxlength="30" name="pattern" value="${tireInstance?.pattern}" /></td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><label for="tireType"><g:message code="tire.tireType.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'tireType', 'errors')}">
                                    <g:select name="tireType" from="${tireInstance.constraints.tireType.inList}" value="${tireInstance?.tireType}" valueMessagePrefix="tire.tireType"  /></td>
                            </tr>
                            
                          	<tr class="prop">
                                <td valign="top" class="name"><label for="retailPrice"><g:message code="tire.retailPrice.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'retailPrice', 'errors')}">
                                    <g:textField maxlength="30" name="retailPrice" value="${tireInstance?.retailPrice}" /></td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><label for="numberInStock"><g:message code="tire.numberInStock.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'numberInStock', 'errors')}">
                                    <g:textField maxlength="30" name="numberInStock" value="${tireInstance?.numberInStock}" /></td>
                            </tr>
                            
                          	<tr class="prop">
                                <td valign="top" class="name"><label for="notice"><g:message code="tire.notice.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'notice', 'errors')}">
                                    <g:textArea name="notice" value="${tireInstance.notice}" rows="5" cols="10"/></td>
                            </tr>
                            
                          	<g:hiddenField name="enabled" value="${tireInstance?.enabled}" />
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label')}" /></span>
                    <span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'default.button.cancel.label')}" onclick="return confirm('${message(code: 'tire.button.cancel.confirm.message')}');" /></span>
                    <g:ifAllGranted role="ROLE_ADMIN">
                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label')}" onclick="return confirm('${message(code: 'tire.button.delete.confirm.message')}');" /></span>
                    </g:ifAllGranted>
                </div>
            </g:form>
        </div>
    </body>
</html>
