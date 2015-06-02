package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class FireBirdAuth {
	public static final String ktg_user = "CSERCSAANNA";
	public static final String ktg_password = "01131336";
	public static boolean checkUser(String pathToDBFile,String user,String pass){
		boolean res = false;
		try {
			System.out.println("user = "+user +" pass= "+pass + "path db file="+pathToDBFile);
			Class.forName("org.firebirdsql.jdbc.FBDriver");
			String connStr = "jdbc:firebirdsql:localhost/3050:"+pathToDBFile;
			String connUser = "SYSDBA";
			String connPwd = "Q1w2e3r4";
			System.out.println("connStr = "+connStr);
			System.out.println("connUser = "+connUser);
			System.out.println("connPwd = "+connPwd);
			//"jdbc:firebirdsql:koltsegsql.no-ip.biz/3050:gogol",
			Connection connection = DriverManager.getConnection(connStr,connUser,connPwd);
			Statement s = connection.createStatement();
			ResultSet r = s.executeQuery("select * from EPULAKJOGV where PHP_USER = '"+user.toUpperCase() + "' AND " +
					"PHP_PASSWORD = '"+pass+"'");
			res = r.next();
			connection.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
}
