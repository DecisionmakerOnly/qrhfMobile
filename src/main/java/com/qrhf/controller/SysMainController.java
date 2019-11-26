package com.qrhf.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.qrhf.pojo.ApplyExpiryDate;
import com.qrhf.pojo.ApprovalRecord;
import com.qrhf.pojo.Consultation;
import com.qrhf.pojo.SysFlow;
import com.qrhf.pojo.SysLog;
import com.qrhf.pojo.User;
import com.qrhf.service.ApprovalRecordService;
import com.qrhf.service.SysLogService;
import com.qrhf.service.SysMainService;
import com.qrhf.service.SysResourceService;
import com.qrhf.service.SysRoleService;
import com.qrhf.vo.TemporaryAuthorityVO;

@Controller
@RequestMapping("sysMain")
public class SysMainController {
	
	@Autowired
	private SysLogService sysLogService;
	@Autowired
	private SysMainService sysMainService;
	@Autowired
	private SysResourceService sysResourceService;
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private ApprovalRecordService approvalRecordService;
	
	@RequestMapping("homePage")
	public ModelAndView homePage(HttpServletRequest request,String showTables) {
		ModelAndView mav = new ModelAndView();
		User user = (User) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		Integer companyId = user.getCompanyId();
		String code = sysRoleService.selectInvestorsCode(userId);
		if(code!=null&&"TZR".equals(code)) { 
			List<ApprovalRecord> approvalList = approvalRecordService.findApprovalResults(user);
			mav.addObject("approvalList",approvalList);
		}
//		if(companyRoleService.checkTopRole(userId)>0 && code.equals("TZRDB")==true ){
		if(code.equals("TZRDB")==true ){
			List<TemporaryAuthorityVO> taVOList = sysResourceService.findTemporaryAuthorityVOList(user.getCompanyId());
			mav.addObject("taVOList",taVOList);
			List<ApprovalRecord> recordList = approvalRecordService.findApprovalRecord(user.getCompanyId());
			mav.addObject("recordList",recordList);
			List<SysFlow> sfList=sysMainService.findTemporaryBatch(companyId);
			mav.addObject("sfList",sfList);
			List<ApplyExpiryDate> aedList=sysMainService.findApplyExpiryDate(companyId);
			mav.addObject("aedList",aedList);
			mav.addObject("isBoss",1);
			if("1".equals(showTables)) {
				List<SysFlow> allTables = sysMainService.showAllTable(companyId);
				mav.addObject("allTables", allTables);
			}
		}
		List<SysFlow> list = sysMainService.findSysFlowList(userId);
		mav.addObject("list", list);
		List<SysFlow> projectList = sysMainService.findProject(userId);
		mav.addObject("projectList", projectList);
		List<SysFlow> projectOrderList = sysMainService.findNotPassProjectOrder(userId);
		mav.addObject("projectOrderList", projectOrderList);
		List<SysFlow> againProjectOrderList = sysMainService.findProjectOrderSubmitAgain(userId); 
		mav.addObject("againProjectOrderList", againProjectOrderList);
		List<SysFlow> uploadNoticeList = sysMainService.uploadNotice(userId);  
		mav.addObject("uploadNoticeList", uploadNoticeList);
		List<SysFlow> unconfirmedList = sysMainService.unconfirmedCGB(userId);
		mav.addObject("unconfirmedList", unconfirmedList);
		List<SysFlow> deleteNoticeList = sysMainService.deleteProjectOrderNotice(userId);
		mav.addObject("deleteNoticeList", deleteNoticeList);
		List<SysFlow> expiryDateList = sysMainService.findExpiryDate(userId);
		mav.addObject("expiryDateList", expiryDateList);
		List<SysFlow> temporaryBatchList = sysMainService.selectTemporaryBatch(userId);
		mav.addObject("temporaryBatchList", temporaryBatchList);
		List<SysFlow> delTemporaryBatchList = sysMainService.deleteTemporaryBatch(userId);
		mav.addObject("delTemporaryBatchList",delTemporaryBatchList);
		List<Consultation> consultationList = sysMainService.findConsultation(userId);
		mav.addObject("consultationList",consultationList);
		
		List<SysLog> sysLogList = sysLogService.findList(companyId,userId);
		mav.addObject("sysLogList", sysLogList);
		
		mav.setViewName("homePage");
		return mav;
	}
	
}
