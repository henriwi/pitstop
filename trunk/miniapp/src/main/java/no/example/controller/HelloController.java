package no.example.controller;

import java.util.LinkedList;
import java.util.List;

import no.example.domain.Tire;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController {
	
	@RequestMapping("/hello")
	public String doPage()
	{
		return "hello";
	}
	
	@ModelAttribute("tires")
	public List<Tire> getTires()
	{
		List<Tire> list = new LinkedList<Tire>();
		Tire t = new Tire();
		t.setId(1);
		t.setName("pirelli");
		list.add(t);
		return list;
	}
}