package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ContractListGoodsMapper;
import com.qrhf.dao.ContractListMapper;
import com.qrhf.dao.ProjectOrderGoodsMapper;
import com.qrhf.dao.ProjectOrderMapper;
import com.qrhf.dao.SysFlowMapper;
import com.qrhf.dao.TemporaryProjectGoodMapper;
import com.qrhf.pojo.ContractList;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.TemporaryProjectGoods;

@Service
public class ProjectOrderGoodsServiceImpl implements ProjectOrderGoodsService {

	@Resource
	private ProjectOrderGoodsMapper projectOrderGoodsMapper;
	@Resource
	private SysFlowMapper sysFlowMapper;
	@Autowired
	private ContractListMapper contractListMapper;
	@Autowired
	private ContractListGoodsMapper contractListGoodsMapper;
	@Autowired
	private ProjectOrderGoodsMapper pogMapper;
	@Autowired
	private ProjectOrderMapper projectOrderMapper;
	@Autowired
	private TemporaryProjectGoodMapper temporaryProjectGoodsMapper;

	@Override
	public void insertAll(List<ProjectOrderGoods> projectOrderGoodsList) {
		projectOrderGoodsMapper.insertAll(projectOrderGoodsList);
	}

	@Override
	public List<ProjectOrderGoods> list(int projectOrderId) {
		return projectOrderGoodsMapper.list(projectOrderId);
	}

	@Override
	public List<ProjectOrder> selectOrder(int projectId) {
		return projectOrderGoodsMapper.selectOrder(projectId);
	}

	@Override
	public List<ProjectOrderGoods> findList(Map<String, Object> param) {
		return projectOrderGoodsMapper.findList(param);
	}

