
<%@ page import="no.pstop.webapp.TireHotelOccurrence" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tireHotelOccurrence.show.title.label"/></title>
    </head>
    <body>
        <div class="nav">
			<span class="menuButton" ${(params.action == 'list') ? "id='active'" : ""}  >
	        	<g:link class="list" action="list"><g:message code="tireHotelOccurrence.list.label" /></g:link>
       		</span>
	        
	        <span class="menuButton" ${(params.action == 'create') ? "id='active'" : ""}  >
	        	<g:link class="create" action="create"><g:message code="tireHotelOccurrence.create.label" /></g:link>
       		</span>
       		
            <span class="menuButton" ${(tireHotelOccurrenceInstance.id) ? "id='active'" : ""}  >
       			<g:link class="showTireHotelOccurrence" action="show" id="${tireHotelOccurrenceInstance.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")} - ${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</g:link>
       		</span>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
	            <div class="message">${flash.message}</div>
            </g:if>
            <h1><g:message code="tireHotelOccurrence.show.title.label"/></h1>
            
			<div class="dialog" id="tireHotelOccurrenceShowDialog">
            	<div class="tireHotelOccurrenceInfoBox">
            		<span class="tireHotelOccurrenceTitle">
						<h3 class="tireHotelOccurrenceTitle">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}</h3>
					 	- <g:link controller="customer" action="show" id="${tireHotelOccurrenceInstance?.customer?.id}">${fieldValue(bean: tireHotelOccurrenceInstance, field: "customer")}</g:link><br />
					</span>
				 	<span class="carInfo">${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")} ${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}</span>
				 	<span class="tireType">${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}</span>
				 	<span class="inDate">Dato inn: <g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" /></span>
				 	<g:if test="${tireHotelOccurrenceInstance.notice}">
				 		<span class="notice">${fieldValue(bean: tireHotelOccurrenceInstance, field: "notice")}</span>
				 	</g:if>
		            <div class="buttons">
		                <g:form method="post">
		                    <g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
		                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label' )}" /></span>
		                    <span class="button"><g:actionSubmit class="change" action="change" value="${message(code: 'default.button.change.label')}" /></span>
		                    <g:ifAllGranted role="ROLE_ADMIN">
		                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label' )}" onclick="return confirm('${message(code: 'tireHotelOccurrence.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
		                    </g:ifAllGranted>
		                </g:form>
		            </div>
                	<div style="clear:both;"></div>
                </div>
			</div>
        </div>
    </body>
</html>
