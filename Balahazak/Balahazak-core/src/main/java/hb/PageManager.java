package hb;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;

/**
 * 
 * @author Kecsó
 *
 */
public class PageManager {
	
	public synchronized int savePage(Page page) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.save(page);
			id = page.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return id;
	}

	
	public int updateCategory(Page page) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.update(page);
			id = page.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}
		return id;
	}

	public void deleteCategory(Page page) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		try {
			session.delete(page);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
		}

	}

	public Page getPageById(java.lang.Integer id) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		Page page = null;
		try {
			page = (Page) session.get(
					Page.class, id);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}

		return page;
	}
	public Page getPageByName(String name) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Page page = null;
		
		try{
			Criteria crit = session.createCriteria(Page.class);
	        crit.add(Expression.eq("name", name));
	        page = (Page) crit.uniqueResult();
	        session.getTransaction().commit();
		} catch(Exception e){
			e.printStackTrace();
		}
		return page;
	}
	
}
