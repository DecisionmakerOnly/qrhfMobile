package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Contract;
import com.qrhf.pojo.ContractInvoice;
import com.qrhf.pojo.ContractPay;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.vo.ContractListGoodsVO;

public interface ContractMapper {

	public List<Contract> findList(Map<String, Object> param);

	public int insertContract(Contract contract);

	public void del(int contractId);
	
	public void delContractList(int contractId);
	
	public void delContractListGoods(int contractId);
	
	public void contractDel(int projectId);

	public void contractProjectOrderDel(int projectOrderId);

	public List<Project> selectProject(int userId);

	public List<ProjectOrder> selectProjectOrder(int projectId);

	public List<ContractListGoodsVO> findProjectOrder(int projectOrderId);

	public void save(Contract contract);

	public void update(Contract contract);

	public Contract findContractFilePath(int contractId);
	
	public List<Project> findProjectList(Map<String, Object> param);
	
	public List<ProjectOrder> findProjectOrderList(@Param("projectId")int projectId,@Param("contractId") int contractId);

	public Contract selectNameByProjectOrderId(int projectOrderId);
	
	public void contractPay(ContractPay contractPay);
	
	public List<ContractPay> contractPayList(int contractId);
	
	public void contractPayDel(int contractPayId);
	
	public void contractInvoice(ContractInvoice contractInvoice);
	
	public List<ContractInvoice> contractInvoiceList(int contractId);
	
	public void contractInvoiceDel(int contractInvoiceId);
	
}
