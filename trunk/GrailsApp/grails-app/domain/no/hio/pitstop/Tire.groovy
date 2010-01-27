package no.hio.pitstop

class Tire {
	long id
	String name
	static belongsTo = Producer
	
    static constraints = {
		name(blank:false)
    }
}
