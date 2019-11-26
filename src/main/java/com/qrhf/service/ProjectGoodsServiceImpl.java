package com.qrhf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.GoodsMapper;
import com.qrhf.dao.ProjectGoodsBakMapper;
import com.qrhf.dao.ProjectGoodsMapper;
import com.qrhf.dao.ProjectGroupGoodsMapper;
import com.qrhf.dao.ProjectGroupMapper;
import com.qrhf.dao.ProjectUpdateGoodsMapper;
import com.qrhf.dao.ProjectUpdateMapper;
import com.qrhf.dao.ProjectUpdateResourceMapper;
import com.qrhf.dao.TemporaryProjectGoodMapper;
import com.qrhf.pojo.ProjectGoods;
import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.TemporaryProjectGoods;
import com.qrhf.tools.Tools;

@Service("projectGoodsService")
public class ProjectGoodsServiceImpl implements ProjectGoodsService {
	@Autowired
	private ProjectGoodsMapper projectGoodsMapper;
	@Autowired
	private ProjectGoodsBakMapper projectGoodsBakMapper;
	@Autowired
	private GoodsMapper goodsMapper;
	@Autowired
	private TemporaryProjectGoodMapper tprojectGoodsMapper;
	@Autowired
	private ProjectGroupMapper projectGroupMapper;
	@Autowired
	private ProjectGroupGoodsMapper pggMapper;
	@Autowired
	private ProjectUpdateResourceMapper purMapper;
	@Autowired
	private ProjectGroupGoodsMapper projectGroupGoodsMapper;
	@Autowired
	private ProjectUpdateMapper projectUpdateMapper;
	@Autowired
	private ProjectUpdateGoodsMapper projectUpdateGoodsMapper;	
	
	/*
	 * project_goods pg表和临时表temporary_project_goods tpg表联合查询  
	 * tpg表临时存放修改后的项目采购控制表数据 
	 * 如果tpg表和pg表ID相同就显示tpg表的
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		int count = 0;
		List<ProjectGoods> pgList = projectGoodsMapper.findList(param);
		List<TemporaryProjectGoods> tpgList = tprojectGoodsMapper.findList(param);
		pgList = dataReplace(pgList, tpgList);
		
		for (int i = pgList.size()-1; i >= 0 ; i--) {
			if(pgList.get(i).getStatus().equals(0)) {
				pgList.remove(i);
				count++;
			}

		}
		
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		int total=projectGoodsMapper.findList(sizeMap).size()-count;
		List<ProjectGoods> rows=pgList;
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}*/
	
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("isValid",param.get("isValid"));
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("projectUpdate",param.get("projectUpdate"));
		sizeMap.put("updateType",param.get("updateType"));
		sizeMap.put("searchName",param.get("searchName"));
		int total=projectGoodsMapper.findList(sizeMap).size();
		List<ProjectGoods> rows=projectGoodsMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
	
	
	@Override
	public int insertAll(List<ProjectGoods> pgList,int projectId,int companyId) {
		try {
			projectGoodsMapper.projectGoodsDel(projectId);
			projectGoodsMapper.insertAll(pgList);
			projectGoodsBakMapper.insertAll(pgList);
			projectGoodsMapper.saveProjectUpdateResourceAll(projectId);
			return 1;
		} catch (Exception e) {
			projectGoodsMapper.projectGoodsDel(projectId);
			goodsMapper.deleteGoodsProjectId(companyId);
			return 3;
		}
		
	}

	@Override
	public List<ProjectGoods> insertSelective(ProjectGoods record) {
		projectGoodsMapper.insertSelective(record);
		List <ProjectGoods> proGoods=projectGoodsMapper.selectAllProjectGoods();
		return proGoods;
	}

	@Override
	public List<ProjectGoods> list(int projectId) {
		return projectGoodsMapper.list(projectId);
	}

	@Override
	public List<ProjectGoods> all(int projectId) {
//		return projectGoodsMapper.all(projectId);
		return null;
	}


