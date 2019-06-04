package util;

import org.apache.commons.mail.SimpleEmail;

public class MailSender {
	private static final String host = "smtp.gmail.com";
	private static final int port1 = 465;
	//private static final int port2 = 587;
	private static final String user = "kkbalatoni@gmail.com";
	private static final String password = "balahayak";
	private static final String from = "kkbalatoni@gmail.com";
	private static final String fromName = "Balaházak";
	private static final String to = "kkbalatoni@gmail.com";
	private static final String cc = "kecsolecso@gmail.com";
	//private static final String subject = "Ajánlatkérés";
	public static String sendMail(String message, String subject){
		String res = "";
		try {
			SimpleEmail email = new SimpleEmail();
			email.setHostName(host);
			email.setSmtpPort(port1);
			email.setSSL(true);
			email.setCharset("UTF-8");
			email.setAuthentication(user, password);
			email.setFrom(from, fromName);
			email.addTo(to);
			email.addCc(cc);
			email.setSubject(subject);
			email.setMsg(message);
			email.send();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	/*public static void main(String[] args){
		sendMail();
	}*/
}
