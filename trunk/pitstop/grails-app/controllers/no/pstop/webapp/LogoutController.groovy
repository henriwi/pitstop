package no.pstop.webapp

class LogoutController {

	def index = {
		redirect(uri: '/j_spring_security_logout')
	}
}
