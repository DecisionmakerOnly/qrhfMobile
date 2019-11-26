package com.qrhf.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aliyuncs.exceptions.ClientException;
import com.qrhf.config.SystemAttributes;
import com.qrhf.pojo.Company;
import com.qrhf.pojo.Contract;
import com.qrhf.pojo.RealInfo;
import com.qrhf.pojo.SysFlow;
import com.qrhf.pojo.SysResource;
import com.qrhf.pojo.SysRole;
import com.qrhf.pojo.User;
import com.qrhf.service.CompanyService;
import com.qrhf.service.ContractService;
import com.qrhf.service.DepartmentService;
import com.qrhf.service.RealInfoService;
import com.qrhf.service.SysFlowService;
import com.qrhf.service.SysMainService;
import com.qrhf.service.SysRoleResoureService;
import com.qrhf.service.SysRoleService;
import com.qrhf.service.UserService;
import com.qrhf.tools.SendPhoneCode;
import com.qrhf.tools.Tools;
import com.qrhf.tools.TreeviewUtil;
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private ContractService contractService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private SysRoleResoureService sysRoleResoureService;
	@Autowired
	private SysFlowService sysFlowService;
	@Autowired
	private SysMainService sysMainService;
	@Autowired
	private RealInfoService realInfoService;
	@RequestMapping("/tree")
	public @ResponseBody Object tree(int companyId) {
		return TreeviewUtil.conversionDataFromList(departmentService.tree(companyId));
	}

	@RequestMapping("isLogin")
	@ResponseBody
	public String isLogin(HttpServletRequest req) {
		User user = (User) req.getSession().getAttribute("user");
		String userName = "";
		try {
			userName = user.getUserName();
		} catch (Exception e) {
			System.out.println("session为空");
		}
		return userName;
	}
	
	@RequestMapping("/findList")
	public @ResponseBody Object list(int pageSize, int pageNumber, int companyId, int departmentId) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyId", companyId);
		param.put("departmentId", departmentId);
		return userService.findList(param);
	}

	@RequestMapping("/toUpdate")
	public ModelAndView toUpdate(Integer id) {
		ModelAndView mav = new ModelAndView();
		User person = userService.getUserById(id);
		mav.addObject("user",person);
		mav.setViewName("/user/add");
		return mav;
	}

	@RequestMapping("/update")
	public @ResponseBody Integer update(User user) {
		Integer person = userService.updateUser(user);
		return person;
	}

	@RequestMapping("/add")
	public @ResponseBody Integer add(User user) {
		User checkUser = userService.checkEmail(user.getId()==null?0:user.getId(),user.getChare(),""+user.getLoginType());
		if(checkUser == null){
			if(user.getId()==null){
				user.setLoginName(userService.newLoginName());
				if(user.getLoginType()==1) {
					user.setPhone(user.getChare());
					userService.addOrdinaryUser(user);
				}
				else if(user.getLoginType()==2) {
					user.setEmail(user.getChare());
					userService.addOrdinaryUser(user);
				}
			}else{
				user.setLoginName(userService.newLoginName());
				if(user.getLoginType()==1) {
					user.setEmail(user.getChare());
					userService.updateUser(user);
				}else if(user.getLoginType()==2) {
					user.setEmail(user.getChare());
					userService.updateUser(user);
				}
				
			}
			return 1;
		}else{
			return -1;
		}
	}
	
	@RequestMapping("/addStaff")
	public @ResponseBody Integer addStaff(User loginUser,HttpServletRequest request) {
		Integer staff = userService.addStaff(loginUser);
		User user = userService.getUserInfoByLoginName(loginUser.getLoginName());
		request.getSession().setAttribute("user", user);
		return staff;
	}
	
	
	@RequestMapping("/del")
	public @ResponseBody Integer deleteUserById(Integer id) {
		userService.deleteUserById(id);
		return 1;
	}
 
	@RequestMapping("resourceLogin")
	public @ResponseBody Object getResourceByUserId(Integer id,String code) {
		List<SysResource> resourceList = userService.getResoureByUserId(id,code);
		return resourceList;
	}
	
