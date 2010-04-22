package no.pstop.webapp

import java.util.Date;

class LogService {

    boolean transactional = true

    def saveLog(session, event) {
		def user = User.findByUsername(session.SPRING_SECURITY_CONTEXT.authentication.principal.username)
    	def logInstance = new Log(user: user, date: new Date(), event: event)
		logInstance.save(flush: true)
    }
}
