package hb;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Expression;
import util.MD5;

public class AdminManager {
	
	public synchronized int saveAdmin(Admin admin) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.save(admin);
			id = admin.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return id;
	}
	
	public int updateAdmin(Admin admin) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.update(admin);
			id = admin.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}
		return id;
	}

	public void deleteAdmin(Admin admin) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		try {
			session.delete(admin);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
		}

	}

	public Admin getAdminById(java.lang.Integer id) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		Admin admin = null;
		try {
			admin = (Admin) session.get(
					Admin.class, id);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}

		return admin;
	}
	public Admin loginAdmin(String username,String password) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Admin admin = null;
		
		try{
			Criteria crit = session.createCriteria(Admin.class);
	        //ProjectionList pList = Projections.projectionList();
	        //pList.add(Projections.property("id"));
	        crit.add(Expression.eq("username", username));
	        crit.add(Expression.eq("password", MD5.getMd5Digest(password)));
	        //crit.setProjection(pList);
	        admin = (Admin) crit.uniqueResult();
	        session.getTransaction().commit();
	        //if (id != null) match = true;
		} catch(Exception e){
			e.printStackTrace();
		}
		return admin;
	}
}
