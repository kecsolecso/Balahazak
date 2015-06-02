package hb;

import javax.naming.InitialContext;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * @author kecso
 *
 */

public class Database {
	private static Logger logger = Logger.getLogger(Database.class);
	private static final SessionFactory sessionFactory;
	
	private InitialContext ctx;
	
	public Database(){
		try {
			ctx = new InitialContext();
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}

	static {
        try {
            // Create the SessionFactory from hibernate.cfg.xml
        	Configuration cfg = new Configuration();
            sessionFactory = cfg.configure("/hibernate/hibernate.cfg.xml").buildSessionFactory();
        } catch (Throwable ex) {
            // Make sure you log the exception, as it might be swallowed
        	logger.error("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
	
	public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
	
}