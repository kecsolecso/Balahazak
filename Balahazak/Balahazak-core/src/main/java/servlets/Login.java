package servlets;

import hb.Admin;
import hb.AdminManager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
/**
 *
 * @author kecso Kecse-Nagy Csaba
 */
@WebServlet(name="Login", urlPatterns={"/Login"})
public class Login extends AbstractActionServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 8453854292709208084L;
	public Login(){
        super();
    }
    /**
     * Login
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void login(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	request.getSession().removeAttribute("admin");
    	
    	AdminManager am = new AdminManager();
    	Admin admin = am.loginAdmin(
    			request.getParameter("username"), 
    			request.getParameter("password"));
    	if(admin != null) {
    		request.getSession().setAttribute("admin", admin);
    	}
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");

        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append((admin != null)? "<loggable>1</loggable>" : "");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
    }
}