	@Override
	public Map<String, Object> statistics(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("startDate",param.get("startDate"));
		sizeMap.put("endDate",param.get("endDate"));
		int total=projectOrderGoodsMapper.findList(sizeMap).size();
		List<ProjectOrderGoods> rows = projectOrderGoodsMapper.statistics(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public Map<String, Object> orderDetail(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		int total = projectOrderGoodsMapper.orderDetail(sizeMap).size();
		List<ProjectOrderGoods> rows = projectOrderGoodsMapper.orderDetail(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public void compareGoods(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		Integer projectGroupId = projectOrderGoodsMapper.findProjectGroupId((int) param.get("projectOrderId"));
		map.put("projectId", param.get("projectId"));
		map.put("projectOrderId", param.get("projectOrderId"));
		map.put("projectGroupId", projectGroupId);
		projectOrderGoodsMapper.updateStatus(map);			//pog表所有数据status置零后再进行对比
		int pogNotExist = projectOrderGoodsMapper.updateStatusNotExist(map);		//更改采购表有而项目采购控制表没有商品的状态
		int priceCount = 0;
		int amountCount = 0;
		if (projectGroupId != null && projectGroupId != 0) {
			amountCount = projectOrderGoodsMapper.updatePriceStatusForProjectGroup(map);
			priceCount = projectOrderGoodsMapper.updateAmountStatusForProjectGroup(map);
		} else {
			try {
				amountCount = projectOrderGoodsMapper.updateAmountStatus(map);
				priceCount = projectOrderGoodsMapper.updatePriceStatus(map);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(priceCount>0 || amountCount>0 || pogNotExist >0) {
			map.put("status", -3);
			sysFlowMapper.updateSfStatus(map);
		}
//		else{
//			ProjectOrder projectOrder = projectOrderMapper.getProjectOrderById((int)param.get("projectOrderId"));
//			ContractList contractList = new ContractList();
//			contractList.setProjectId(projectOrder.getProjectId());
//			contractList.setProjectOrderId(projectOrder.getId());
//			contractList.setContractId(projectOrder.getContractId());
//			contractListMapper.save(contractList);
//			contractListGoodsMapper.saves(contractList.getId(),projectOrder.getId());
//		}
	}

	@Override
	public Map<String, Object> mismatch(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		int total = projectOrderGoodsMapper.mismatch(sizeMap).size();
		List<ProjectOrderGoods> rows = projectOrderGoodsMapper.mismatch(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public void remove(ProjectOrder projectOrder) {
		sysFlowMapper.delete(projectOrder.getId());
		contractListMapper.contractListDel(projectOrder.getId());
		contractListGoodsMapper.contractListGoodsDel(projectOrder.getId());
		pogMapper.ProjectOrderGoodsDelete(projectOrder.getId());
		projectOrderGoodsMapper.remove(projectOrder);
	}

	@Override
	public Map<String, Object> notPass(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		int total = projectOrderGoodsMapper.notPass(sizeMap).size();
		List<ProjectOrderGoods> rows = projectOrderGoodsMapper.notPass(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public TemporaryProjectGoods getById(int projectOrderGoodsId) {
		ProjectOrderGoods pog = projectOrderGoodsMapper.getById(projectOrderGoodsId);
		int i = temporaryProjectGoodsMapper.selectCountPogId(pog.getId());
		TemporaryProjectGoods tpg = null;
		if(i==0) {
			int j = temporaryProjectGoodsMapper.addProjectOrderGoods(pog);
			if(j == 1) {
				tpg = temporaryProjectGoodsMapper.selectByPogId(pog.getId());
			}
		}
		tpg = temporaryProjectGoodsMapper.selectByPogId(pog.getId());
		return tpg;
	}

	@Override
	public int deletePOG(int projectOrderGoodsId) {
		return projectOrderGoodsMapper.deletePOG(projectOrderGoodsId);
	}

	@Override
	public int editProjectOrderGoods(ProjectOrderGoods orderGoods) {
		orderGoods.setTotal(orderGoods.getPrice() * orderGoods.getAmount());
		// orderGoods.setStatus(4);
		return projectOrderGoodsMapper.updateByPrimaryKeySelective(orderGoods);
	}


	@Override
	public int deleteProjectOrder(int projectOrderId) {
		sysFlowMapper.delete(projectOrderId);
		projectOrderMapper.projectOrderRemove(projectOrderId);
		int pog = projectOrderGoodsMapper.deleteProjectOrder(projectOrderId);
		return pog;
	}

	@Override
	public void updateIsModify(List<ProjectOrderGoods> pogs) {
		projectOrderGoodsMapper.updateIsModify(pogs);		
	}

	@Override
	public int delpog(int projectOrderId) {
		return projectOrderGoodsMapper.delpog(projectOrderId);
	}

	@Override
	public Map<String, Object> edit(Map<String, Object> param) {
		List<ProjectOrderGoods> tpgList = projectOrderGoodsMapper.edit(param);
 
		for (int i = 0; i < tpgList.size(); i++) {
			if(tpgList.get(i).getTpgId()!=null) {
				tpgList.get(i).setPrice(tpgList.get(i).gettPrice());
				tpgList.get(i).setAmount(tpgList.get(i).gettAmount());
				tpgList.get(i).setTotal(tpgList.get(i).gettTotal());
				tpgList.get(i).setStatus(tpgList.get(i).gettStatus());
			}
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		int total = tpgList.size();
		List<ProjectOrderGoods> rows = tpgList;
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}
	
/*	@Override
	public Map<String, Object> edit(Map<String, Object> param) {
		List<ProjectOrderGoods> tpgList = projectOrderGoodsMapper.edit(param);
		List<ProjectOrderGoods> pogList = projectOrderGoodsMapper.pogList(param);
		
		for (int i = 0; i < pogList.size(); i++) {
			for (int j = 0; j < tpgList.size(); j++) {
				if(pogList.get(i).getId().equals(tpgList.get(j).getProjectOrderGoodsId())) {
					pogList.get(i).setPrice(tpgList.get(j).getPrice());
					pogList.get(i).setAmount(tpgList.get(j).getAmount());
					pogList.get(i).setTotal(tpgList.get(j).getTotal());
					pogList.get(i).setStatus(tpgList.get(j).getStatus());
				}
			}
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		sizeMap.put("status", param.get("status"));
		int total = projectOrderGoodsMapper.pogList(sizeMap).size();
		List<ProjectOrderGoods> rows = pogList;
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}
	
*/	
	
	@Override
	public int deleteAll(Map<String, Integer> param) {
		return projectOrderGoodsMapper.deleteAll(param);
	}

	@Override
	public Map<String, Object> orderBack(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		int total = projectOrderGoodsMapper.orderBack(sizeMap).size();
		List<ProjectOrderGoods> rows = projectOrderGoodsMapper.orderBack(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public int selectById(int projectOrderGoodsId) {
		int count = temporaryProjectGoodsMapper.selectCountPogId(projectOrderGoodsId);
		int tpg;
		if(count == 0) {
			ProjectOrderGoods pog = projectOrderGoodsMapper.selectById(projectOrderGoodsId);
			pog.setStatus(0);
			tpg = temporaryProjectGoodsMapper.addProjectOrderGoods(pog);
		}else {
			tpg = temporaryProjectGoodsMapper.updateStatusByPogId(projectOrderGoodsId);
		}
		return tpg;
	}

	@Override
	public int deleteAll(int projectOrderId) {
		//根据poId查询临时表是否有数据
		List<TemporaryProjectGoods> list =  temporaryProjectGoodsMapper.selectByProjectOrderId(projectOrderId);
		int j = 0;
		int k = 0;
		if(list == null || list.size()==0) {	//如果没有就把所有未通过的数据插入临时表 
			j = temporaryProjectGoodsMapper.deleteAll(projectOrderId);
		}else {
			for (int i = 0; i < list.size(); i++) {	//如果存在就先把临时表中存在的数据删除 再插入 避免数据重复
				temporaryProjectGoodsMapper.deleteByProjectOrderId(projectOrderId);
				k++;
			}
			if(k>0) {
				j = temporaryProjectGoodsMapper.deleteAll(projectOrderId);
			}
		}
		return j;
	}


	@Override
	public Map<String, Object> modifiedData(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		int total = projectOrderGoodsMapper.modifiedData(sizeMap).size();
		List<ProjectOrderGoods> rows = projectOrderGoodsMapper.modifiedData(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}

	@Override
	public int selectNotPass(Integer projectOrderId) {
		return projectOrderGoodsMapper.selectNotPass(projectOrderId);
	}
	@Override
	public int selectDelPass(Integer projectOrderId) {
		return projectOrderGoodsMapper.selectDelPass(projectOrderId);
	}
	@Override
	public int havePassedDel(Integer projectOrderId) {
		return projectOrderGoodsMapper.havePassedDel(projectOrderId);
	}
	@Override
	public int deleteProjectOrderAll(int projectOrderId) {
		return projectOrderGoodsMapper.deleteProjectOrderAll(projectOrderId);
	}

	@Override
	public int selectPogExtra(int projectOrderId) {
		return projectOrderGoodsMapper.selectPogExtra(projectOrderId); 
	}

	@Override
	public int selectStatus(int id) {
		return projectOrderGoodsMapper.selectStatus(id);
	}

	@Override
	public int deleteById(int projectOrderGoodsId) {
		return projectOrderGoodsMapper.deleteById(projectOrderGoodsId);
	}

	@Override
	public int deletePogExtra(int projectOrderId) {
		return  projectOrderGoodsMapper.deletePogExtra(projectOrderId);
	}

	@Override
	public int deleteProUseless(int projectOrderId) {
		return projectOrderGoodsMapper.deleteProUseless(projectOrderId);
	}

	@Override
	public Map<String, Object> detail(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> sizeMap = new HashMap<String, Object>();
		sizeMap.put("projectOrderId", param.get("projectOrderId"));
		sizeMap.put("projectId", param.get("projectId"));
		int total = projectOrderGoodsMapper.detail(sizeMap).size(); 
		List<ProjectOrderGoods> rows = projectOrderGoodsMapper.detail(param);
		result.put("total", total);
		result.put("rows", rows);
		return result;
	}
	@Override
	public List<ProjectOrderGoods> projectOrdeExport(Map<String, Object> param) {
		return projectOrderGoodsMapper.projectOrdeExport(param);
	}


}
