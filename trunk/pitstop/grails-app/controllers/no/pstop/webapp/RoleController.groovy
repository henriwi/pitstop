package no.pstop.webapp

import no.pstop.webapp.Role

class RoleController {

	static Map allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

	def authenticateService

	def index = {
		redirect action: list, params: params
	}

	def list = {
		if (!params.max) {
			params.max = 10
		}
		[authorityList: Role.list(params)]
	}

	def show = {
		def authority = Role.get(params.id)
		if (!authority) {
			flash.message = "${message(code: 'role.not.found.message', args: [message(code: 'role.label'), params.id])}"
			redirect action: list
			return
		}

		[authority: authority]
	}

	def delete = {
		def authority = Role.get(params.id)
		if (!authority) {
			flash.message = "${message(code: 'role.not.found.message', args: [message(code: 'role.label'), params.id])}"
			redirect action: list
			return
		}

		authenticateService.deleteRole(authority)
		flash.message = "${message(code: 'role.deleted.message', args: [message(code: 'role.label'), params.id])}"
		redirect action: list
	}

	def edit = {
		def authority = Role.get(params.id)
		if (!authority) {
			flash.message = "${message(code: 'role.not.found.message', args: [message(code: 'role.label'), params.id])}"
			redirect action: list
			return
		}

		[authority: authority]
	}

	def update = {

		def authority = Role.get(params.id)
		if (!authority) {
			flash.message = "${message(code: 'role.not.found.message', args: [message(code: 'role.label'), params.id])}"
			redirect action: edit, id: params.id
			return
		}

		long version = params.version.toLong()
		if (authority.version > version) {
			authority.errors.rejectValue 'version', 'authority.optimistic.locking.failure',
				'Another user has updated this Role while you were editing.'
			render view: 'edit', model: [authority: authority]
			return
		}

		if (authenticateService.updateRole(authority, params)) {
			authenticateService.clearCachedRequestmaps()
			redirect action: show, id: authority.id
		}
		else {
			render view: 'edit', model: [authority: authority]
		}
	}

	def create = {
		[authority: new Role()]
	}

	def save = {

		def authority = new Role()
		authority.properties = params
		if (authority.save()) {
			redirect action: show, id: authority.id
		}
		else {
			render view: 'create', model: [authority: authority]
		}
	}
}
