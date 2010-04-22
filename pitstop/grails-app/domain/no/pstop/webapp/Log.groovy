package no.pstop.webapp

import java.util.Date;

class Log {
	
	static belongsTo = [user: User]
	Date date
	String event
	
    static constraints = {
		user(blank: false)
		date(blank: false)
		event(blank: false)
    }
}
