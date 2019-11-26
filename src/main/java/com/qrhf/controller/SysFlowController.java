package com.qrhf.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.ApprovalRecord;
import com.qrhf.pojo.Consultation;
import com.qrhf.pojo.ConsultationGoods;
import com.qrhf.pojo.ConsultationGoodsForm;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectUpdate;
import com.qrhf.pojo.SysFlow;
import com.qrhf.pojo.User;
import com.qrhf.service.ApprovalRecordService;
import com.qrhf.service.ProjectService;
import com.qrhf.service.ProjectUpdateService;
import com.qrhf.service.SysFlowService;
import com.qrhf.service.UserService;
import com.qrhf.tools.Tools;

@Controller
@RequestMapping("sysFlow")
public class SysFlowController {
	
	@Autowired
	private SysFlowService sysFlowService;
	@Autowired
	private ApprovalRecordService approvalRecordService;
	@Autowired
	private UserService userService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private ProjectUpdateService projectUpdateService;
	
	@RequestMapping("startFlow")
	public @ResponseBody Object startFlow(int sysFlowId,int dutyUserId){
		return sysFlowService.startFlow(sysFlowId,dutyUserId);
	}
	
	@RequestMapping("emptyReason")
	public @ResponseBody Object emptyReason(int sysFlowId){
		return sysFlowService.emptyReason(sysFlowId);
	}
	
	@RequestMapping("reject")
	public @ResponseBody Object reject(SysFlow flow,HttpServletRequest request,String rejectReason) throws UnsupportedEncodingException{
		int i = sysFlowService.reject(flow);
		return i;
		
	}
	/*
	 * 修改后的采购表退回方法
	 */
	@RequestMapping("AgainReject")
	public @ResponseBody Object AgainReject(SysFlow flow,HttpServletRequest request) throws UnsupportedEncodingException{
		flow.setRejectReason(new String(request.getParameter("rejectReason").getBytes("ISO8859-1"),"UTF-8")); 
		int i = sysFlowService.reject(flow);
		return i;
		
	}
	/*@RequestMapping("reject")
	public @ResponseBody Object reject(int sysFlowId,String rejectReason,HttpServletRequest request) throws UnsupportedEncodingException{
		rejectReason = new String(request.getParameter("rejectReason").getBytes("ISO8859-1"),"UTF-8");
		int i = sysFlowService.reject(sysFlowId,rejectReason);
		return i;
	}
*/	
	@RequestMapping("confirmed")
	public @ResponseBody Object confirmed(int sysFlowId){
		return sysFlowService.confirmed(sysFlowId);
	}
	
	@RequestMapping("updateStatus")
	public @ResponseBody int updateStatus(int sysFlowId,int status){
		return sysFlowService.updateStatus(sysFlowId,status);
	}
	
	
	@RequestMapping("submitAgain")
	public @ResponseBody int submitAgain(int sysFlowId){
		return sysFlowService.submitAgain(sysFlowId);
	}
	
	@RequestMapping("submitTable")
	@ResponseBody
	public int submitTable(ProjectUpdate projectUpdate,HttpServletRequest req) {
		User user = (User) req.getSession().getAttribute("user");
		int sys = sysFlowService.submitTable(projectUpdate.getProject(),projectUpdate.getId(),user); 
		if(sys == 1){
			projectUpdateService.updateProjectUpdate(projectUpdate);
		}
		return sys;
	}
	@RequestMapping("approvalResults")
	@ResponseBody
	public void approvalResults(HttpServletRequest req,ApprovalRecord record) {
		User user = (User) req.getSession().getAttribute("user");
		List<Integer> InvestorsIds = userService.selectInvestorsId(user.getCompanyId());
		for (Integer InvestorsId : InvestorsIds) {
			record.setUserId(InvestorsId);
			approvalRecordService.addRecord(record);
		}
	}
	
	@RequestMapping("updateApprovalStatus")
	@ResponseBody
	public void updateApprovalStatus(ApprovalRecord record) {
		approvalRecordService.updateApprovalStatus(record);
	}
	
	@RequestMapping("addOpinion")
	@ResponseBody
	public int addOpinion(ApprovalRecord record) {
		return approvalRecordService.addOpinion(record);
	}
	
	@RequestMapping("addMsg")
	@ResponseBody
	public void addMsg(SysFlow sf) {
		List<Project> projects = projectService.selectStaff(sf);
		sysFlowService.addMsg(projects);
	}
	
	@RequestMapping("deleteNotice")
	@ResponseBody
	public int deleteNotice(SysFlow sf) {
		return sysFlowService.deleteNotice(sf);
	}
	
	@RequestMapping("checkIsUpdateGoodsAll")
	@ResponseBody
	public int checkIsUpdateGoodsAll(int projectOrderId){
		return sysFlowService.checkIsUpdateGoodsAll(projectOrderId);
	}
	@RequestMapping("temporaryBatch")
	public @ResponseBody Object temporaryBatch(SysFlow sysFlow){
		return sysFlowService.temporaryBatch(sysFlow);
	}
	@RequestMapping("updateTemporaryBatch")
	public @ResponseBody Object updateTemporaryBatch(int sysFlowId,int num){
		return sysFlowService.updateTemporaryBatch(sysFlowId, num);
	}
	@RequestMapping("/selectBatch")
	public @ResponseBody int selectBatch(Integer projectId,Integer buyerId) {
		Integer number=sysFlowService.selectBatch(projectId,buyerId);
		if(number >0) {
			return 0;
		}else {
			return 1;
		}
	}
	@RequestMapping("saveConsultation")
	public @ResponseBody int saveConsultation(int sysFlowId,String userIds){
		List<Consultation> list = new ArrayList<Consultation>();
		String[] ids = userIds.split(",");
		for(String id : ids){
			Consultation consultation = new Consultation();
			consultation.setSysFlowId(sysFlowId);
			consultation.setUserId(Integer.valueOf(id));
			list.add(consultation);
		}
		return sysFlowService.saveConsultation(list);
	}
	@RequestMapping("saveConsultationGoods")
	public @ResponseBody int saveConsultationGoods(ConsultationGoodsForm consultationGoodsForm){
		List<ConsultationGoods> list = consultationGoodsForm.getConsultationGoodss();
		for(int i=0;i<list.size();i++){
			ConsultationGoods consultationGoods = list.get(i);
			if(!Tools.isNotEmptyString(consultationGoods.getIdea())){
				list.remove(i);
				i--;
			}
		}
		if(list.size()>0)
		return sysFlowService.saveConsultationGoods(list);
		return 1;
	}
	
}
