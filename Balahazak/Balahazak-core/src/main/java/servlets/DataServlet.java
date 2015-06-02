package servlets;

import hb.Admin;
import hb.AdminManager;
import hb.Data;
import hb.DataManager;

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
public class DataServlet extends AbstractActionServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 8453854292709208084L;
	public DataServlet(){
        super();
    }
    /**
     * Login
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void getData(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	
    	DataManager dm = new DataManager();
    	Data data = dm.getData();
    	
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");

        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<email>&lt;a href='mailto:"+data.getEmail()+"'&gt;"+data.getEmail()+"&lt;/a&gt;</email>");
        sb.append("<address>"+data.getAddress()+"</address>");
        sb.append("<phone>"+data.getPhone()+"</phone>");
        sb.append("<tel>"+data.getTel()+"</tel>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
    }
    protected void saveData(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
    	Data data = new Data();
    	data.setAddress(request.getParameter("address"));
    	data.setEmail(request.getParameter("email"));
    	data.setPhone(request.getParameter("phone"));
    	data.setTel(request.getParameter("tel"));
    	data.setId(1);
    	DataManager dm = new DataManager();
    	dm.updateData(data);
    	StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
    }
}
