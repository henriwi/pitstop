
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.create.label"/></title>
		<gui:resources components="autoComplete" />
    </head>
    <body>
        <div class="nav">
            <g:if test="${params.action == 'list'}">
        		<span class="menuButton" id="active" >
        			<g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link>
        		</span>
	        </g:else>
	        
	        <g:if test="${params.action == 'create'}">
        		<span class="menuButton" id="active" >
        			<g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link>
        		</span>
        	</g:if>
	        <g:else>
	        	<span class="menuButton">
        			<g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link>
        		</span>
	        </g:else>
        </div>
        <div class="body">
            <h1><g:message code="tireHotelOccurrence.create.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tireHotelOccurrenceInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireHotelOccurrenceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                	<label for="customer"><g:message code="tireHotelOccurrence.customer.label" /></label>
                                </td>
                                <td>
                                	${no.pstop.webapp.Customer.get(params?.id)}
                                	<g:hiddenField name="customerId" value="${params?.id}"/>
                                </td>
                             <%--  <td class="yui-skin-sam">
								<gui:autoComplete 
											id="addCustomerAutoComplete" 
											controller="customer"
											action="customerAutoComplete"
											resultName="customers"/> 
								<!--  attributt til autoComplete options="${['Jon Torstein', 'Trygve Hegnar', 'Jens Stoltenberg']}" -->
                              </td> --%>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireLocation"><g:message code="tireHotelOccurrence.tireLocation.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'tireLocation', 'errors')}">
                                    <g:textField maxlength="21" name="tireLocation" value="${tireHotelOccurrenceInstance?.tireLocation}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="registrationNumber"><g:message code="tireHotelOccurrence.registrationNumber.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'registrationNumber', 'errors')}">
                                    <g:textField maxlength="21" name="registrationNumber" value="${tireHotelOccurrenceInstance?.registrationNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="carType"><g:message code="tireHotelOccurrence.carType.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'carType', 'errors')}">
                                    <g:textField maxlength="30" name="carType" value="${tireHotelOccurrenceInstance?.carType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tireType"><g:message code="tireHotelOccurrence.tireType.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'tireType', 'errors')}">
                                    <g:select name="tireType" from="${tireHotelOccurrenceInstance.constraints.tireType.inList}" value="${tireHotelOccurrenceInstance?.tireType}" valueMessagePrefix="tireHotelOccurrenceInstance.tireType" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inDate"><g:message code="tireHotelOccurrence.inDate.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'inDate', 'errors')}">
									<g:datePicker name="inDate" precision="day" years="${2010..2030}" value="${tireHotelOccurrenceInstance?.inDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="notice"><g:message code="tireHotelOccurrence.notice.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'notice', 'errors')}">
                                    <g:textArea name="notice" cols="40" rows="5" value="${tireHotelOccurrenceInstance?.notice}" />
                                </td>
                            </tr>
                                             
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                	<!-- <g:submitToRemote onSuccess="Modalbox.hide()" class="save" action="save" value="Lagre" update="[success:'message',failure:'errors']"/>-->
                
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label')}" /></span>
                    <span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'default.button.cancel.label')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
