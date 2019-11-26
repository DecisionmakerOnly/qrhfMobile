package com.qrhf.controller;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.qrhf.config.SystemAttributes;
import com.qrhf.dao.UserMapper;
import com.qrhf.pojo.User;
import com.qrhf.tools.SendPhoneCode;
@Component
public class DeliveryTime {
	@Autowired
	private UserMapper userMapper;
	@Scheduled(cron ="0 0 10 * * ?" )
//	@Scheduled(cron ="0/5 * * * * ?" )
	public void tiggertimer() throws Exception{
		List<User> list =userMapper.findUserExpires();
		String threeName="";
		String threeTime="";
		String code="";
		String threePhone="";
		String sevenPhone="";
		String sevenTime=""; 
		String sevenName="";
		String receiveMailAccount="";
		if(list != null && list.size()>=1) {
			for(int i=0; i<list.size(); i++) {
				//未交费
				if(list.get(i).getIsPayment() == 0 ) {
					//还剩三天的时候
					if(list.get(i).getThreeName() !=null && list.get(i).getThreeExpiryDate() !=null ) {
						threeTime=list.get(i).getThreeExpiryDate();
						threeName=list.get(i).getThreeName();
						if(list.get(i).getPhone() ==null || list.get(i).getPhone()=="" ) {
							receiveMailAccount=list.get(i).getEmail();
							Properties props = new Properties();
							props.setProperty("mail.transport.protocol", "smtps");
							props.setProperty("mail.smtps.host",SystemAttributes.EMAIL_SMTP_HOST); // 发件人的邮箱的 SMTP
							props.put("mail.smtp.socketFactory.port", 456);
							Session session = Session.getInstance(props);
							MimeMessage message = createMimeMessage(threeName,threeTime,session, SystemAttributes.EMAIL_ACCOUNT,receiveMailAccount);
							Transport transport = session.getTransport();
							transport.connect(SystemAttributes.EMAIL_ACCOUNT,SystemAttributes.EMAIL_PASSWORD);
							transport.sendMessage(message, message.getAllRecipients());
							transport.close();
						}else {
							threePhone=list.get(i).getPhone();
							SendPhoneCode.sendSms(threePhone,code,"SMS_171113993",threeName,threeTime); 
						}
					}
					//还剩七天的时候
					if(list.get(i).getSevenName() !=null && list.get(i).getSevenExpiryDate()!=null) {
						sevenTime=list.get(i).getSevenExpiryDate();
						sevenName=list.get(i).getSevenName();
						if(list.get(i).getPhone() ==null || list.get(i).getPhone()=="" ) {
							receiveMailAccount=list.get(i).getEmail();
							Properties props = new Properties();
							props.setProperty("mail.transport.protocol", "smtps");
							props.setProperty("mail.smtps.host",SystemAttributes.EMAIL_SMTP_HOST); // 发件人的邮箱的 SMTP
							props.put("mail.smtp.socketFactory.port", 456);
							Session session = Session.getInstance(props);
							MimeMessage message = createMimeMessage(sevenName,sevenTime,session, SystemAttributes.EMAIL_ACCOUNT,receiveMailAccount);
							Transport transport = session.getTransport();
							transport.connect(SystemAttributes.EMAIL_ACCOUNT,SystemAttributes.EMAIL_PASSWORD);
							transport.sendMessage(message, message.getAllRecipients());
							transport.close();
						}else {
							sevenPhone=list.get(i).getPhone();
							SendPhoneCode.sendSms(sevenPhone,code,"SMS_171113993",sevenName,sevenTime); 
						}
					}
				
					}
				//已缴费
				if(list.get(i).getIsPayment() == 1) {
					//还剩三天的时候
					if(list.get(i).getThreeName() !=null && list.get(i).getThreeExpiryDate() !=null ) {
						threeTime=list.get(i).getThreeExpiryDate();
						threeName=list.get(i).getThreeName();
						if(list.get(i).getPhone() ==null || list.get(i).getPhone()=="" ) {
							receiveMailAccount=list.get(i).getEmail();
							Properties props = new Properties();
							props.setProperty("mail.transport.protocol", "smtps");
							props.setProperty("mail.smtps.host",SystemAttributes.EMAIL_SMTP_HOST); // 发件人的邮箱的 SMTP
							props.put("mail.smtp.socketFactory.port", 456);
							Session session = Session.getInstance(props);
							MimeMessage message = createMimeMessage(threeName,threeTime,session, SystemAttributes.EMAIL_ACCOUNT,receiveMailAccount);
							Transport transport = session.getTransport();
							transport.connect(SystemAttributes.EMAIL_ACCOUNT,SystemAttributes.EMAIL_PASSWORD);
							transport.sendMessage(message, message.getAllRecipients());
							transport.close();
						}else {
							threePhone=list.get(i).getPhone();
							SendPhoneCode.sendSms(threePhone,code,"SMS_171113993",threeName,threeTime); 
							System.out.println(list.get(i).getPhone()+"bb");
						}
					}
					//还剩七天的时候
					if(list.get(i).getSevenName() !=null && list.get(i).getSevenExpiryDate()!=null) {
						sevenTime=list.get(i).getSevenExpiryDate();
						sevenName=list.get(i).getSevenName();
						if(list.get(i).getPhone() ==null || list.get(i).getPhone()=="" ) {
							receiveMailAccount=list.get(i).getEmail();
							Properties props = new Properties();
							props.setProperty("mail.transport.protocol", "smtps");
							props.setProperty("mail.smtps.host",SystemAttributes.EMAIL_SMTP_HOST); // 发件人的邮箱的 SMTP
							props.put("mail.smtp.socketFactory.port", 456);
							Session session = Session.getInstance(props);
							MimeMessage message = createMimeMessage2(sevenName,sevenTime,session, SystemAttributes.EMAIL_ACCOUNT,receiveMailAccount);
							Transport transport = session.getTransport();
							transport.connect(SystemAttributes.EMAIL_ACCOUNT,SystemAttributes.EMAIL_PASSWORD);
							transport.sendMessage(message, message.getAllRecipients());
							transport.close();
						}else {
							sevenPhone=list.get(i).getPhone();
							SendPhoneCode.sendSms(sevenPhone,code,"SMS_171118999",sevenName,sevenTime); 
							System.out.println(list.get(i).getPhone()+"bb");
						}
					}
				}
			}	
				
			}
		}
		/**
		 * 发送邮箱验证码格式
		 * 
		 * @param session
		 * @param myEmailAccount
		 * @param receiveMailAccount
		 * @return
		 */
		public static MimeMessage createMimeMessage(String name,String time, Session session, String sendMail, String receiveMail)
				throws Exception {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(sendMail,SystemAttributes.COMPANY_NAME, "UTF-8"));
			message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "注册", "UTF-8"));
			message.setSubject(SystemAttributes.COMPANY_NAME+"邮件", "UTF-8");
			message.setContent("您的员工" + name + "在“千瑞恒福”试用的“智能审批”试用期于"+time+"到期，请缴费或申请延期试用。", "text/html;charset=UTF-8");
			message.setSentDate(new Date());
			message.saveChanges();
			return message;
	}
		/**
		 * 发送邮箱验证码格式
		 * 
		 * @param session
		 * @param myEmailAccount
		 * @param receiveMailAccount
		 * @return
		 */
		public static MimeMessage createMimeMessage2(String name,String time, Session session, String sendMail, String receiveMail)
				throws Exception {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(sendMail,SystemAttributes.COMPANY_NAME, "UTF-8"));
			message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "注册", "UTF-8"));
			message.setSubject(SystemAttributes.COMPANY_NAME+"邮件", "UTF-8");
			message.setContent("您的员工" + name + "在“千瑞恒福”使用的“智能审批”于"+time+"到期，请续费。", "text/html;charset=UTF-8");
			message.setSentDate(new Date());
			message.saveChanges();
			return message;
	}
}
