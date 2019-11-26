package com.qrhf.dao;

import java.util.List;

import com.qrhf.pojo.ApplyExpiryDate;
import com.qrhf.pojo.Consultation;
import com.qrhf.pojo.SysFlow;

public interface SysMainMapper {

	public List<SysFlow> findSysFlowList(int userId);

	public List<SysFlow> findSKBSysFlowList(Integer userId);

	public List<SysFlow> findNotPassProjectOrder(Integer userId);

	public List<SysFlow> findProjectOrderSubmitAgain(Integer userId);

	public List<SysFlow> uploadNotice(Integer userId);

	public List<SysFlow> findProject(Integer userId);

	public List<SysFlow> unconfirmedCGB(Integer userId);

	public List<SysFlow> deleteProjectOrderNotice(Integer userId);

	public List<SysFlow> findExpiryDate(Integer userId);
	
	public List<SysFlow> findTemporaryBatch(Integer companyId);
	
	public List<SysFlow> selectTemporaryBatch(Integer userId);
	
	public List<SysFlow> deleteTemporaryBatch(Integer userId);
	
	public List<ApplyExpiryDate> findApplyExpiryDate(Integer companyId);

	public List<SysFlow> showAllTable(Integer companyId);
	
	public List<Consultation> findConsultation(Integer userId);

}