	@Override
	public Map<String, Object> findMismatch(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("isValid",param.get("isValid"));
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("companyId",param.get("companyId"));
		sizeMap.put("projectUpdate",param.get("projectUpdate"));
		sizeMap.put("updateType",param.get("updateType"));
		sizeMap.put("searchName",param.get("searchName"));
		int total=projectGoodsMapper.findMismatch(sizeMap).size();
		List<ProjectGoods> rows=projectGoodsMapper.findMismatch(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
/*	
 * project_goods pg表和临时表temporary_project_goods tpg表联合查询  
	 * tpg表临时存放修改后的项目采购控制表数据 
	 * 如果tpg表和pg表ID相同就显示tpg表的
	@Override
	public Map<String, Object> findMismatch(Map<String, Object> param) {
		int count = 0;
		List<ProjectGoods> pgList = projectGoodsMapper.findMismatch(param);
		List<TemporaryProjectGoods> tpgList = tprojectGoodsMapper.findList(param);
		pgList = dataReplace(pgList, tpgList);
		
		for (int i = pgList.size()-1; i >= 0 ; i--) {
			if(pgList.get(i).getStatus().equals(0)) {
				pgList.remove(i);
				count++;
			}
			
		}
		
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		int total=projectGoodsMapper.findMismatch(sizeMap).size()-count;
		List<ProjectGoods> rows=pgList;
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
*/

	@Override
	public Integer selectGoodsQuantity(Integer projectId) {
		return projectGoodsMapper.selectGoodsQuantity(projectId);
	}


	@Override
	public ProjectGoods selectProjectGoodsById(int id) {
		return projectGoodsMapper.selectProjectGoodsById(id);
	}


	@Override
	public int updateProjectGoods(ProjectGoods projectGoods) {
		return projectGoodsMapper.updateByPrimaryKeySelective(projectGoods);
	}


	@Override
	public int deleteProjectGoodsById(int id) {
		return projectGoodsMapper.deleteProjectGoodsById(id);
	}


	@Override
	public int updateTemporaryProjectGoods(int projectId) {
		List<TemporaryProjectGoods> tpgList = tprojectGoodsMapper.selectProjectGoodsByProjectId(projectId);
		int pg = projectGoodsMapper.updateProjectGoods(tpgList);
		if(pg>=1) {
			tprojectGoodsMapper.deleteByProjectId(projectId);
		}
		return pg;
	}


	@Override
	public void projectGoodsDel(int projectId) {
		purMapper.projectUpdateResourceDel(projectId);
		projectGroupMapper.projectGroupDel(projectId);
		pggMapper.projectGroupGoodsDel(projectId);
		projectGoodsMapper.projectGoodsDel(projectId);
//		goodsMapper.deleteGoodsProjectId(projectId);
		projectGoodsBakMapper.deleteProjectGoodsBakProjectId(projectId);
		projectUpdateMapper.deletePuProjectId(projectId);
		projectUpdateGoodsMapper.delectPugProjectId(projectId);	
	}

	
	public static List<ProjectGoods> dataReplace(List<ProjectGoods> pgList,List<TemporaryProjectGoods> tpgList){
		for (int i = 0; i < pgList.size(); i++) {
			pgList.get(i).setStatus(-1);
			for (int j = 0; j < tpgList.size(); j++) {
				if(pgList.get(i).getId().equals(tpgList.get(j).getProjectGoodsId())) {
					pgList.get(i).setPrice(tpgList.get(j).getPrice());
					pgList.get(i).setAmount(tpgList.get(j).getAmount());
					pgList.get(i).setTotal(tpgList.get(j).getTotal());
					pgList.get(i).setStatus(tpgList.get(j).getStatus());
				}
			}
		}
		return pgList;
	}


	@Override
	public int selectProjectGoodsCount(int projectId) {
		return projectGoodsMapper.selectProjectGoodsCount(projectId);
	}


	@Override
	public int preservation(int projectId) {
		projectGoodsMapper.preservation(projectId);
		return 1;
	}


	@Override
	public List<ProjectGoods> findListNoPagination(Map<String, Object> param) {
		return projectGoodsMapper.findListNoPagination(param);
	}


	@Override
	public ProjectGoods findProjectGoodsById(int projectGoodsId,int projectUpdateId) {
		return projectGoodsMapper.findProjectGoodsById(projectGoodsId,projectUpdateId);
	}


	@Override
	public ProjectGoods findProjectGoodsByCode(int projectId, String code, int projectUpdateId,int companyId) {
		return projectGoodsMapper.findProjectGoodsByCode(projectId,code,projectUpdateId,companyId);
	}


	@Override
	public int updateProjectGoodsByProjectUpdateGoods(int projectId, int projectUpdateId,int companyId) {
		try {
			projectGoodsMapper.insertProjectGoodsByProjectUpdateGoods(projectId,projectUpdateId);
			projectGoodsMapper.updateProjectGoodsByProjectUpdateGoods(projectId,projectUpdateId);
			projectGoodsMapper.deleteProjectGoodsByProjectUpdateGoods(projectId,projectUpdateId);
			projectGroupMapper.insertProjectGroupByProjectUpdateGoods(projectId, projectUpdateId);
//			projectGoodsMapper.deleteGoodsByProjectUpdateGoods(projectId,projectUpdateId,companyId);
			List<ProjectGoods> list = projectGoodsMapper.findProjectGoodsUpdateType(projectId,projectUpdateId);
			List<ProjectGoods> updateList = new ArrayList<ProjectGoods>();
			String updateType ;
			for(ProjectGoods projectGoods : list){
				ProjectGoods pg = new ProjectGoods();
				updateType = "";
				if(Tools.isNotEmptyString(projectGoods.getUpdateType()) && projectGoods.getUpdateType().indexOf("清") > -1){
					updateType += "清 ";
				}
				if(projectGoods.getUpdateType2() == 1 || (Tools.isNotEmptyString(projectGoods.getUpdateType()) && projectGoods.getUpdateType().indexOf("变") > -1)){
					updateType += "变 ";
				}
				if(projectGoods.getUpdateType2() == 2 || (Tools.isNotEmptyString(projectGoods.getUpdateType()) && projectGoods.getUpdateType().indexOf("漏") > -1)){
					updateType += "漏 ";
				}
				if(projectGoods.getUpdateType2() == 3 || (Tools.isNotEmptyString(projectGoods.getUpdateType()) && projectGoods.getUpdateType().indexOf("返") > -1)){
					updateType += "返 ";
				}
				if(projectGoods.getUpdateType2() == 4 || (Tools.isNotEmptyString(projectGoods.getUpdateType()) && projectGoods.getUpdateType().indexOf("价") > -1)){
					updateType += "价 ";
				}
				pg.setId(projectGoods.getId());
				pg.setUpdateType(updateType);
				updateList.add(pg);
			}
			if(updateList.size()>0)
			projectGoodsMapper.updateProjectGoodsUpdateType(updateList);
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	@Override
	public int selectProjectUpdateGroup(int projectId, int projectUpdateId) {
		try {
			List<ProjectGroupGoods> projectGrouplist = projectGroupGoodsMapper.findProjectGroupUpdateAmount(projectId,projectUpdateId);
			List<ProjectGroupGoods> grouplist = projectGroupGoodsMapper.findProjectGroupUpdateAmountAndPrice(projectId,projectUpdateId);
//			List<ProjectGroupGoods> surpluslist = projectGroupGoodsMapper.selectProjectGroupSurplusAmount(projectId,projectUpdateId);
			List<ProjectGroupGoods> updateGroupList = new ArrayList<ProjectGroupGoods>();
			List<ProjectGroupGoods> groupList = new ArrayList<ProjectGroupGoods>();
			int projectGroupId=projectGroupMapper.selectGroupDate(projectId);
			Double surplusAmount = null;
			//修改前的采购控制量
			Double projectGoodsAmount=null;
			//修改的采购控制表量
			Double amount=null;
			//当前分批的分批量
			Double groupAmount=null;
			//当前分批已采购的量
			Double pogAmount=null;
			boolean flag =true;
			for(ProjectGroupGoods projectGroupGoods : grouplist){
				ProjectGroupGoods pgg = new ProjectGroupGoods();
				//修改当前分批后的价格
				if(projectGroupGoods.getProjectGroupId() !=null) {
					pgg.setProjectGroupId(projectGroupGoods.getProjectGroupId());
					pgg.setPrice(projectGroupGoods.getPrice());
					pgg.setAmount(projectGroupGoods.getAmount());
					Double d1=pgg.getPrice();
					Double d2=pgg.getAmount();
					pgg.setTotal(d1*d2);
					pgg.setGoodsId(projectGroupGoods.getGoodsId());
					updateGroupList.add(pgg);
					projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);
				}
			}
			for(ProjectGroupGoods projectGroupGoods : projectGrouplist){
				ProjectGroupGoods pgg = new ProjectGroupGoods();
				//修改前的采购控制量
				projectGoodsAmount=projectGroupGoods.getProjectGoodsAmount();
				//修改的采购控制表量
				amount=projectGroupGoods.getAmount();
				//当前分批的分批量
				groupAmount=projectGroupGoods.getAmount2();
				//当前分批已采购的量
				pogAmount=projectGroupGoods.getPogAmount();
				
				if(projectGroupGoods.getStatus()==1) {
					pgg.setProjectGroupId(projectGroupId);
					pgg.setGoodsId(projectGroupGoods.getGoodsId());
					pgg.setPrice(projectGroupGoods.getPrice());
					pgg.setAmount(projectGroupGoods.getAmount());
					Double d1=pgg.getPrice();
					Double d2=pgg.getAmount();
					pgg.setTotal(d1*d2);
					updateGroupList.add(pgg);
					projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);
				}if(projectGroupGoods.getStatus()==0) {
					if(flag) {
						// 修改当前分批价格
						pgg.setProjectGroupId(projectGroupId);
						pgg.setPrice(projectGroupGoods.getPrice());
						pgg.setAmount(amount);
						pgg.setGoodsId(projectGroupGoods.getGoodsId());
						Double d1=pgg.getPrice();
						Double d2=pgg.getAmount();
						pgg.setTotal(d1*d2);
						updateGroupList.add(pgg);
						projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);	
					}
					if(amount>projectGoodsAmount) {
						Double sum=amount-projectGoodsAmount+groupAmount;
						pgg.setProjectGroupId(projectGroupId);
						pgg.setGoodsId(projectGroupGoods.getGoodsId());
	//					pgg.setPrice(projectGroupGoods.getPrice());
						pgg.setAmount(sum);
						pgg.setPrice(projectGroupGoods.getPrice());
						Double d3=projectGroupGoods.getPrice();
						Double d4=pgg.getAmount();
						pgg.setTotal(d3*d4);
						updateGroupList.add(pgg);
						projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);
					}else if(amount<=projectGoodsAmount ) {
						if(flag) {
							if(projectGroupGoods.getProjectGroupId()==null) {
								pgg.setProjectGroupId(projectGroupId);
								pgg.setGoodsId(projectGroupGoods.getGoodsId());
			//					pgg.setPrice(projectGroupGoods.getPrice());
								surplusAmount= amount;
			 					pgg.setAmount(amount);
								Double d5=pgg.getPrice();
								Double d6=pgg.getAmount();
								pgg.setTotal(d5*d6);
								updateGroupList.add(pgg);
								projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);
							}else {
								pgg.setProjectGroupId(projectGroupId);
								pgg.setGoodsId(projectGroupGoods.getGoodsId());
			//					pgg.setPrice(projectGroupGoods.getPrice());
								pgg.setAmount((groupAmount-pogAmount)-(projectGoodsAmount-amount));
								surplusAmount= pgg.getAmount();
								if(pgg.getAmount() <=0) {
			 						pgg.setAmount(projectGroupGoods.getPogAmount());
								}
								Double d5=pgg.getPrice();
								Double d6=pgg.getAmount();
								pgg.setTotal(d5*d6);
								updateGroupList.add(pgg);
								projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);
							}
							
							
						}
					
					}
					if(surplusAmount !=null) {
						if(surplusAmount<=0) {
							pgg.setProjectGroupId(projectGroupGoods.getProjectGroupId());
							pgg.setGoodsId(projectGroupGoods.getGoodsId());
							Double c=projectGroupGoods.getSurplusAmount();
							pgg.setAmount(surplusAmount+c);
							surplusAmount=pgg.getAmount();
							if(pgg.getAmount() <0) {
		 						pgg.setAmount(0.00);
							}
							flag=false;
							pgg.setPrice(projectGroupGoods.getPrice());
							Double d5=projectGroupGoods.getPrice();
							Double d6=pgg.getAmount();
							pgg.setTotal(d5*d6);
							groupList.add(pgg);
							projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(groupList);
						}else if(surplusAmount>0) {
							flag=true;
//							break;
						}
					}
				
			  }
				
				
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}


