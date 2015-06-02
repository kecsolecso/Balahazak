	package servlets;

import hb.PHPReplication;
import hb.PHPReplicationManager;

import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.FireBirdAuth;
import util.MailSender;

public class SendMail extends AbstractActionServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -768604605799467714L;

	public SendMail(){
        super();
    }
	public void sendProposal(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//System.out.println("kérés érkezett");
		response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
        StringBuilder sb = new StringBuilder("");
        sb.append("Kedves Bala,\n\n");
        sb.append("tudod mi történt? Hát egy ajánlatot kértek tőled a BalaHázak honlapodon.\n");
        sb.append("Ímé az adatok:\n");
        String data = request.getParameter("data");
        StringTokenizer st = new StringTokenizer(data,"#");
        while(st.hasMoreTokens()){
        	sb.append(st.nextToken()).append("\n");
        }
        sb.append("\nMost, hogy már mindent tudsz, kérlek válaszolj ennek a kedves embernek.\n");
        sb.append("\nÜdv,\na Honlapod");
        //System.out.println(sb.toString());
        MailSender.sendMail(sb.toString(), request.getParameter("subject"));
        sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
	}
	public void sendBugReport(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		//System.out.println("kérés érkezett");
		response.setHeader("Cache-Control", "no-cache");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("text/xml");
		StringBuilder sb = new StringBuilder("");
		sb.append("Kedves Bala,\n\n");
		sb.append("sajnálatos dolog történt! Bejelentettek egy hibát a honlapodon.\n");
		sb.append("A bejelentő adatai:\n");
		sb.append("User: "+request.getSession().getAttribute("ktg_user")+"\n");
		sb.append("Password: "+request.getSession().getAttribute("ktg_password")+"\n");
		String dbURL = request.getSession().getAttribute("ktg_URL").toString();
		sb.append("Társasház: "+dbURL.substring(dbURL.lastIndexOf('/')+1)+"\n");
		sb.append("Ímé az adatok:\n");
		String data = request.getParameter("data");
		StringTokenizer st = new StringTokenizer(data,"#");
		while(st.hasMoreTokens()){
			sb.append(st.nextToken()).append("\n");
		}
		sb.append("\nMost, hogy már mindent tudsz, kérlek válaszolj ennek a kedves embernek.\n");
		sb.append("\nÜdv,\na Honlapod");
		//System.out.println(sb.toString());
		MailSender.sendMail(sb.toString(), request.getParameter("subject"));
		sb = new StringBuilder();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
		sb.append("<ajaxresponse>1</ajaxresponse>");
		sb.append("</response>");
		response.getWriter().write(sb.toString());
	}
}
