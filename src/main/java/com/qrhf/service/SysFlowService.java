package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Consultation;
import com.qrhf.pojo.ConsultationGoods;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.SysFlow;
import com.qrhf.pojo.User;

public interface SysFlowService {

	public int insert(SysFlow flow);

	public void failOrder(Map<String, Object> param);

	public List<SysFlow> findSysFlow(Integer userId);
	
	public int reject(int sysFlowId,String rejectReason);
	
	public int confirmed(int sysFlowId);
	
	public void delete(int projectOrderId);

	public int submitTable(int projectId,int projectUpdateId,User user);

	public int updateStatus(int sysFlowId, int status);

	public int updateStatus(Map<String, Object> par);

//	public int submitCGB(ProjectOrderGoods orderGoods, User user);
	
	public int startFlow(int sysFlowId,int dutyUserId);
	
	public Integer selectSysFlow(Integer projectId);

	public void addMsg(List<Project> projects);

	public int deleteNotice(SysFlow sf);

	public int reject(SysFlow flow);

	public int submitAgain(int sysFlowId);
	
	public int checkIsUpdateGoodsAll(int projectOrderId);

	public int emptyReason(int sysFlowId);

	public int deleteProjectOrderNotice(SysFlow sysFlow);

	public void addExpiryDateNotice(SysFlow sf);
	
	public int temporaryBatch(SysFlow sysFlow);
	
	public int updateTemporaryBatch(int sysFlowId,int num);
	
	public int selectBatch(Integer projectId,Integer buyerId);
	
	public int saveConsultation(List<Consultation> list);
	
	public int saveConsultationGoods(List<ConsultationGoods> list);
	
}
