package no.example.controller.test;

import static org.junit.Assert.*;
import no.example.controller.HelloController;

import org.junit.Test;

public class HelloControllerTest {
	@Test
	public void doPageTest()
	{
		HelloController hc = new HelloController();
		assertEquals("Hello", hc.doPage());
	}
}
