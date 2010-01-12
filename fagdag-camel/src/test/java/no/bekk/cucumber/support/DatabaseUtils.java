package no.bekk.cucumber.support;

import cuke4duke.Table;

public interface DatabaseUtils {
    void checkIfTableContainsData(String tableName, Table expectedData);

    void emptyDatabase();

    void addDataToTable(String tableName, Table expectedData);

    void checkIfTableContainsRowsWithValue(String tableName, String column, String value);
}
