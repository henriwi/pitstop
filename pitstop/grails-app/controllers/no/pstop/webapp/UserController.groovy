package no.pstop.webapp

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

import no.pstop.webapp.User
import no.pstop.webapp.Role

class UserController {

	def authenticateService
	static final maxNumberOfLogs = 3
	static Map allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		if (!params.max) {
			params.max = 10
		}
		[personList: User.list(params)]
	}

	def show = {
		def person = User.get(params.id)
		if (!person) {
			flash.message = "${message(code: 'user.not.found.message', args: [message(code: 'user.label'), params.id])}"
			redirect(action: "list")
			return
		}
		List roleNames = []
		for (role in person.authorities) {
			roleNames << role
		}
		
		if (!params.max)
			params.max = maxNumberOfLogs
		if (!params.offset)
			params.offset = 0
		
		def logList = Log.findAllByUser(person, [max: params.max, offset: params.offset])
		def logTotalList = Log.findAllByUser(person)
		[person: person, roleNames: roleNames, logInstanceList: logList, logTotalList: logTotalList]
	}

	def delete = {
		def person = User.get(params.id)
		if (person) {
			def authPrincipal = authenticateService.principal()
			if (!(authPrincipal instanceof String) && authPrincipal.username == person.username) {
				flash.message = "${message(code: 'user.delete.self.message')}"
			}
			else {
				Role.findAll().each { it.removeFromPeople(person) }
				person.delete()
				flash.message = "${message(code: 'user.deleted.message', args: [message(code: 'user.label'), person.username])}"
			}
		}
		else {
			flash.message = "${message(code: 'user.not.found.message', args: [message(code: 'user.label'), params.id])}"
		}
		redirect(action: "list")
	}

	def edit = {
		def person = User.get(params.id)
		if (!person) {
			flash.message = "${message(code: 'user.not.found.message', args: [message(code: 'user.label'), params.id])}"
			redirect(action: "list")
			return
		}
		return buildPersonModel(person)
	}

	def update = {
		def person = User.get(params.id)
		if (!person) {
			flash.message = "${message(code: 'user.not.found.message', args: [message(code: 'user.label'), params.id])}"
			redirect(action: "edit", id: params.id)
			return
		}

		def oldPassword = person.passwd
		person.properties = params
		if (!params.passwd.equals(oldPassword)) {
			person.passwd = authenticateService.encodePassword(params.passwd)
		}
		if (person.save()) {
			Role.findAll().each { it.removeFromPeople(person) }
			addRoles(person)
			redirect(action: "show", id: person.id)
		}
		else {
			render(view: "edit", model: buildPersonModel(person))
		}
	}

	//@Secured(['ROLE_ADMIN'])
	def create = {
		[person: new User(params), authorityList: Role.list()]
	}

	def save = {
		def person = new User()
		person.properties = params
		person.passwd = authenticateService.encodePassword(params.passwd)
		if (person.save()) {
			addRoles(person)
			redirect(action: "show", id: person.id)
		}
		else {
			render(view: 'create', model: [authorityList: Role.list(), person: person])
		}
	}

	private void addRoles(person) {
		for (String key in params.keySet()) {
			if (key.contains('ROLE') && 'on' == params.get(key)) {
				Role.findByAuthority(key).addToPeople(person)
			}
		}
	}

	private Map buildPersonModel(person) {
		List roles = Role.list()
		roles.sort { r1, r2 ->
			r1.authority <=> r2.authority
		}
		Set userRoleNames = []
		for (role in person.authorities) {
			userRoleNames << role.authority
		}
		LinkedHashMap<Role, Boolean> roleMap = [:]
		for (role in roles) {
			roleMap[(role)] = userRoleNames.contains(role.authority)
		}

		return [person: person, roleMap: roleMap]
	}
	
	def disableAndEnable = {
		def person = User.get(params.id)
		person.enabled = person.enabled ? false : true 
		redirect(action: "list")
	}
	
	def updateLog = {
		def userInstance = User.get(params.id)
		def logInstanceList = Log.findAllByUser(userInstance, [max: params.max, offset: params.offset, 
		sort: params.sort, order: params.order])
		def logTotalList = Log.findAllByUser(userInstance)
		
		render(template: "log", model: [userInstance: userInstance, logInstanceList: logInstanceList,
		logTotalList: logTotalList])
	}
	
	def deleteLog = {
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