//	@RequestMapping("findResource1")
//	public @ResponseBody Object findResource1(Integer id,Integer pageId) {
//		List<SysResource> reList=userService.findResource1(id,pageId);
////		request.getSession().setAttribute("reList", reList);
//		return reList;
//	}
	
	@RequestMapping("projectList")
	public @ResponseBody Object getResourceStatusByUserId(HttpServletRequest request,Integer id,Integer pageId) {
		List<SysResource> reList=userService.getResoureStatusByUserId(id,pageId);
//		request.getSession().setAttribute("reList", reList);
		return reList;
	}
	@RequestMapping("login")
	public @ResponseBody Map<String,Object> login(boolean rememberMe,HttpSession session,HttpServletRequest request,User loginUser) throws IOException {
		Map<String,Object> map = new HashMap<String, Object>();
		Integer i=null;
		User user = userService.getUserInfoByLoginName(loginUser.getLoginName());
		if (user != null){
//				Date expiryDate = user.getExpiryDate();
				//数据库存储的日期后一天将不能登录
//				Calendar c = Calendar.getInstance(); 
//		        c.setTime(expiryDate); 
//		        c.add(Calendar.DAY_OF_MONTH,+1); 
//		        Date time = c.getTime();
				if (loginUser.getPassword().equals(user.getPassword()) ) {
//					if(new Date().before(time)) {
						i=0;// 登录成功
						map.put("id", user.getId());
						session.setAttribute("user", user);
//						request.getSession().setAttribute("user", user);
						findExpiryDate(user.getId());
//					}else {
//						i = 3;
//					}
				} else {
					i = 1;// 密码不正确
				}
			}else {
				i = 2;// 用户不存在
			}
		map.put("i", i);
		return map;
	}
	@RequestMapping("clearSession")
	public ModelAndView clearSession(HttpServletRequest req,HttpSession session,User user) {
		ModelAndView mav = new ModelAndView("user/login");
		session.invalidate();
//		session.removeAttribute("user");
		return mav;
	}
	private void findExpiryDate(Integer id) {
		List<SysFlow> list = sysMainService.findExpiryDate(id);
		if(list.size()>=1) {
			for (int i = 0; i < list.size(); i++) {
				sysFlowService.deleteNotice(list.get(i));
			}
		}
		User user = userService.getUserById(id);
		Date expiryDate = user.getExpiryDate();
		//数据库存储的日期前一个月提醒
		Calendar c = Calendar.getInstance(); 
        c.setTime(expiryDate); 
        c.add(Calendar.MONTH,1); 
        Date time = c.getTime();
        int remainDate = (int) ((expiryDate.getTime() - new Date().getTime()) / (1000*3600*24))+1;
        if(time.after(expiryDate)&&remainDate<31) {
        	SysFlow sf = new SysFlow();
        	sf.setUserId(id);
        	sf.setTitle(String.valueOf(remainDate));
        	sysFlowService.addExpiryDateNotice(sf); 
        }
	}

	/**
	 * 邮箱
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("emailLogin")
	public @ResponseBody Map<String,Object> emailLogin(HttpServletRequest request, HttpServletResponse response,User us) throws IOException {
		Map<String,Object> map = new HashMap<String, Object>();
		Integer i=null;
		User user = userService.checkEmail(us.getId()==null?0:us.getId(),us.getChare(),""+us.getLoginType());
		if (user != null) {
			map.put("id", user.getId());
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("userName", user.getUserName());
			i = 1;
		} else {
			i = 2;
		}
		map.put("i", i);
		return map;
	}

	/**
	 * 注册
	 * 
	 * @param request
	 * @param response
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping("register")
	public @ResponseBody Object register(HttpServletRequest request,User user,Company company) throws Exception {
		try {
			company.setShareCode(user.getShareCode());
			String code = companyService.newCode();
			company.setCode(code);
			companyService.addCompany(company);
			
			SysRole sysRole = new SysRole();
			sysRole.setName("成本控制人/成本主管/董事长/总经理");
			sysRole.setCode("TZRDB");
			sysRole.setCompanyId(company.getId());
			sysRoleService.add(sysRole);
			
			sysRoleResoureService.initTopResource(sysRole.getId());
			
			String loginName = userService.newLoginName();
			user.setCompanyId(company.getId());
			user.setSysRoleId(sysRole.getId());
			user.setLoginName(loginName);
			if(user.getLoginType()==1){
				user.setPhone(user.getChare());
			}else if(user.getLoginType()==2){
				user.setEmail(user.getChare());
			}
			userService.addUser(user);
			
			Contract contract = new Contract();
			contract.setCompanyId(company.getId());
			contract.setName("虚拟合同.docx");
			contract.setFilePath("xnht.docx");
			contractService.save(contract);
			
			
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("loginName", user.getLoginName());
			request.getSession().setAttribute("userName", user.getUserName());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
	@RequestMapping("phoneCode")
	public void phoneCode(HttpServletRequest request, HttpServletResponse response,User user) throws ClientException, IOException {
		PrintWriter out = response.getWriter();
		String code = (int) ((Math.random() * 9 + 1) * 1000) + "";
		HttpSession se = request.getSession();
		se.setAttribute("code", code);
		//调用短信发送接口，三个参数，手机号，验证码，短信模板
		SendPhoneCode.sendSms(user.getChare(), code,"SMS_135802690", code,null); 
		out.println(code);
	}
	@RequestMapping("sendPhone")
	public void sendPhone(HttpServletRequest request, HttpServletResponse response,User user) throws ClientException, IOException {
		PrintWriter out = response.getWriter();
		Company company = companyService.getById(user.getCompanyId());
		String name=company.getName();
		//调用短信发送接口，三个参数，手机号，验证码，短信模板 这个是发送添加员工的
		SendPhoneCode.sendSms(user.getChare(), name,"SMS_142953743", name,null); 
		out.println(name);
	}
	/**
	 * 发送邮件
	 * 
	 * @param request
	 * @param response
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping("sendEmail")
	public void sendEmail(HttpServletRequest request, HttpServletResponse response, User user) throws Exception {
		PrintWriter out = response.getWriter();
		String code = (int) ((Math.random() * 9 + 1) * 1000) + "";
		System.out.println("注册验证码："+code);
		String receiveMailAccount = user.getChare();
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtps");
		props.setProperty("mail.smtps.host",SystemAttributes.EMAIL_SMTP_HOST); // 发件人的邮箱的 SMTP
		props.put("mail.smtp.socketFactory.port", 456);
		Session session = Session.getInstance(props);
		session.setDebug(true);
		HttpSession se = request.getSession();
		se.setAttribute("code", code);
		MimeMessage message = createMimeMessage(code, session, SystemAttributes.EMAIL_ACCOUNT, receiveMailAccount);
		Transport transport = session.getTransport();
		transport.connect(SystemAttributes.EMAIL_ACCOUNT,SystemAttributes.EMAIL_PASSWORD);
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
		out.println(code);
	}
	/**
	 * 发送邮箱验证码格式
	 * 
	 * @param session
	 * @param myEmailAccount
	 * @param receiveMailAccount
	 * @return
	 */
	public static MimeMessage createMimeMessage(String code, Session session, String sendMail, String receiveMail)
			throws Exception {
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(sendMail,SystemAttributes.COMPANY_NAME, "UTF-8"));
		message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "注册", "UTF-8"));
		message.setSubject(SystemAttributes.COMPANY_NAME+"验证邮件", "UTF-8");
		message.setContent("感谢您使用【"+SystemAttributes.COMPANY_NAME+"】系统，您的注册验证码：" + code + "，如非本人操作，请忽略此邮件。", "text/html;charset=UTF-8");
		message.setSentDate(new Date());
		message.saveChanges();
		return message;
	}
	/**
	 * 判断验证码是否与发送一致
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("checkCode")
	public void checkCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String userCode = request.getParameter("user_code");
		String sessioncode = (String) session.getAttribute("code");
		PrintWriter out = response.getWriter();
		String result = "";
		if (userCode != null && userCode.equals(sessioncode)) {
			result = "2";
		} else {
			result = "1";
		}
		out.write(result.toString());
	}
	
	/**
	 * 添加新用户后的登录邮件
	 * @param user
	 * @throws Exception
	 */
	@RequestMapping("newUserSendEmail")
	public void newUserSendEmail(User user) throws Exception {
		String receiveMailAccount = user.getChare();
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtps");
		props.setProperty("mail.smtps.host",SystemAttributes.EMAIL_SMTP_HOST); // 发件人的邮箱的 SMTP
		props.put("mail.smtp.socketFactory.port", 456);
		Session session = Session.getInstance(props);
		session.setDebug(true);
		MimeMessage message = createMimeMessage(session, SystemAttributes.EMAIL_ACCOUNT, receiveMailAccount);
		Transport transport = session.getTransport();
		transport.connect(SystemAttributes.EMAIL_ACCOUNT,SystemAttributes.EMAIL_PASSWORD);
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}
	/**
	 * 新用户登录发送邮箱验证码格式
	 * 
	 * @param session
	 * @param myEmailAccount
	 * @param receiveMailAccount
	 * @return
	 */
	public static MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail)
			throws Exception {
		MimeMessage message = new MimeMessage(session);
		String url = "http://www.zdcigo.com/user/newUser.jsp";
		message.setFrom(new InternetAddress(sendMail,SystemAttributes.COMPANY_NAME, "UTF-8"));
		message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "注册", "UTF-8"));
		message.setSubject(SystemAttributes.COMPANY_NAME+"验证邮件", "UTF-8");
		message.setContent("感谢您使用【"+SystemAttributes.COMPANY_NAME+"】系统，点击链接进入新用户登录页面：" + url + "，如非本人操作，请忽略此邮件。", "text/html;charset=UTF-8");
		message.setSentDate(new Date());
		message.saveChanges();
		return message;
	}

	
	/**
	 * 验证邮箱是否存在
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("checkLoginEmail")
	public void checkLoginEmail(HttpServletRequest request, HttpServletResponse response,User us) throws IOException {
		PrintWriter out = response.getWriter();
		User user = userService.checkEmail(us.getId()==null?0:us.getId(),us.getChare(),""+us.getLoginType());
		if (user != null) {
			out.println(1);
		} else {
			out.println(2);
		}
	} 

	@RequestMapping("findUserById")
	public @ResponseBody Object findUserById(Integer id, User user) {
		return userService.getUserById(id);
	}

	/**
	 * 登录账号是否存在
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("checkLoginname")
	public void checkLoginname(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String loginName = request.getParameter("loginName");
		User user = userService.loginByUserName(loginName);
		if (user != null) {
			out.println(1);
		} else {
			out.println(2);
		}
	}
	/**
	 * 验证手机号是否存在
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("checkPhone")
	public void checkPhone(HttpServletRequest request, HttpServletResponse response,User us) throws IOException {
		PrintWriter out = response.getWriter();
		String phone=us.getChare();
		User user = userService.checkPhone(phone);
		if (user != null) {
			out.println(1);
		} else {
			out.println(2);
		}
	}

	/**
	 * 根据邮箱，查询一条数据
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping("/toUpdatePassword")
	public ModelAndView toUpdatePassword(String email) {
		ModelAndView mav = new ModelAndView();
		User user = userService.getByEmail(email);
		mav.addObject("user", user);
		mav.setViewName("/user/editPassword");
		return mav;
	}
	/**
	 * 根据邮箱 ，修改密码
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/updatePassword")
	@ResponseBody
	public Integer updatePassword(User user) {
		return userService.updatePassword(user);
	}

	/**
	 * 修改用户密码
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/uPass")
	@ResponseBody
	public Integer uPass(User user) {
		Integer id = userService.upPass(user);
		return id;
	}
	
	@RequestMapping("/updateUserDepartment")
	public @ResponseBody Integer updateUserDepartment(int userId,int departmentId){
		return userService.updateUserDepartment(userId, departmentId);
	}
	@ResponseBody
	@RequestMapping("/dutyUser")
	public Map<String,Object>  findDutyUser(@RequestParam("companyId") Integer companyId) {
		List<User> roleList=userService.findDutyUser(companyId);
		Map<String,Object>map=new HashMap<String, Object>();
		map.put("user", roleList);
		return map;
	}
	
	@RequestMapping("/selectManager")
	@ResponseBody
	public List<User> selectManager(User user){
		return userService.selectManager(user);
	}
	
	@RequestMapping("/selectBuyer")
	@ResponseBody
	public List<User> selectBuyer(User user){
		return userService.selectBuyer(user);
	}
	
	@RequestMapping("/selectPasswrod")
	@ResponseBody
	public Map<String,Object> selectPasswrod(Integer id) {
		Map<String,Object> map = new HashMap<>();
		Integer i = null;
		User user = userService.selectPasswrod(id);
		if(user==null || user.getPassword().equals("")) {
			i = 0;
		}else {
			i = 1;
		}
		map.put("i", i);
		return map;
	}
	
	@RequestMapping("getUserRoleId")
	@ResponseBody
	public int getUserRoleId(int userId) {
		int number=userService.getUserRoleId(userId);
		if(number >0) {
			return 1;
		}else {
			return 2;
		}
	}
	@RequestMapping("findUserTree")
	public @ResponseBody Object findUserTree(int companyId) {
		return TreeviewUtil.conversionDataFromList(userService.findUserTree(companyId));
	}
	@RequestMapping("/updateUser")
	public @ResponseBody Integer updateUser(int userId,int companyId){
		userService.updateUserSysRole(userId, companyId);
		return userService.getUserIdUpdate(userId, companyId);
	}
	@RequestMapping("findAllUserForCompany")
	public @ResponseBody Object findAllUserForCompany(int companyId){
		return userService.findAllUserForCompany(companyId);
	}
	@RequestMapping("addInfo")
	public @ResponseBody int addInfo(RealInfo realInfo){
		int i = realInfoService.addInfo(realInfo); 
		return i;
	}
	@RequestMapping("userAnimation")
	public @ResponseBody void getUserAnimation(HttpServletResponse response,int userId) throws IOException {
		PrintWriter out = response.getWriter();
		User user=userService.getUserPushTimes(userId);
		if(user.getCodeNumber() >0 && user.getPushTimes() <= 7) {
			userService.updateUserAnimation(userId);
			out.println(1);
		}else if(user.getCodeNumber()<1){
			out.println(2);
		}else if(user.getCodeNumber() >0) {
			out.println(3);
		}
	}

	@RequestMapping("/userExpirationDate")
	public @ResponseBody Object userExpirationDate(int pageSize,int pageNumber,String companyName) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyName",Tools.isNotEmptyString(companyName)?Tools.fuzzyQueryString(companyName):null);
		return userService.userExpirationDate(param);
	}
	@RequestMapping("/companyInformation")
	public @ResponseBody Object companyInformation(int pageSize,int pageNumber,String companyName) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyName",Tools.isNotEmptyString(companyName)?Tools.fuzzyQueryString(companyName):null);
		return userService.companyInformation(param);
	}
	@RequestMapping("updateUserExpiryDate")
	public @ResponseBody int updateUserExpiryDate(int companyId,String expiryDate) {
		return userService.updateUserExpiryDate(companyId,expiryDate);
	}

	@RequestMapping("selectUserExpiryDate")
	@ResponseBody
	public int selectUserExpiryDate(int userId) {
		int number =userService.selectUserExpiryDate(userId);
		if(number >= 0) {
			return number;
		}else {
			return -1;
		}
	}
	@RequestMapping("findUserExpiryDate")
	public @ResponseBody Object findUserExpiryDate(int userId){
		return userService.findUserExpiryDate(userId);
	}
	
	@RequestMapping("selectUser")
	public @ResponseBody Object selectUser(int companyId){
		return userService.selectUser(companyId);
	}
}