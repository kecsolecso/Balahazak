package hb;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;

public class PHPReplicationManager {
	public synchronized int savePHPReplication(PHPReplication pr) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.save(pr);
			id = pr.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return id;
	}
	
	public int updateCategory(PHPReplication pr) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.update(pr);
			id = pr.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}
		return id;
	}

	public void deleteCategory(PHPReplication pr) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		try {
			session.delete(pr);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
		}

	}

	public List<PHPReplication> getPHPReplications() {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		
		List<PHPReplication> list = null;

        try {
            list = session.createCriteria(PHPReplication.class).list();
            session.getTransaction().commit();
        } catch (HibernateException e) {
            session.getTransaction().rollback();
            throw e;
        }

        return list;
	}
}
