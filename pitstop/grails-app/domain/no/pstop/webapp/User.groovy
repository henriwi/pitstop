package no.pstop.webapp

import no.pstop.webapp.Role

class User {
	static transients = ['pass']
	static hasMany = [authorities: Role, logs: Log]
	static belongsTo = Role

	String username
	String userRealName
	String passwd
	boolean enabled
	String email
	String description = ''
	String pass = '[secret]'

	static constraints = {
		username(blank: false, unique: true)
		userRealName(blank: false)
		passwd(blank: false)
		email(email: true)
	}
	
	String enabledLabel(){
		(enabled) ? "Ja" : "Nei"
	}
	
	String toString() {
		userRealName
	}
}
