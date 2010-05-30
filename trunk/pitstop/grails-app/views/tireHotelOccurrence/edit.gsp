
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.edit.title.label" /></title>
        <resource:dateChooser />
    </head>
    <body>
        <div class="nav">
			<span class="menuButton" ${(params.action == 'list' || params.action == 'save') ? "id='active'" : ""}  >
	        	<g:link class="tireHotelOccurrenceList" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link>
       		</span>
	        
	        <span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""}  >
	        	<g:link class="createTireHotelOccurrence" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link>
       		</span>
       		
            <span class="menuButton" ${(tireHotelOccurrenceInstance.id) ? "id='active'" : ""}  >
       			<g:link class="showTireHotelOccurrence" action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")} - ${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
	            <div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="tireHotelOccurrence.edit.title.label" /></h1>
            <g:hasErrors bean="${tireHotelOccurrenceInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${tireHotelOccurrenceInstance}" as="list" />
	            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
                <g:hiddenField name="version" value="${tireHotelOccurrenceInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        	
                        	<tr class="prop">
                                <td valign="top" class="name">
                                	<label for="customer"><g:message code="tireHotelOccurrence.customer.label" /></label>
                                </td>
                                <td>
                             		${no.pstop.webapp.Customer.get(tireHotelOccurrenceInstance?.customer?.id)}
                             		<g:hiddenField name="customer_id" value="${tireHotelOccurrenceInstance?.customer?.id}"/>
                                </td>
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
                                    <g:select name="tireType" from="${tireHotelOccurrenceInstance.constraints.tireType.inList}" value="${tireHotelOccurrenceInstance?.tireType}" valueMessagePrefix="tireHotelOccurrence.tireType" />
                                </td>
                            </tr>
                            
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                	<label for="inDate"><g:message code="tireHotelOccurrence.inDate.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireHotelOccurrenceInstance, field: 'inDate', 'errors')}">
                               		<richui:dateChooser name="inDate" format="dd.MM.yyyy" value="${tireHotelOccurrenceInstance?.inDate}" firstDayOfWeek="Mo" locale="en"/>
                                    <!--  <g:datePicker name="inDate" precision="day" value="${tireHotelOccurrenceInstance?.inDate}"  /> -->
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
                    <span class="button"><g:actionSubmit class="saveTireHotelOccurrence" action="update" value="${message(code: 'default.button.update.label')}" /></span>
                    <span class="button"><a class="cancel" href="javascript:history.back()" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message')}');">${message(code: 'default.button.cancel.label')}</a></span>
                    <g:ifAllGranted role="ROLE_ADMIN">
                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');" /></span>
                    </g:ifAllGranted>
                </div>
            </g:form>
        </div>
    </body>
</html>
