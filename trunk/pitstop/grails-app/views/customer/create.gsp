
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.create.title.label"/></title>
        <g:javascript library="prototype" />
    </head>
    <body>
        <div class="nav">
        	<g:if test="${params.action == 'list'}">
        		<span class="menuButton" id="active" >
        			<g:link class="list" action="list"><g:message code="customer.list.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="list" action="list"><g:message code="customer.list.label" /></g:link>
        		</span>
	        </g:else>
	        
	        <g:if test="${params.action == 'create'}">
        		<span class="menuButton" id="active" >
        			<g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link>
        		</span>
	        </g:else>
        </div>
        <div class="body">
            <h1><g:message code="customer.create.header.label" /></h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${customerInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${customerInstance}" as="list" />
	            </div>
            </g:hasErrors>
            
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="customer.firstName.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'firstName', 'errors')}">
                                    <g:textField maxlength="40" name="firstName" value="${customerInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="customer.lastName.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'lastName', 'errors')}">
                                    <g:textField maxlength="40" name="lastName" value="${customerInstance?.lastName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="phoneNumber"><g:message code="customer.phoneNumber.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'phoneNumber', 'errors')}">
                                    <g:textField maxlength="30" name="phoneNumber" value="${customerInstance?.phoneNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address"><g:message code="customer.address.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'address', 'errors')}">
                                    <g:textField maxlength="50" name="address" value="${customerInstance?.address}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="postalCode"><g:message code="customer.postalCode.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'postalCode', 'errors')}">
                                    <g:remoteField action="getPlace" maxlength="4" name="postalCode" update="place" />
                                	
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><g:message code="customer.city.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'city', 'errors')}">
                                  <label  id="place"></label>
                                   <%-- <g:textField maxlength="40" name="city" value="${customerInstance?.city}" />
                                --%> </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="customer.email.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${customerInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="company"><g:message code="customer.company.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'company', 'errors')}">
                                    <g:textField maxlength="50" name="company" value="${customerInstance?.company}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="notice"><g:message code="customer.notice.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'notice', 'errors')}">
                                    <g:textArea name="notice" cols="40" rows="5" value="${customerInstance?.notice}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label')}" /></span>
                    <span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'default.button.cancel.label')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
