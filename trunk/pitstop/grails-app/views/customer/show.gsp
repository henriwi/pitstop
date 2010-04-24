
<%@ page import="no.pstop.webapp.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="customer.show.title.label" /></title>
        <gui:resources components="accordion, dataTable"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="customer.list.label" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="customer.create.title.label" /></g:link></span>
        </div>
        <div class="body">
            <span class="backButton"><g:link class="back" controller="customer"><g:message code="customer.show.button.back.label" /></g:link></span>
            <h1><g:message code="customer.show.title.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog" id="customerShowDialog">
            	<div class="customerInfoBox">
					<h3 class="customerName">${fieldValue(bean: customerInstance, field: "firstName")} ${fieldValue(bean: customerInstance, field: "lastName")}</h3>
					<g:if test="${customerInstance.address}">
						<span class="customerAddress">${fieldValue(bean: customerInstance, field: "address")}</span>
					</g:if>
					<g:if test="${customerInstance.postalCodeAndPlace.postalCode}">
						<span class="customerPostalCodeAndPlace">${customerInstance?.postalCodeAndPlace?.postalCode} ${customerInstance?.postalCodeAndPlace?.place}</span>
					</g:if>
					<g:if test="${customerInstance.company}">
						<span class="customerCompany">${fieldValue(bean: customerInstance, field: "company")}</span>
					</g:if>
					
					<g:if test="${customerInstance.phoneNumber}">
						<span class="customerPhoneNumber">
							${fieldValue(bean: customerInstance, field: "phoneNumber")}
							<modalbox:createLink id="${customerInstance.id}" controller="customer" action="showSmsView" title="Send SMS" width="350" overlayDuration="0" slideDownDuration="0" resizeDuration="0">Send SMS</modalbox:createLink>
						</span>
                    </g:if>
                    <g:if test="${customerInstance.email}">
						<span class="customerEmail">
							${fieldValue(bean: customerInstance, field: "email")}
                    		<a href="mailto:${customerInstance.email}" target="_blank">Send e-post</a>
                    	</span>
		            </g:if>
	                
	                <g:if test="${customerInstance.notice}">
						<span class="customerNotice" >${fieldValue(bean: customerInstance, field: "notice")}</span>
					</g:if>
                </div>
                
                <div class="buttons">
	                <g:form>
	                    <g:hiddenField name="id" value="${customerInstance?.id}" />
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
	                    
	                    <g:ifAllGranted role="ROLE_ADMIN">
	                    	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'customer.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
	                    </g:ifAllGranted>
	                    
	            	</g:form>
	        	</div>
			</div>
			
			<div id="customerTireHotelAndOrders">
				<span>
					Liste <input type="radio" name="tireHotelOccurrences" checked="checked" value="tireHotelOccurenceList" onfocus="javascript:hideAndShowElement('onlyActiveTireHotelOccurrences','allTireHotelOccurrences');" /> 
					Tabell <input type="radio" name="tireHotelOccurrences" value="tireHotelOccurenceTable" onfocus="javascript:hideAndShowElement('allTireHotelOccurrences','onlyActiveTireHotelOccurrences');" />
				</span>
				<g:if test="${tireHotelOccurrenceInstanceList}">
					<g:each in="${tireHotelOccurrenceInstanceList}" status="i" var="tireHotelOccurrenceInstance">
						<div class="customerTireHotelOccurrencelist" id="onlyActiveTireHotelOccurrences">
							
							<div class="tireInfo">
								<h4>
									${fieldValue(bean: tireHotelOccurrenceInstance, field: "carType")} - 
									${fieldValue(bean: tireHotelOccurrenceInstance, field: "registrationNumber")}
								</h4>
								Lagerlokasjon: ${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireLocation")}<br />
								${fieldValue(bean: tireHotelOccurrenceInstance, field: "tireType")}<br />
								Inndato: <g:formatDate format="dd.MM.yyyy" date="${tireHotelOccurrenceInstance.inDate}" />
							</div>
							<div class="tireHotelButtons">
	                       		<g:form controller="tireHotelOccurrence" method="post">
	                        		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
	                         		<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
									<g:hiddenField name="delivered" value="delivered" />
	                         		<g:actionSubmit class="delivered" title="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" action="deliverTireHotelOccurenceFromCustomerView" value="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
	                   			</g:form>
	                        	
	                       		<g:if test="${!tireHotelOccurrenceInstance.outDate}">
	                        		<g:form controller="tireHotelOccurrence" method="post">
	                        			<g:hiddenField name="customerId" value="${customerInstance?.id}" />
	                        			<g:hiddenField name="requestFromShowCustomerView" value="true" />
	                        			<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
	                        			<g:actionSubmit class="change" action="change" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" />
	                        		</g:form>
	                       		</g:if>
				                
				                <g:ifAllGranted role="ROLE_ADMIN">
	                         		<g:form controller="tireHotelOccurrence" method="post">
	                         			<g:hiddenField name="customerId" value="${customerInstance?.id}" />
	                        			<g:hiddenField name="requestFromShowCustomerView" value="true" />
	                         			<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
	                         		</g:form>
	                   			</g:ifAllGranted>
	                   		</div>
	                   		<div style="clear: both;"></div>
						</div>
					</g:each>
				</g:if>
			
				<g:if test="${tireHotelOccurrenceInstanceList}">
		            <div class="customerTireHotelOccurrencelist" id="allTireHotelOccurrences">
		               	<table>
		                   	<thead>
		                       	<tr>
		                           	<g:sortableColumn property="tireLocation" title="${message(code: 'tireHotelOccurrence.list.tireLocation.label')}" />
		                       
		                           	<g:sortableColumn property="registrationNumber" title="${message(code: 'tireHotelOccurrence.list.registrationNumber.label')}" />
		                       
		                           	<g:sortableColumn property="carType" title="${message(code: 'tireHotelOccurrence.list.carType.label')}" />
		                       
		                           	<g:sortableColumn property="tireType" title="${message(code: 'tireHotelOccurrence.list.tireType.label')}" />
		                       
		                           	<g:sortableColumn property="inDate" title="${message(code: 'tireHotelOccurrence.list.inDate.label')}" />
		                           
		                        	<g:sortableColumn property="outDate" title="${message(code: 'tireHotelOccurrence.list.outDate.label')}" />
		                        		
		                        	<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delivered.label')}</a></th>
                            		
                            		<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.change.label')}</a></th>
                            		
                            	<g:ifAllGranted role="ROLE_ADMIN">
                            		<th><a class="notSortableColoumn">${message(code: 'tireHotelOccurrence.list.delete.label')}</a></th>
                            	</g:ifAllGranted>
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
		                        		
		                        		<td>
	                            			<g:if test="${!tireHotelOccurrenceInstance.outDate}">
				                        		<g:form controller="tireHotelOccurrence" method="post">
					                        		<g:hiddenField name="customerId" value="${customerInstance?.id}" />
		                            				<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
													<g:hiddenField name="delivered" value="delivered" />
		                            				<g:actionSubmit class="delivered" title="${message(code: 'tireHotelOccurrence.list.delivered.tooltip.label')}" action="deliverTireHotelOccurenceFromCustomerView" value="${message(code: 'tireHotelOccurrence.list.delivered.button')}" onclick="return confirm('${message(code: 'list.delivered.button.confirm.message')}');" />
		                            			</g:form>
	                            			</g:if>
                            			</td>
                            			
                            			<td>
                            				<g:if test="${!tireHotelOccurrenceInstance.outDate}">
	                            				<g:form controller="tireHotelOccurrence" method="post">
	                            					<g:hiddenField name="customerId" value="${customerInstance?.id}" />
	                            					<g:hiddenField name="requestFromShowCustomerView" value="true" />
	                            					<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
	                            					<g:actionSubmit class="change" action="change" title="${message(code: 'tireHotelOccurrence.list.change.tooltip.label')}" value="${message(code: 'tireHotelOccurrence.list.change.button')}" />
	                            				</g:form>
                            				</g:if>
                            			</td>
                            			
     			                      	<g:ifAllGranted role="ROLE_ADMIN">
		                            		<td>
		                            			<g:form controller="tireHotelOccurrence" method="post">
		                            				<g:hiddenField name="customerId" value="${customerInstance?.id}" />
	                            					<g:hiddenField name="requestFromShowCustomerView" value="true" />
		                            				<g:hiddenField name="id" value="${tireHotelOccurrenceInstance?.id}" />
		                            				<g:actionSubmit class="deleteTableItem" title="${message(code: 'tireHotelOccurrence.list.delete.tooltip.label')}" action="delete" value="${message(code: 'list.button.delete.label')}" onclick="return confirm('${message(code: 'tireHotelOccurrence.button.delete.confirm.message')}');" />
		                            			</g:form>
		                            		</td>
                        				</g:ifAllGranted>
			                    	</tr>
			                	</g:each>
		                	</tbody>
		               	</table>
						<div class="paginateButtons" id="showCustomer">
			          		<g:paginate next="Neste" prev="Forrige" controller="customer" action="show" id="${customerInstance.id}" total="${tireHotelOccurrenceInstanceTotalList.size()}"></g:paginate>
			        	</div>
					</div>
				</g:if>
				<g:if test="${customerOrders}">
					<div class="customerOrders">
		                   	<div>
		                   	<gui:dataTable
									    id="dt_2"
									    columnDefs="[
									        [key:'id', sortable:true, label:'Ordrenummer'],
									        [key:'orderDate', type:'date', sortable:true, label: 'Ordredato'],
									        [key:'delivered', expanded: 'true',type:'link', sortable:true, label: 'Utlever'],
									    ]"
									    controller="customer" action="customerOrdersAsJSON"
									    resultsList="results"
									    params="[id:customerInstance.id]"
									    rowExpansion="true"
									    rowsPerPage="10"
									/>
									
							        <script type="text/javascript">
										YAHOO.util.Event.onDOMReady(function() {
											GRAILSUI.dt_2.on('cellClickEvent',function (oArgs) {
												// 'this' is already referring to the DataTable
												var target = oArgs.target;
												var record = this.getRecord(target);
												var column = this.getColumn(target);
												if (column.key != 'id') {
													return false;
												}
												return true;
											});
										});
						        	</script>
		                   	</div>
					</div>
				</g:if>
			</div>
        </div>
    </body>
</html>
