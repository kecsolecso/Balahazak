package servlets;

import hb.PHPReplication;
import hb.PHPReplicationManager;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.FireBirdAuth;

public class ServePHP extends AbstractActionServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -768604605799467713L;
	
	private String ktgUser = "";
	private String ktgPassword = "";
	private PHPReplication pr;
	public ServePHP(){
        super();
    }
	public void getPHPData(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
        setKtgUser(request.getParameter("ktg_user"));
        setKtgPassword(request.getParameter("ktg_password"));
        
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        if(pr != null){
	        sb.append("<url>"+pr.getWebURL()+"/ktg_index.php</url>");
	        sb.append("<ktg_user>"+getKtgUser()+"</ktg_user>");
	        sb.append("<ktg_password>"+getKtgPassword()+"</ktg_password>");
        }
        sb.append("</response>");
        response.getWriter().write(sb.toString());
	}
	public void logoutUser(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
		request.getSession().removeAttribute("ktg_user");
        request.getSession().removeAttribute("ktg_password");
        request.getSession().removeAttribute("ktg_URL");
        //System.out.println("attributes removed");
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
	}
	public void checkUserAuthentication(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
        request.getSession().removeAttribute("ktg_user");
        request.getSession().removeAttribute("ktg_password");
        request.getSession().removeAttribute("ktg_URL");
        setKtgUser(request.getParameter("ktg_user"));
        setKtgPassword(request.getParameter("ktg_password"));
        checkUser();
        if(pr!=null){
        	request.getSession().setAttribute("ktg_user", getKtgUser().toUpperCase());
        	request.getSession().setAttribute("ktg_password", getKtgPassword());
        	request.getSession().setAttribute("ktg_URL", pr.getWebURL());
        	//System.out.println("1PHP URL: "+pr.getWebURL());
        }
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("<loggableUser>"+((pr == null)? "0" : "1")+"</loggableUser>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
	}
	public void getDemoURL(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
        request.getSession().removeAttribute("ktg_user");
        request.getSession().removeAttribute("ktg_password");
        request.getSession().removeAttribute("ktg_URL");
        setKtgUser("XY");
        setKtgPassword("10");
        checkUser();
        if(pr != null){
        	request.getSession().setAttribute("ktg_user", getKtgUser().toUpperCase());
        	request.getSession().setAttribute("ktg_URL", pr.getWebURL());
        	request.getSession().setAttribute("ktg_password", getKtgPassword());
        	//System.out.println("2PHP URL: "+pr.getWebURL());
        }
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        //sb.append("<demoURL>"+((pr == null)? "0" : pr.getWebURL())+"</demoURL>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
	}
	public String getKtgUser() {
		return ktgUser;
	}
	public void setKtgUser(String ktgUser) {
		this.ktgUser = ktgUser;
	}
	public String getKtgPassword() {
		return ktgPassword;
	}
	public void setKtgPassword(String ktgPassword) {
		this.ktgPassword = ktgPassword;
	}
	public boolean checkUser(){
		boolean res = false;
		PHPReplicationManager prm = new PHPReplicationManager();
        List<PHPReplication> l = prm.getPHPReplications();
        for(int i = 0; i < l.size(); i++){
        	pr = l.get(i);
        	if(FireBirdAuth.checkUser(pr.getDbPath(),getKtgUser(),getKtgPassword())){
        		res = true;
        		break;
        	}
        	pr = null;
        }
		return res;
	}
}
