package hb;

import org.hibernate.HibernateException;
import org.hibernate.Session;

public class DataManager {
	
	public int updateData(Data data) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.update(data);
			id = data.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}
		return id;
	}

	public Data getData() {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		int id = 1;
		Data data = null;
		try {
			data = (Data) session.get(
					Data.class, id);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}

		return data;
	}
}
