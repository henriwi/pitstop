package no.bekk.camel;

import org.apache.camel.Produce;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.EndpointInject;
import org.apache.camel.component.mock.MockEndpoint;
import org.junit.runner.RunWith;
import org.junit.Test;
import org.junit.Before;
import org.springframework.test.context.ContextConfiguration;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.Matchers.eq;
import static org.mockito.Matchers.any;

import no.bekk.repo.FagdagRepo;
import no.bekk.domain.FagdagLog;
import no.bekk.normalizer.FagdagNormalizer;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * Copyright Eirik L. Wang 2009
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"/context/testContext.xml"})
public class FagdagRouteBuilderTest {

    @Produce(uri = "direct:firstEndpoint")
    protected ProducerTemplate firstTemplate;

    @Produce(uri = "direct:secondEndpoint")
    protected ProducerTemplate secondTemplate;
    
    @EndpointInject(uri = "mock:notifier")
    protected MockEndpoint notifierEndpoint;

    private String aLine = "A;1312;Apache Camel Rocks";
    private String bLine = "D;1312;";

    //Leif wasn't here!
    //Mocked in xml
    @Resource(name = "repository")
    private FagdagRepo fagdagRepo;
    @Resource(name = "normalizer")
    private FagdagNormalizer normalizer;

    @Before
    public void reset() {
        notifierEndpoint.reset();
    }

    @Test
    public void shouldSendAMessageToNormalizer() throws InterruptedException {
        when(normalizer.fromTxtToLog(eq(aLine))).thenReturn(new FagdagLog());
        when(fagdagRepo.update(any(FagdagLog.class))).thenReturn(new FagdagLog());
        firstTemplate.sendBody(aLine);
        verify(normalizer).fromTxtToLog(eq(aLine));
    }

    @Test
    public void shouldUpdateDatabaseOnALine() throws InterruptedException {
        FagdagLog log = new FagdagLog();
        when(normalizer.fromTxtToLog(eq(aLine))).thenReturn(log);
        firstTemplate.sendBody(aLine);
        verify(fagdagRepo).update(eq(log));
    }

    @Test
    public void shouldDeleteOnDLine() {
        when(normalizer.fromTxtToLog(eq(aLine))).thenReturn(new FagdagLog());
        when(fagdagRepo.update(any(FagdagLog.class))).thenReturn(new FagdagLog());
        firstTemplate.sendBody(bLine);
        verify(fagdagRepo).deleteFromId(eq(1312L));
    }

    @Test
    public void shouldNotifyOnUpdate() throws InterruptedException {
        FagdagLog log = new FagdagLog();
        log.setId(1L);
        log.setCode(1312L);
        log.setMessage("Apache Camel Rocks");
        when(normalizer.fromTxtToLog(eq(aLine))).thenReturn(log);
        when(fagdagRepo.update(any(FagdagLog.class))).thenReturn(log);
        notifierEndpoint.expectedBodiesReceived("Added line: [1] Apache Camel Rocks <1312>");
        notifierEndpoint.expectedMessageCount(1);
        firstTemplate.sendBody(aLine);
        notifierEndpoint.assertIsSatisfied();
    }

}
