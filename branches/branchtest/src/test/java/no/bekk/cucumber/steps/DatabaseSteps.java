package no.bekk.cucumber.steps;

import cuke4duke.Given;
import cuke4duke.Table;
import cuke4duke.Then;
import cuke4duke.spring.StepDefinitions;
import no.bekk.cucumber.support.DatabaseUtils;
import org.springframework.beans.factory.annotation.Autowired;

@StepDefinitions
public class DatabaseSteps {

    @Autowired
    private DatabaseUtils databaseUtils;

    @Given("^the database is fresh$")
    public void dbIsClean() {
        databaseUtils.emptyDatabase();
    }

    @Given("^table \"([^\\\"]*)\" is inserted with:$")
    public void tableInsertData(String tableName, Table expectedData) {
        databaseUtils.addDataToTable(tableName, expectedData);
    }

    @Then("^table \"([^\\\"]*)\" contains:$")
    public void tableDataContains(String tableName, Table expectedData) {
        databaseUtils.checkIfTableContainsData(tableName, expectedData);
    }

    @Then("^table \"([^\\\"]*)\" contains no rows with \"([^\\\"]*)\" \"([^\\\"]*)\"$")
    public void tableContainsNoRowsWithValue(String tableName, String column, String value){
        databaseUtils.checkIfTableContainsRowsWithValue(tableName, column, value);
    }

}
