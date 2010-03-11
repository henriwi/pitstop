
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.show.title.label" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="customer.list.label" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="customer.show.title.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog" id="customerShowDialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.firstName.label" default="First Name" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "firstName")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.lastName.label" default="Last Name" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "lastName")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.phoneNumber.label" default="Phone Number" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "phoneNumber")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.address.label" default="Address" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "address")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.postalCode.label" default="Postal Code" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "postalCode")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.city.label" default="City" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "city")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.email.label" default="Email" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "email")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.company.label" default="Company" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "company")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="customer.notice.label" default="Notice" /></td>
                            <td valign="top" class="value">${fieldValue(bean: customerInstance, field: "notice")}</td>
                        </tr>
                    </tbody>
                </table>
                <div class="buttons">
	                <g:form>
	                    <g:hiddenField name="id" value="${customerInstance?.id}" />
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
	                    <br /><br />
	                    <span class="button"><a href="mailto:${customerInstance.email}" target="_blank">Send e-post til kunde</a></span>
	                    
	                    
	                    
	                </g:form>
	            </div>
            </div>
            <div class="tireHotelOccurrencelist">
               <table>
                   <thead>
                       <tr>
                           <g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label')}" />
                       
                           <g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label')}" />
                       
                           <g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label')}" />
                       
                           <g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label')}" />
                       
                           <g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label')}" />
                           
                           <g:sortableColumn property="outDate" title="${message(code: 'tireHotelOccurrence.list.outDate.label')}" />
                           
                       </tr>
                   </thead>
                   <tbody>
	                   <g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
	                       <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	                       
	                           <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</g:link></td>
	                       
	                           <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</g:link></td>
	                       
	                           <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")}</g:link></td>
	                       
	                           <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</g:link></td>
	                       
	                           <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></g:link></td>
	                           
	                           <td><g:link action="show" controller="tireHotelOccurrence" id="${tireHotelOccurrenceInstance.id}"><g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.outDate}" /></g:link></td>
	                       </tr>
	                   </g:each>
                   </tbody>
               </table>
               <div class="paginateButtons" id="showCustomer">
	          		<g:paginate next="Neste" prev="Forrige" controller="customer" action="show" id="${customerInstance.id}" total="${tireHotelOccurrenceInstanceTotalList.size()}"></g:paginate>
	        	</div>
			</div>
        </div>
    </body>
</html>