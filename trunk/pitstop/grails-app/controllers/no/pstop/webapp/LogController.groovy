package no.pstop.webapp

class LogController {
	
	def maxNumberOfLogs = 50
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		/*if(!params.sort) {
			params.sort = "date"
			params.order = "desc"
		}*/
		
        params.max = Math.min(params.max ? params.int('max') : maxNumberOfLogs, 100)
        [logInstanceList: Log.list(params), logInstanceTotal: Log.count()]
    }

    def delete = {
        def logInstance = Log.get(params.id)
        if (logInstance) {
            try {
                logInstance.delete(flush: true)
                flash.message = "${message(code: 'log.deleted.message')}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'log.not.deleted.message')}"
                redirect(action: "list")
            }
        }
        else {
            flash.message = "${message(code: 'log.not.found.message')}"
            redirect(action: "list")
        }
    }
}
