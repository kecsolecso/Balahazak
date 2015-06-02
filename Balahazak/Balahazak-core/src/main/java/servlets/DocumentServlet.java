package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

//import com.sun.jna.Library;
//import com.sun.jna.Native;

/**
 *
 * @author kecso Kecse-Nagy Csaba
 */

/*interface CLibrary extends Library {
    public int chmod(String path, int mode);
}*/


public class DocumentServlet extends AbstractActionServlet {
	//private static final String DEST_PATH = "e:\\Work\\Private\\Balatoni\\tmp";
	//private static final String DEST_PATH = "/mnt/sda7/_www/balahazak.hu/java";
	private String DEST_PATH;
    private static final String DEST_DIR_PATH = "/Files";
    private static final String PROPS_FILE = "env.properties";
    private static final String DEST_PATH_PROPERTIES_KEY = "document.path";
    /*private static CLibrary libc = (CLibrary) Native.loadLibrary(
    		(System.getProperty("os.name").contains("Windows"))? "msvcrt" : "c" , CLibrary.class);*/
    private boolean windows = System.getProperty("os.name").contains("Windows");
    private File destinationDir;
    /**
	 * 
	 */
	private static final long serialVersionUID = 8453854292709208085L;
	public DocumentServlet(){
		super();
		DEST_PATH = "";
		try {
			Properties props = new Properties();
			props.load(getClass().getResourceAsStream("/"+PROPS_FILE)/*new FileInputStream(PROPS_FILE)*/);
			DEST_PATH = props.getProperty(DEST_PATH_PROPERTIES_KEY);
			System.out.println(DEST_PATH+DEST_DIR_PATH);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
	public void init() throws ServletException{
		//String destFileRealPath = getServletContext().getRealPath(DEST_DIR_PATH);
		//System.out.println("init");
		destinationDir = new File(DEST_PATH);
		if(!destinationDir.isDirectory())
			throw new ServletException(DEST_PATH + " is not a directory");
		else{
			File f = new File(DEST_PATH+DEST_DIR_PATH);
			if(!f.isDirectory()){
				f.mkdir();
				if(!windows)
					try {
						Runtime.getRuntime().exec(DEST_PATH+"/jchmod.sh");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				//System.out.println("Files doesn't exists");
			}
			//destinationDir = new File(DEST_PATH+DEST_DIR_PATH);
		}
	}
    protected void uploadDocument(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
        FileItemFactory fif = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(fif); 
        //String uploadDir = ;
        try{
        	List items = sfu.parseRequest(request);
        	//System.out.println(items.size());
        	Iterator iterator = items.iterator();
        	while(iterator.hasNext()){
        		FileItem fi = (FileItem)iterator.next();
        		if(!fi.isFormField()){
        			//System.out.println(fi.getName());
        			//System.getProperties().
        			File f = new File(DEST_PATH+DEST_DIR_PATH+request.getParameter("dir"));
        			if(!f.isDirectory()){
        				f.mkdir();
        				if(!windows)
        					Runtime.getRuntime().exec(DEST_PATH+"/jchmod.sh");
        			}
        			f = new File(DEST_PATH+DEST_DIR_PATH+request.getParameter("dir"),fi.getName());
        			fi.write(f);
        		}
        	}
        }catch(Exception e){
        	e.printStackTrace();
        }
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("</response>");
        response.getWriter().write(sb.toString());
    }
    protected void getPubDocs(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	//System.out.println(request.getParameter("dir1"));
    	//System.out.println(request.getParameter("dir2"));
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("<div_docs>").append("&lt;table class='fullwidth'&gt;");
        sb.append("&lt;tr&gt;&lt;td style='width:50%; text-align:center; font-weight:bold'&gt;");
        sb.append("Jogszabályok&lt;/td&gt;&lt;td style='width:50%; text-align:center; font-weight:bold'&gt;");
        sb.append("Szabványok&lt;/td&gt;&lt;/tr&gt;");
        String destFileRealPath1 = DEST_PATH+DEST_DIR_PATH+request.getParameter("dir1");
        String destFileRealPath2 = DEST_PATH+DEST_DIR_PATH+request.getParameter("dir2");
        System.out.println(destFileRealPath1 + "\n" + destFileRealPath2);
        List l1 = Arrays.asList(new File(destFileRealPath1).list());
        List l2 = Arrays.asList(new File(destFileRealPath2).list());
        Collections.sort(l1,java.text.Collator.getInstance(new Locale("hu_HU")));
        Collections.sort(l2,java.text.Collator.getInstance(new Locale("hu_HU")));
        //File[] f2 = dir2.listFiles();
        
        //if(f1 != null && f2 != null){
        	int size = (l1.size()> l2.size()) ? l1.size() : l2.size();
        	for(int i = 0; i < size;i++){
        		sb.append("&lt;tr&gt;");
	        	
        		if(i < l1.size()){
	        		String fileName = l1.get(i).toString();
		        	String extension = fileName.substring(fileName.lastIndexOf('.')+1, fileName.length());
		        	sb.append("&lt;td class='halfwidth'&gt;&lt;a href='#' alt='' onclick='download(this.innerHTML,\""+
		        			request.getParameter("dir1")+
		        			"\",\"pub\");' class='docs_link "+extension+"' &gt;").append(fileName).append("&lt;/a&gt;&lt;/td&gt;");
        		} else{
        			sb.append("&lt;td class='halfwidth'&gt;&lt;/td&gt;");
        		}
        		if(i < l2.size()){
	        		String fileName = l2.get(i).toString();
		        	String extension = fileName.substring(fileName.lastIndexOf('.')+1, fileName.length());
		        	sb.append("&lt;td class='halfwidth'&gt;&lt;a href='#' alt='' onclick='downloadDocument(this.innerHTML,\""+
		        			request.getParameter("dir2")+
		        			"\",\"pub\");' class='docs_link "+extension+"' &gt;").append(fileName).append("&lt;/a&gt;&lt;/td&gt;");
        		}else{
        			sb.append("&lt;td class='halfwidth'&gt;&lt;/td&gt;");
        		}
        		sb.append("&lt;tr&gt;");
        	}
        //}
        sb.append("&lt;/tr&gt;&lt;/table&gt;</div_docs></response>");
        //System.out.println(sb);
        response.getWriter().write(sb.toString());
    }
    protected void getDocs(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException, Exception {
    	response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("text/xml");
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><response>");
        sb.append("<ajaxresponse>1</ajaxresponse>");
        sb.append("<div_docs>").append("&lt;table class='fullwidth'&gt;");
        String url = (request.getSession().getAttribute("ktg_URL") == null) ? "": 
        	request.getSession().getAttribute("ktg_URL").toString();
        String destFileRealPath = "";
        //System.out.println("2: "+destFileRealPath);
        destFileRealPath = DEST_PATH+DEST_DIR_PATH+((url == "") ?  "" : url.substring(url.lastIndexOf("/")))+
        	request.getParameter("dir");
        //System.out.println("dir: "+destFileRealPath);
        destinationDir = new File(destFileRealPath);
        File parentDir = new File(destFileRealPath.substring(0, destFileRealPath.lastIndexOf("/")));
        if(!parentDir.isDirectory()){
        	parentDir.mkdir();
        	if(!windows)
        		Runtime.getRuntime().exec(DEST_PATH+"/jchmod.sh");
        }
        if(!destinationDir.isDirectory()){
        	destinationDir.mkdir();
        	if(!windows)
        		Runtime.getRuntime().exec(DEST_PATH+"/jchmod.sh");
        }
        File[] f = destinationDir.listFiles();
        if(f != null)
	        for(int i = 0; i < f.length;i++){
	        	String fileName = f[i].getName();
	        	String extension = fileName.substring(fileName.lastIndexOf('.')+1, fileName.length());
	        	sb.append((i == 0) ? "&lt;tr&gt;":"");
	        	sb.append((i != 0 && i%2 == 0) ? "&lt;/tr&gt;&lt;tr&gt;":"");
	        	sb.append("&lt;td class='halfwidth'&gt;&lt;a href='#' alt='' onclick='downloadDocument(this.innerHTML,\""+
	        			request.getParameter("dir")+
	        			"\",\"not_pub\");' class='docs_link "+extension+"' &gt;").append(fileName).append("&lt;/a&gt;&lt;/td&gt;");
	        	//sb.append(fileName).append(";");
	        }
        sb.append("&lt;/tr&gt;&lt;/table&gt;</div_docs></response>");
        //System.out.println(sb);
        response.getWriter().write(sb.toString());
    }
    protected void downloadFile(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	//System.out.println(request.getParameter("file"));
    	//String destFileRealPath = getServletContext().getRealPath("");
        //System.out.println("2: "+destFileRealPath);
        String destFileRealPath = "";
        String url = (request.getParameter("mode").equals("pub")) ? "": 
        	(request.getSession().getAttribute("ktg_URL") == null) ? "" :
        		request.getSession().getAttribute("ktg_URL").toString();
    	String fileToDownload = 
    		new String(request.getParameter("file").getBytes(request.getCharacterEncoding() == null ? 
    			"ISO-8859-1":request.getCharacterEncoding()),"UTF-8");
    	destFileRealPath += DEST_PATH + DEST_DIR_PATH + 
    		((url == "") ? "" : url.substring(url.lastIndexOf("/"))) + 
    		new String(request.getParameter("dir").getBytes(request.getCharacterEncoding() == null ? 
        			"ISO-8859-1":request.getCharacterEncoding()),"UTF-8")+"/"+fileToDownload;
    	//System.out.println(fileToDownload);
    	try{
    		new FileInputStream(destFileRealPath);
    	}catch(Exception e){
    		//e.printStackTrace();
    		String fileToDownload2 = new String(request.getParameter("file").getBytes("UTF-8"),"UTF-8");
    		destFileRealPath = DEST_PATH + DEST_DIR_PATH + 
	    		((url == "") ? "" : url.substring(url.lastIndexOf("/"))) + 
	    		new String(request.getParameter("dir").getBytes("UTF-8"),"UTF-8")+"/"+fileToDownload2;
	    	//System.out.println(fileToDownload2);
	    	fileToDownload = fileToDownload2; 
    	}
    		
    	response.setContentType("application/octet-stream");
    	response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Disposition","attachment;filename=\""+fileToDownload+"\"");
        
        FileInputStream f = new FileInputStream(destFileRealPath);
        ServletOutputStream out = response.getOutputStream();
        response.setContentLength(f.available());
        byte[] outputByte = new byte[4096];

        while (f.read(outputByte, 0, 4096) != -1){
        	out.write(outputByte);
        }
        out.flush();
        out.close();
        f.close();
    }
}
