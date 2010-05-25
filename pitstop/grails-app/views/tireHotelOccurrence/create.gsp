
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.create.label"/></title>
    </head>
    <body>
		<div class="nav" id="submenuTireHotelOccurence">
			<span class="menuButton" ${(params.action == 'list' || params.action == 'save') ? "id='active'" : ""}  >
	        	<g:link class="tireHotelOccurrenceList" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link>
       		</span>
	        
	        <span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""}  >
	        	<g:link class="createTireHotelOccurrence" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="tireHotelOccurrence.create.header.label" /></h1>
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
                                <g:if test="${no.pstop.webapp.Customer.get(params?.id)}">
 									<td>
                                		${no.pstop.webapp.Customer.get(params?.id)}
                                		<g:hiddenField name="customer_id" value="${params?.id}"/>
                                	</td>
								</g:if>
								<g:else>
									<td class="yui-skin-sam">
										<gui:autoComplete 
											id="customer"
											controller="customer"
											action="customerAutoComplete"
											resultName="customers"
										/>
									</td>
								</g:else>
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
                                
                                <td class="yui-skin-sam">
									<gui:autoComplete 
										id="registrationNumber"
										controller="tireHotelOccurrence"
										action="registrationNumberAutoComplete"
										resultName="registrationNumbers"
										dependsOn="[
											value:'customer',
											label:'customer',
											useId:true
										]"
									/> 
                              	</td>
                              
                                <!-- <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'registrationNumber', 'errors')}">
                                    <g:textField maxlength="21" name="registrationNumber" value="${tireHotelOccurrenceInstance?.registrationNumber}" />
                                </td>-->
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
                               	 	<richui:dateChooser name="inDate" format="dd.MM.yyyy" value="${tireHotelOccurrenceInstance?.inDate}" firstDayOfWeek="Mo" locale="en"/>
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
                
                    <span class="button"><g:submitButton name="create" class="saveTireHotelOccurrence" value="${message(code: 'default.button.create.label')}" /></span>
                    <span class="button"><g:actionSubmit class="cancel" action="list" value="${message(code: 'default.button.cancel.label')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
