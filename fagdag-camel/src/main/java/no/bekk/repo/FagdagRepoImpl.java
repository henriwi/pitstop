package no.bekk.repo;

import no.bekk.domain.FagdagLog;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository("repository")
public class FagdagRepoImpl implements FagdagRepo {
    @PersistenceContext(unitName = "fagdag")
    private EntityManager em;

    @Transactional(propagation = Propagation.REQUIRED)
    public FagdagLog update(FagdagLog log) {
        return em.merge(log);
    }

    public FagdagLog find(Long code) {
        return em.find(FagdagLog.class, code);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void delete(FagdagLog log) {
        em.remove(log);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteFromId(Long log) {
        em.createQuery("delete from FagdagLog f where f.code =:code").setParameter("code", log).executeUpdate();
    }

    @SuppressWarnings({"unchecked"})
    public List<FagdagLog> list() {
        return em.createQuery("from FagdagLog").getResultList();
    }

    public void resetTable(String tableName) {
        em.createQuery("delete from " + tableName).executeUpdate();
        em.createNativeQuery("ALTER TABLE " + tableName + " ALTER COLUMN id RESTART WITH 1").executeUpdate();
    }

    @SuppressWarnings({"unchecked"})
    public List<FagdagLog> getWithCode(Long code) {
        return em.createQuery("from FagdagLog f where f.code =:code").setParameter("code", code).getResultList();
    }

}
