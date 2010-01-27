import no.hio.pitstop.Tire;

class BootStrap {

     def init = { servletContext ->
		new Tire(name:"Pirelli").save()
		new Tire(name:"Michelin").save()
     }
     def destroy = {
     }
} 