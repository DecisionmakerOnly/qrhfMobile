package com.qrhf.tools;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

public class SystemAttributes {
	
	public static final String COMPANY_NAME = "北京千瑞恒福科贸有限公司";
	public static final String EMAIL_ACCOUNT = "ljh96402@163.com";
	public static final String EMAIL_PASSWORD = "lizui19640229";
	public static final String EMAIL_SMTP_HOST = "smtp.163.com";
	public static final Map<String,String> SESSIONID_USR  =new HashMap<String, String>();
	public static final Map<String, HttpSession> USR_SESSION = new HashMap<String, HttpSession>();
}