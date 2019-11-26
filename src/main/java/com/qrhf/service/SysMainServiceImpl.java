package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.SysMainMapper;
import com.qrhf.pojo.ApplyExpiryDate;
import com.qrhf.pojo.Consultation;
import com.qrhf.pojo.SysFlow;

@Service
public class SysMainServiceImpl implements SysMainService {
	
	@Autowired
	private SysMainMapper sysMainMapper;

	@Override
	public List<SysFlow> findSysFlowList(int userId) {
		return sysMainMapper.findSysFlowList(userId);
	}

	/*@Override
	public List<SysFlow> findSKBSysFlowList(Integer userId) {
		return sysMainMapper.findSKBSysFlowList(userId);
	}*/

	@Override
	public List<SysFlow> findNotPassProjectOrder(Integer userId) {
		return sysMainMapper.findNotPassProjectOrder(userId);
	}

	@Override
	public List<SysFlow> findProjectOrderSubmitAgain(Integer userId) {
		return sysMainMapper.findProjectOrderSubmitAgain(userId);
	}

	@Override
	public List<SysFlow> uploadNotice(Integer userId) {
		return sysMainMapper.uploadNotice(userId); 
	}

	@Override
	public List<SysFlow> findProject(Integer userId) {
		return sysMainMapper.findProject(userId);
	}

	@Override
	public List<SysFlow> unconfirmedCGB(Integer userId) {
		return sysMainMapper.unconfirmedCGB(userId);
	}

	@Override
	public List<SysFlow> deleteProjectOrderNotice(Integer userId) {
		return sysMainMapper.deleteProjectOrderNotice(userId);
	}

	@Override
	public List<SysFlow> findExpiryDate(Integer userId) {
		return sysMainMapper.findExpiryDate(userId);
	}

	@Override
	public List<SysFlow> findTemporaryBatch(Integer companyId) {
		return sysMainMapper.findTemporaryBatch(companyId);
	}

	@Override
	public List<SysFlow> selectTemporaryBatch(Integer userId) {
		return sysMainMapper.selectTemporaryBatch(userId);
	}

	@Override
	public List<SysFlow> deleteTemporaryBatch(Integer userId) {
		return sysMainMapper.deleteTemporaryBatch(userId);
	}

	@Override
	public List<ApplyExpiryDate> findApplyExpiryDate(Integer companyId) {
		return sysMainMapper.findApplyExpiryDate(companyId);
	}

	@Override
	public List<SysFlow> showAllTable(Integer companyId) {
		return sysMainMapper.showAllTable(companyId); 
	}

	@Override
	public List<Consultation> findConsultation(Integer userId) {
		return sysMainMapper.findConsultation(userId);
	}
}
