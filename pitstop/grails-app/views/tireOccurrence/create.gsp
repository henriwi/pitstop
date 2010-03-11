
<%@ page import="no.pstop.webapp.TireOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="createTireOccurrence.title.label" /></title>
    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link controller = "tire" class="list" action="list"><g:message code="default.button.tireList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="create" action="create"><g:message code="default.button.newTire.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="list" controller="tireOccurrence" action="list"><g:message code="default.button.tireOccurrenceList.label"/></g:link></span>
		    <span class="menuButton"><g:link controller = "tire" class="search" action="search"><g:message code="default.button.search.label"/></g:link></span>       
        </div>
        <div class="body">
            <h1><g:message code="createTireOccurrence.title.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tireOccurrenceInstance}">
            <div class="errors">
                <g:renderErrors bean="${tireOccurrenceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tire"><g:message code="tireOccurrence.tire.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'tire', 'errors')}">
                                    <g:select name="tire.id" from="${no.pstop.webapp.Tire.list()}" optionKey="id" value="${params.id}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberInStock"><g:message code="tireOccurrence.numberInStock.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'numberInStock', 'errors')}">
                                    <g:textField name="numberInStock" value="${fieldValue(bean: tireOccurrenceInstance, field: 'numberInStock')}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="price"><g:message code="tireOccurrence.price.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'price', 'errors')}">
                                    <g:textField name="price" value="${fieldValue(bean: tireOccurrenceInstance, field: 'price')}" />
                                </td>
                            </tr>       
                           	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="discount"><g:message code="tireOccurrence.discount.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'discount', 'errors')}">
                                    <g:textField name="discount" value="${fieldValue(bean: tireOccurrenceInstance, field: 'discount')}" />
                                </td>
                            </tr>    
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="environmentalFee"><g:message code="tireOccurrence.environmentalFee.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'environmentalFee', 'errors')}">
                                    <g:textField name="environmentalFee" value="${fieldValue(bean: tireOccurrenceInstance, field: 'environmentalFee')}" />
                                </td>
                            </tr>                                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="registrationDate"><g:message code="tireOccurrence.registrationDate.label"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tireOccurrenceInstance, field: 'registrationDate', 'errors')}">
									<g:datePicker name="registrationDate" precision="day" years="${2010..2030}" value="${tireOccurrenceInstance?.registrationDate}" />
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
