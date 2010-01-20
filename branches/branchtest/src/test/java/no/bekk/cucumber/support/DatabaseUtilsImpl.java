package no.bekk.cucumber.support;

import cuke4duke.Table;
import no.bekk.domain.FagdagLog;
import no.bekk.repo.FagdagRepo;
import static org.junit.Assert.assertEquals;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class DatabaseUtilsImpl implements DatabaseUtils {
    @Autowired
    private FagdagRepo fagdagRepo;

    @Transactional(propagation = Propagation.REQUIRED)
    public void checkIfTableContainsData(String tableName, Table expectedData) {
        if (tableName.equals("FagdagLog")) {
            for (Map<String, String> row : expectedData.hashes()) {
                Long id = Long.valueOf(row.get("Id"));
                FagdagLog logEntry = fagdagRepo.find(id);
                assertEquals(row.get("Message"), logEntry.getMessage());
                assertEquals(Long.valueOf(row.get("Code")), logEntry.getCode());
            }
        } else {
            throw new AssertionError("No such table: " + tableName);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void emptyDatabase() {
        fagdagRepo.resetTable("FagdagLog");
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void addDataToTable(String tableName, Table expectedData) {
        if (tableName.equals("FagdagLog")) {
            for (Map<String, String> row : expectedData.hashes()) {
                FagdagLog logEntry = new FagdagLog();
                logEntry.setMessage(row.get("Message"));
                logEntry.setCode(Long.valueOf(row.get("Code")));
                fagdagRepo.update(logEntry);
            }
        } else {
            throw new AssertionError("No such table: " + tableName);
        }
    }

    public void checkIfTableContainsRowsWithValue(String tableName, String column, String value) {
        if (tableName.equals("FagdagLog")) {
            if (column.equals("Code")) {
                List<FagdagLog> fagdagLogs = fagdagRepo.getWithCode(Long.valueOf(value));
                if (fagdagLogs == null) return;
                assertEquals("Should contain zero rows", 0, fagdagLogs.size());
            } else {
                throw new AssertionError("Column not supported: " + column);
            }
        } else {
            throw new AssertionError("No such table: " + tableName);
        }
    }


}
