package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Contract;
import com.qrhf.pojo.ContractInvoice;
import com.qrhf.pojo.ContractPay;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectOrder;

public interface ContractService {

	public Map<String, Object> findList(Map<String, Object> param);

	public int insertContract(Contract contract);

	public int del(int contractId);
	
	public List<Project> selectProject(int userId);

	public List<ProjectOrder> selectProjectOrder(int projectId);

	public void save(Contract contract);

	public int update(Contract contract);
	
	public Contract findContractFilePath(int contractId);
	
	public List<Project> findProjectList(Map<String, Object> param);
	
	public List<ProjectOrder> findProjectOrderList(int projectId,int contractId);

	public Contract selectNameByProjectOrderId(int projectOrderId);
	
	public int contractPay(ContractPay contractPay);
	
	public List<ContractPay> contractPayList(int contractId);
	
	public int contractPayDel(int contractPayId);
	
	public int contractInvoice(ContractInvoice contractInvoice);
	
	public List<ContractInvoice> contractInvoiceList(int contractId);
	
	public int contractInvoiceDel(int contractInvoiceId);
	
}
