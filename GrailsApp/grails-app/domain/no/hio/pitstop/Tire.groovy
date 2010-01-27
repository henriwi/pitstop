package no.hio.pitstop

class Tire {
	long id
	String name
	int number
	static belongsTo = Producer
	
    static constraints = {
		name(blank:false)
		number(min:20, max:100)
    }
}
