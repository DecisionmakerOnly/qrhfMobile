package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Consultation;
import com.qrhf.pojo.ConsultationGoods;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.SysFlow;

public interface SysFlowMapper {

	public int insert(SysFlow flow);

	public void failOrder(Map<String, Object> param);
	
	public List<SysFlow> findSysFlow(Integer userId);

	public int reject(@Param("sysFlowId")int sysFlowId,@Param("rejectReason")String rejectReason);
	
	public int confirmed(int sysFlowId);
	
	public void delete(int projectOrderId);
	
	public void temporaryAuthority(SysFlow sysFlow);

	public int addSKTable(SysFlow sysFlow);

	public int updateStatus(@Param("sysFlowId") int sysFlowId, @Param("status") int status);

	public int updateSfStatus(Map<String, Object> par);
	
	public void startFlow(@Param("sysFlowId")int sysFlowId);
	
	public Integer selectSysFlow(Integer projectId);

	public void addMsg(List<Project> project);

	public int deleteNotice(SysFlow sf);

	public int reject(SysFlow flow);

	public int updateStatus(int sysFlowId);

	public int submitAgain(int sysFlowId);
	
	public List<ProjectOrderGoods> checkIsUpdateGoodsAll(int projectOrderId);

	public int emptyReason(int sysFlowId);
	
	public int updateDutyUser(@Param("sysFlowId")int sysFlowId,@Param("dutyUserId")int dutyUserId);

	public int deleteProjectOrderNotice(SysFlow sysFlow);

	public void addExpiryDateNotice(SysFlow sf);
	
	public int temporaryBatch(SysFlow sysFlow);
	
	public int updateTemporaryBatch(@Param("sysFlowId")int sysFlowId,@Param("num")int num);
	
	public int selectBatch(@Param("projectId")Integer projectId,@Param("buyerId")Integer buyerId);
	
	public void saveConsultation(List<Consultation> list);
	
	public void saveConsultationGoods(List<ConsultationGoods> list);
	
	public void updateConsultationStatus(@Param("consultationId")int consultationId,@Param("status")int status);
	
	public void deleteConsultation(int sysFlowId);
	
	public void deleteConsultationGoods(int sysFlowId);
}
