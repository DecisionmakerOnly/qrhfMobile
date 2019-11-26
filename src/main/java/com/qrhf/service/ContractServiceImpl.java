package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ContractMapper;
import com.qrhf.pojo.Contract;
import com.qrhf.pojo.ContractInvoice;
import com.qrhf.pojo.ContractPay;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectOrder;

@Service
public class ContractServiceImpl implements ContractService {
	
	@Autowired
	private ContractMapper contractMapper;
	
	@Override
	public int insertContract(Contract contract) {
		return contractMapper.insertContract(contract);
	}

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		if(param.get("status")!=null)
		sizeMap.put("status",param.get("status"));
		sizeMap.put("companyId",param.get("companyId"));
		sizeMap.put("userId",param.get("userId"));
		int total=contractMapper.findList(sizeMap).size();
		List<Contract> rows=contractMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public List<ProjectOrder> selectProjectOrder(int companyId) {
		return contractMapper.selectProjectOrder(companyId);
	}

	@Override
	public List<Project> selectProject(int userId) {
		return contractMapper.selectProject(userId);
	}

	@Override
	public int del(int contractId) {
		try {
			contractMapper.delContractListGoods(contractId);
			contractMapper.delContractList(contractId);
			contractMapper.del(contractId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public int update(Contract contract) {
		try {
			contractMapper.update(contract);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public Contract findContractFilePath(int contractId) {
		return contractMapper.findContractFilePath(contractId);
	}

	@Override
	public void save(Contract contract) {
		contractMapper.save(contract);
	}

	@Override
	public List<Project> findProjectList(Map<String, Object> param) {
		return contractMapper.findProjectList(param);
	}

	@Override
	public List<ProjectOrder> findProjectOrderList(int projectId,int contractId) {
		return contractMapper.findProjectOrderList(projectId,contractId);
	}

	@Override
	public Contract selectNameByProjectOrderId(int projectOrderId) {
		/*Contract contract = contractMapper.selectNameByProjectOrderId(projectOrderId);
		String name = contract.getName();
		String str = name.substring(0, name.lastIndexOf('.'));
		contract.setName(str);*/
		return contractMapper.selectNameByProjectOrderId(projectOrderId);
	}

	@Override
	public int contractPay(ContractPay contractPay) {
		try {
			contractMapper.contractPay(contractPay);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<ContractPay> contractPayList(int contractId) {
		return contractMapper.contractPayList(contractId);
	}

	@Override
	public int contractInvoice(ContractInvoice contractInvoice) {
		try {
			contractMapper.contractInvoice(contractInvoice);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<ContractInvoice> contractInvoiceList(int contractId) {
		return contractMapper.contractInvoiceList(contractId);
	}

	@Override
	public int contractPayDel(int contractPayId) {
		try {
			contractMapper.contractPayDel(contractPayId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int contractInvoiceDel(int contractInvoiceId) {
		try {
			contractMapper.contractInvoiceDel(contractInvoiceId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

}
