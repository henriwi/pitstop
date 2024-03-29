
<%@ page import="no.pstop.webapp.Tire" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${message(code: 'createTire.title.label')}</title>
    </head>
    <body>
        <div class="nav">
       		<span class="menuButton" id="${params.action == 'list' && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="tireList" action="list"><g:message code="default.button.tireList.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${(params.action == 'create' || params.action == 'save') && params.controller == 'tire' ? 'active' : ''}" >
       			<g:link controller="tire" class="createTire" action="create"><g:message code="default.button.newTire.label"/></g:link>
       		</span>
	        
       		<span class="menuButton" id="${params.action == 'search' && params.controller == 'tire' ? 'active' : ''}" >
	    		<g:link controller="tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link>
       		</span>
		</div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="createTire.title.label"/></h1>
            
            <g:hasErrors bean="${tireInstance}">
            	<div class="errors">
	                <g:renderErrors bean="${tireInstance}" as="list" />
	            </div>
            </g:hasErrors>
            
            <g:form action="save" method="post" >
                <div class="tireCreateDialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name"><label for="partNr"><g:message code="tire.partNr.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'partNr', 'errors')}">
                                	<g:textField maxlength="40" tabindex='1' name="partNr" value="${tireInstance?.partNr}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><label for="brand"><g:message code="tire.brand.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'brand', 'errors')}">
                                    <g:textField maxlength="30" tabindex='2' name="brand" value="${tireInstance?.brand}" />
                                </td>
                            </tr>
                        		<tr class="prop">
                                <td valign="top" class="name"><label for="tireName"><g:message code="tire.tireName.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'tireName', 'errors')}">
                                    <g:textField maxlength="30" tabindex='3' name="tireName" value="${tireInstance?.tireName}" />
                                </td>
                            </tr>
                           	<tr class="prop">
                            	<td valign="top" class="name"><label for="retailPrice"><g:message code="tire.retailPrice.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'retailPrice', 'errors')}">
                                    <g:textField maxlength="30" tabindex='4' name="retailPrice" value="${tireInstance?.retailPrice}" />
                                </td>
                            </tr>
 	                                             	
                        </tbody>
                    </table>
                </div>
              	<div class="tireCreateDialog">
               		<table>
               			<tbody>
                        	<tr class="prop">
                                <td valign="top" class="name"><label for="width"><g:message code="tire.width.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'width', 'errors')}">
                                    <g:textField maxlength="20"  tabindex='5' name="width" value="${fieldValue(bean: tireInstance, field: 'width')}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="profile"><g:message code="tire.profile.label" /></label>
                                </td>
                                <td>
                                	<span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'profile', 'errors')}">
                                    	<g:textField maxlength="20" tabindex='6' name="profile" value="${fieldValue(bean: tireInstance, field: 'profile')}" />
                               	 	</span>
                                	<span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'construction', 'errors')}">
                                    	<g:message code="tire.radial.label" /><g:hiddenField name="construction" value="R" />
                               	 	</span>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><label for="diameter"><g:message code="tire.diameter.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'diameter', 'errors')}">
                                    <g:textField maxlength="20" tabindex='7' name="diameter" value="${fieldValue(bean: tireInstance, field: 'diameter')}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><label for="loadIndex"><g:message code="tire.index.label" /></label></td>
                                <td>
	                                <span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'loadIndex', 'errors')}">
	                                    <g:textField maxlength="20" tabindex='8' name="loadIndex" value="${fieldValue(bean: tireInstance, field: 'loadIndex')}" />
	                                </span>
	                                <span valign="top" class="value ${hasErrors(bean: tireInstance, field: 'speedIndex', 'errors')}">
	                                    <g:select tabindex='9' name="speedIndex" from="${tireInstance.constraints.speedIndex.inList}" value="${tireInstance?.speedIndex}" valueMessagePrefix="tire.speedIndex" />
	                                </span>
	                            </td>
                            </tr>
               
                            <tr class="prop">
                                <td valign="top" class="name"><label for="pattern"><g:message code="tire.pattern.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'pattern', 'errors')}">
                                    <g:textField maxlength="30" tabindex='10' name="pattern" value="${tireInstance?.pattern}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><label for="tireType"><g:message code="tire.tireType.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'tireType', 'errors')}">
                                    <g:select tabindex='11' name="tireType" from="${tireInstance.constraints.tireType.inList}" value="${tireInstance?.tireType}" valueMessagePrefix="tire.tireType" />
                                </td>
                            </tr>
                            <tr class="prop">
	                            <td valign="top" class="name"><label for="numberInStock"><g:message code="tire.numberInStock.createUpdate.label" /></label></td>
	                            <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'numberInStock', 'errors')}">
	                                <g:textField maxlength="30" tabindex='12' name="numberInStock" value="${tireInstance?.numberInStock}" />
								</td>
                       		</tr>
                       
                            <tr class="prop">
                                <td valign="top" class="name"><label for="notice"><g:message code="tire.notice.label" /></label></td>
                                <td valign="top" class="value ${hasErrors(bean: tireInstance, field: 'notice', 'errors')}">
                                    <g:textArea tabindex='13' name="notice" rows="5" cols="10"/>
								</td>
                            </tr>
                            <g:hiddenField name="enabled" value="true" />
                        </tbody>
                    </table>
                </div>
                
                <div class="buttons">
                    <span class="button"><g:submitButton tabindex='14' name="create" class="saveTire" value="${message(code: 'createTire.button.create.label')}" /></span>
                    <span class="button"><a class="cancel" href="javascript:history.back()" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');">${message(code: 'default.button.cancel.label')}</a></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
