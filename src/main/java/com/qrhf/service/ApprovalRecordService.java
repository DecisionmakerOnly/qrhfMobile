package com.qrhf.service;

import java.util.List;

import com.qrhf.pojo.ApprovalRecord;
import com.qrhf.pojo.User;

public interface ApprovalRecordService {

	public void addRecord(ApprovalRecord record);

	public List<ApprovalRecord> findApprovalResults(User user);

	public void updateApprovalStatus(ApprovalRecord record);

	public int addOpinion(ApprovalRecord record);

	public List<ApprovalRecord> findApprovalRecord(Integer companyId);

}
