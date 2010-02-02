import no.pstop.webapp.Tire;

class BootStrap {

     def init = { servletContext ->
			new Tire(id: 1, partNr: "abc123", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer").save()
			new Tire(id: 2, partNr: "cdf456", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Vinter (pigg)").save()
			new Tire(id: 3, partNr: "ghi789", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer").save()
			new Tire(id: 4, partNr: "jkl101", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Vinter (pigg)").save()	
     }
     def destroy = {
     }
} 