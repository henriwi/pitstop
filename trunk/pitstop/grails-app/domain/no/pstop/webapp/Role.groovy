package no.pstop.webapp

import no.pstop.webapp.User

class Role {
	static hasMany = [people: User]
	                  
	String description
	String authority

	static constraints = {
		authority(blank: false, unique: true)
	}
}
