package no.bekk.cucumber.steps;

import cuke4duke.Given;
import cuke4duke.Then;
import cuke4duke.When;
import cuke4duke.spring.StepDefinitions;
import org.apache.camel.EndpointInject;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.component.mock.MockEndpoint;

@StepDefinitions
public class RegistratorSteps {

    @EndpointInject(uri = "direct:firstEndpoint")
    private ProducerTemplate firstSource;

    @EndpointInject(uri = "mock:notifier")
    protected MockEndpoint notifierEndpoint;

    @Given("^Registrator expects \"([^\\\"]*)\" notifications?$")
    public void setupNotifierExpectation(int messages) {
        notifierEndpoint.reset();
        notifierEndpoint.expectedMessageCount(messages);
    }

    @When("^Registrator submits line with content \"([^\\\"]*)\"$")
    public void submitRegistration(String line) {
        firstSource.sendBody(line);
    }

    @Then("^notifications have been sent$")
    public void assertNotifier() throws InterruptedException {
        notifierEndpoint.assertIsSatisfied();
    }

}