	@Override
	public int updateNotProjectGroup(int projectId, int projectUpdateId) {
		try {
			List<ProjectGroupGoods> projectGrouplist = projectGroupGoodsMapper.findProjectGroupUpdateAmount(projectId,projectUpdateId);
			List<ProjectGroupGoods> updateGroupList = new ArrayList<ProjectGroupGoods>();
			for(ProjectGroupGoods projectGroupGoods : projectGrouplist){
				ProjectGroupGoods pgg = new ProjectGroupGoods();
				if(projectGroupGoods.getStatus()==1) {
					pgg.setProjectGroupId(projectGroupGoods.getProjectGroupId());
					pgg.setGoodsId(projectGroupGoods.getGoodsId());
					pgg.setPrice(projectGroupGoods.getPrice());
					pgg.setAmount(0.00);
					pgg.setTotal(0.00);
					updateGroupList.add(pgg);
					projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);
				}else if(projectGroupGoods.getStatus()==0) {
					pgg.setProjectGroupId(projectGroupGoods.getProjectGroupId());
					pgg.setPrice(projectGroupGoods.getPrice());
					pgg.setAmount(0.00);
					pgg.setTotal(0.00);
					pgg.setGoodsId(projectGroupGoods.getGoodsId());
					updateGroupList.add(pgg);
					projectGroupGoodsMapper.updateProjectGroupGoodsUpdate(updateGroupList);	
				}
				
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

}
