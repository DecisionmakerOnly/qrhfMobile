package com.qrhf.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ApprovalRecordMapper;
import com.qrhf.pojo.ApprovalRecord;
import com.qrhf.pojo.User;
@Service
public class ApprovalRecordServiceImpl implements ApprovalRecordService{

	@Autowired
	private ApprovalRecordMapper approvalRecordMapper;
	
	@Override
	public void addRecord(ApprovalRecord record) {
		approvalRecordMapper.addRecord(record);
	}

	@Override
	public List<ApprovalRecord> findApprovalResults(User user) {
		return approvalRecordMapper.findApprovalResults(user); 
	}

	@Override
	public void updateApprovalStatus(ApprovalRecord record) {
		approvalRecordMapper.updateApprovalStatus(record);		
	}

	@Override
	public int addOpinion(ApprovalRecord record) {
		return approvalRecordMapper.addOpinion(record);
	}

	@Override
	public List<ApprovalRecord> findApprovalRecord(Integer companyId) {
		return approvalRecordMapper.findApprovalRecord(companyId);
	}

}
