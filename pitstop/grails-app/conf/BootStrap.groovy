import no.pstop.webapp.Tire;
import no.pstop.webapp.TireOccurrence;

class BootStrap {

     def init = { servletContext ->
			def t1 = new Tire(id: 1, partNr: "abc123", brand: "Pirelli", tireName: "T-Zero", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer").save()
			def t2 = new Tire(id: 2, partNr: "cdf456", brand: "Pirelli", tireName: "T-Zero", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Vinter (pigg)").save()
			new Tire(id: 3, partNr: "ghi789", brand: "Pirelli", tireName: "T-Zero", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Sommer").save()
			new Tire(id: 4, partNr: "jkl101", brand: "Pirelli", tireName: "T-Zero", width: 100, profile: 20, construction: "R", diameter: 10,
					loadIndex: 40, speedIndex: "L", pattern: "Speed beast", tireType: "Vinter (pigg)").save()
			
			new TireOccurrence(tire: t1, price: 1500, numberInStock: 4, registrationDate: new Date()).save()
			new TireOccurrence(tire: t1, price: 1600, numberInStock: 4, registrationDate: new Date()).save()
			new TireOccurrence(tire: t1, price: 1200, numberInStock: 4, registrationDate: new Date()).save()
			new TireOccurrence(tire: t2, price: 2000, numberInStock: 4, registrationDate: new Date()).save()
			
			
     }
     def destroy = {
     }
} 