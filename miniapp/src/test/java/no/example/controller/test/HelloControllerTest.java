package no.example.controller.test;

import static org.junit.Assert.*;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import no.example.controller.HelloController;
import no.example.domain.Tire;

import org.junit.Before;
import org.junit.Test;

public class HelloControllerTest {
	
	private HelloController helloController;

	@Before
	public void setup()
	{
		helloController = new HelloController();
	}
	@Test
	public void doPageTest()
	{
		assertEquals("hello", helloController.doPage());
	}
	
	@Test
	public void getTiresTest()
	{
		List<Tire> list = new LinkedList<Tire>();
		Tire t = new Tire();
		t.setId(1);
		t.setName("pirelli");
		list.add(t);
		
		assertEquals(list.get(0).getId(), helloController.getTires().get(0).getId());
		assertEquals(list.get(0).getName(), helloController.getTires().get(0).getName());
	}
}
