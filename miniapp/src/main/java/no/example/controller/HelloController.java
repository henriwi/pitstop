package no.example.controller;

import java.util.List;
import no.example.domain.Tire;
import no.example.repo.TireRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {

	private TireRepo tireRepo;

	@Autowired
	public void setTierRepo(TireRepo tireRepo) {
		this.tireRepo = tireRepo;
	}

	@RequestMapping("/hello")
	public String doPage() {
		return "hello";
	}

	@ModelAttribute("tires")
	public List<Tire> getTires() {
		return tireRepo.getTires();
	}
}