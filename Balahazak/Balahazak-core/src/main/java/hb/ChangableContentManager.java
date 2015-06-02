package hb;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;

public class ChangableContentManager {
	
	public synchronized int saveChangableContent(ChangableContent content) {
		PageManager pm = new PageManager();
		Page page = pm.getPageById(content.getPageId());
		
		ChangableContent updateCc = getChangableContentByPageName(page.getName());
		int id = 0;
		if(updateCc != null){
			content.setId(updateCc.getId()); 
			id = updateChangableContent(content);
		}else{
		
			Session session = Database.getSessionFactory().getCurrentSession();
			session.beginTransaction();
			
			//int id = 0;
			try {
				session.save(content);
				id = content.getId();
				session.getTransaction().commit();
			} catch (HibernateException e) {
				e.printStackTrace();
				session.getTransaction().rollback();
			}
		}
		return id;
	}
	
	public int updateChangableContent(ChangableContent content) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		int id = 0;
		try {
			session.update(content);
			id = content.getId();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}
		return id;
	}

	public void deleteChangableContent(ChangableContent content) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		try {
			session.delete(content);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
		}

	}

	public ChangableContent getChangableContentById(java.lang.Integer id) {
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();

		ChangableContent content = null;
		try {
			content = (ChangableContent) session.get(
					ChangableContent.class, id);
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
		}

		return content;
	}
	public ChangableContent getChangableContentByPageName(String pageName) {
		//System.out.println("admin");
		PageManager pm = new PageManager();
		Page page = pm.getPageByName(pageName);
		Session session = Database.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		ChangableContent cc = null;
		
		try{
			Criteria crit = session.createCriteria(ChangableContent.class);
	        crit.add(Expression.eq("pageId", page.getId()));
	        cc = (ChangableContent) crit.uniqueResult();
	        session.getTransaction().commit();
		} catch(Exception e){
			e.printStackTrace();
		}
	
		return cc;
	}
}
