package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.RedirectUtils
import org.grails.plugins.springsecurity.service.AuthenticateService
import org.springframework.security.AuthenticationTrustResolverImpl
import org.springframework.security.DisabledException
import org.springframework.security.context.SecurityContextHolder as SCH
import org.springframework.security.ui.AbstractProcessingFilter
import org.springframework.security.ui.webapp.AuthenticationProcessingFilter

class LoginController {

	def authenticateService

	private final authenticationTrustResolver = new AuthenticationTrustResolverImpl()

	def index = {
		if (isLoggedIn()) {
			redirect(uri: '/')
		}
		else {
			redirect(action: "auth", params: params)
		}
	}

	def auth = {
		nocache response

		if (isLoggedIn()) {
			redirect(uri: "/")
			return
		}

		String view
		String postUrl
		def config = authenticateService.securityConfig.security
		
		view = "auth"
		postUrl = "${request.contextPath}${config.filterProcessesUrl}"

		render(view: view, model: [postUrl: postUrl])
	}

	def denied = {
		if (isLoggedIn() && authenticationTrustResolver.isRememberMe(SCH.context?.authentication)) {
			redirect(action: "full", params: params)
		}
	}

	def full = {
		render(view: "auth", params: params,
			model: [hasCookie: authenticationTrustResolver.isRememberMe(SCH.context?.authentication)])
	}

	def authfail = {
		def username = session[AuthenticationProcessingFilter.SPRING_SECURITY_LAST_USERNAME_KEY]
		def msg = ""
		def exception = session[AbstractProcessingFilter.SPRING_SECURITY_LAST_EXCEPTION_KEY]
		if (exception) {
			if (exception instanceof DisabledException) {
				msg = "${message(code: 'login.username.disabled.message')}"
			}
			else {
				msg = "${message(code: 'login.wrong.userinfo.message')}"
			}
		}

		flash.message = msg
		redirect(action: "auth", params: params)
	}

	private boolean isLoggedIn() {
		return authenticateService.isLoggedIn()
	}

	private void nocache(response) {
		response.setHeader('Cache-Control', 'no-cache')
		response.addDateHeader('Expires', 0)
		response.setDateHeader('max-age', 0)
		response.setIntHeader ('Expires', -1)
		response.addHeader('cache-Control', 'private')
	}
}
