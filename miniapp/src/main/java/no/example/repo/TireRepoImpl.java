package no.example.repo;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import no.example.domain.Tire;

@Repository("tireRepo")
public class TireRepoImpl implements TireRepo {

	private SessionFactory sessionFactory;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tire> getTires() {
		Session session = sessionFactory.openSession();
		return session.createQuery("from Tire").list();
	}
}
