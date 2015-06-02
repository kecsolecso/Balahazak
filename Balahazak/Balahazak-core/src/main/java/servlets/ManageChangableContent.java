package servlets;

import hb.ChangableContent;
import hb.ChangableContentManager;
import hb.PageManager;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author kecso Kecse-Nagy Csaba
 */

public class ManageChangableContent extends AbstractActionServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 8453854292709208084L;
	public ManageChangableContent(){
        super();
    }
    /**
     * Login
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void saveContent(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	
    	ChangableContentManager cm = new ChangableContentManager();
    	ChangableContent content = new ChangableContent();
    	content.setContent(request.getParameter("content"));
    	content.setLastModify(new Timestamp(System.currentTimeMillis()));
    	PageManager pm = new PageManager();
    	//System.out.println(pm.getPageByName("introduction"));
    	content.setPageId(pm.getPageByName(request.getParameter("pageName")).getId());
    	//System.out.println("givenPageName = "+content.getPageId());
    	//System.out.println("givenPageName = "+content.getContent());
    	cm.saveChangableContent(content);
    	
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");

        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
    }
    protected void getContent(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	String pageName = request.getParameter("page");
    	//System.out.println(pageName.replace("div_",""));
    	ChangableContentManager ccm = new ChangableContentManager();
    	String content = "";
    	ChangableContent cc =  ccm.getChangableContentByPageName(
    			(pageName.startsWith("div_")? pageName.replace("div_", "") : request.getParameter("page")));
    	if(cc != null){
	    	content += cc.getContent();
	    	content = content.replace("<", "&lt;").replace(">", "&gt;");
    	}
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");

        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append((pageName.startsWith("div_"))? "<"+pageName+">"+content+"</"+pageName+">" : 
        	"<hidden_content> "+content+"</hidden_content>");
        sb.append("</response>");
        //System.out.println(sb);
        response.getWriter().write(sb.toString());
    }
}
