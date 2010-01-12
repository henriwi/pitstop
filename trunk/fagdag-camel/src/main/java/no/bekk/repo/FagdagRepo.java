package no.bekk.repo;

import no.bekk.domain.FagdagLog;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;

public interface FagdagRepo {
    public FagdagLog update(FagdagLog log);
    public FagdagLog find(Long code);
    public void delete(FagdagLog log);
    public void deleteFromId(Long log);
    public List<FagdagLog> list();
    public void resetTable(String tableName);

    List<FagdagLog> getWithCode(Long code);
}
