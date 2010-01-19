package no.bekk.camel;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.Processor;
import org.apache.camel.Exchange;
import org.apache.camel.spi.Policy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Service;
import no.bekk.repo.FagdagRepo;
import no.bekk.normalizer.FagdagNormalizer;
import no.bekk.domain.FagdagLog;

import javax.annotation.Resource;

@Service("routeBuilder")
public class FagdagRouteBuilder extends RouteBuilder {

    @Resource(name="normalizer")
    private FagdagNormalizer normalizer;

    @Resource(name="repository")
    private FagdagRepo repository;

    @Resource(name="firstSource")
    private String ircSource;

    // Litt usikker på denne, men tror den fungerer
    @Resource(name="secondSource")
    private String fileSource;

    @Resource(name="notifier")
    private String notifier;





    
    public void configure() throws Exception {
        configureInfoTimer();
        configureExceptinoHandlers();
        from(ircSource).to("direct:main");
        from(fileSource).split(body().tokenize("\n")).to("direct:main");
        from("direct:main").
            choice().
                when(body(String.class).regex("A.*")).bean(normalizer, "fromTxtToLog").bean(repository, "update").process(LOG_PROC).to(notifier).
                when(body(String.class).regex("D.*")).process(LINE_TO_ID_PROCESSOR).bean(repository ,"deleteFromId").process(LOG_DEL_PROC).to(notifier).
                otherwise().setBody(constant("Could not read line: " + body())).to(notifier).
            end();
    }





    private void configureExceptinoHandlers() {
        onException(RuntimeException.class).handled(true).process(ERR_PROC).to(notifier);
    }

    private void configureInfoTimer() {
        from("timer:startup?delay=1000&period=120000").setBody(constant("Listening for messages: A;[code];Message")).to(ircSource);
        from("timer:startup?delay=1000&period=600000").setBody(constant("Delivering results from saves")).to(notifier);
    }

    private static final Processor LINE_TO_ID_PROCESSOR = new Processor() {
        public void process(Exchange exchange) throws Exception {
            Long id = Long.valueOf(exchange.getIn().getBody(String.class).split(";")[1]);
            exchange.getOut().setBody(id);
        }
    };
    private static final Processor LOG_PROC = new Processor() {
        public void process(Exchange exchange) throws Exception {
            FagdagLog log = exchange.getIn().getBody(FagdagLog.class);
            exchange.getOut().setBody("Added line: [" + log.getId() + "] " + log.getMessage() + " <" + log.getCode()+ ">");
        }
    };
    private static final Processor LOG_DEL_PROC = new Processor() {
        public void process(Exchange exchange) throws Exception {
            Long log = exchange.getIn().getBody(Long.class);
            exchange.getOut().setBody("Removed line: " + log);
        }
    };
    private static final Processor ERR_PROC = new Processor() {
        public void process(Exchange exchange) throws Exception {
            Throwable caused = exchange.getProperty(Exchange.EXCEPTION_CAUGHT, Throwable.class);
            caused.printStackTrace();
            exchange.getOut().setBody("Failed to read line: " + caused.toString());
        }
    };
}
