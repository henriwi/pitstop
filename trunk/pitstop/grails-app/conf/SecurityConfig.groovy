security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true

	loginUserDomainClass = "no.pstop.webapp.User"
	authorityDomainClass = "no.pstop.webapp.Role"
	useRequestMapDomainClass = false
	useControllerAnnotations = true
	errorPage = null
}
