package com.qrhf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.ProjectMapper;
import com.qrhf.dao.SysFlowMapper;
import com.qrhf.dao.SysRoleMapper;
import com.qrhf.pojo.Consultation;
import com.qrhf.pojo.ConsultationGoods;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.SysFlow;
import com.qrhf.pojo.SysRole;
import com.qrhf.pojo.User;

@Service
public class SysFlowServiceImpl implements SysFlowService{

	@Autowired
	private SysFlowMapper sysFlowMapper;
	@Autowired
	private ProjectMapper projectMapper;
	@Autowired
	private	 SysRoleMapper sysRoleMapper;
	
	@Override
	public int insert(SysFlow flow) {
		return sysFlowMapper.insert(flow);
	}


	@Override
	public void failOrder(Map<String, Object> param) {
		sysFlowMapper.failOrder(param);
	}

	@Override
	public List<SysFlow> findSysFlow(Integer userId) {
		return sysFlowMapper.findSysFlow(userId);
	}
	
	@Override
	public int reject(int sysFlowId,String rejectReason) {
		try {
			sysFlowMapper.reject(sysFlowId,rejectReason);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}


	@Override
	public int confirmed(int sysFlowId) {
		try {
			sysFlowMapper.confirmed(sysFlowId);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}


	@Override
	public void delete(int projectOrderId) {
		sysFlowMapper.delete(projectOrderId);
	}


	@Override
	public int submitTable(int projectId,int projectUpdateId,User user) {
		Project projects = projectMapper.selectProject(projectId);
		SysFlow sysFlow = new SysFlow();
		sysFlow.setProjectId(projectId);
		sysFlow.setProjectUpdateId(projectUpdateId);
		sysFlow.setTitle(projects.getName());
		sysFlow.setBuyerId(user.getId());
		Integer companyId = user.getCompanyId();
		
		//查询老板ID 修改完项目采购控制表后需要老板确定
		SysRole sr=sysRoleMapper.getUserCode(companyId);
		Integer userId =sr.getUserId();
		sysFlow.setManagerId(userId);
		
		int sys = sysFlowMapper.addSKTable(sysFlow);
		return sys;
	}


	@Override
	public int updateStatus(int sysFlowId, int status) {
		return sysFlowMapper.updateStatus(sysFlowId,status);
	}


	@Override
	public int updateStatus(Map<String, Object> par) {
		return sysFlowMapper.updateSfStatus(par);
	}

	@Override
	public int startFlow(int sysFlowId,int dutyUserId) {
		try {
			sysFlowMapper.updateDutyUser(sysFlowId,dutyUserId);
			sysFlowMapper.startFlow(sysFlowId);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public Integer selectSysFlow(Integer projectId) {
		return sysFlowMapper.selectSysFlow(projectId);
	}


	@Override
	public void addMsg(List<Project> projects) {
		sysFlowMapper.addMsg(projects);	 	
	}


	@Override
	public int deleteNotice(SysFlow sf) {
		return sysFlowMapper.deleteNotice(sf);		
	}


	@Override
	public int reject(SysFlow flow) {
		/*Map<String, Object> map = new HashMap<String, Object>();
		map.put("projectId", flow.getProjectId());
		map.put("projectOrderId", flow.getProjectOrderId());
		projectOrderGoodsMapper.updateStatus(map);*/
		sysFlowMapper.deleteConsultationGoods(flow.getId());
		sysFlowMapper.deleteConsultation(flow.getId());
		return sysFlowMapper.reject(flow);
	}


	@Override
	public int submitAgain(int sysFlowId) {
		return sysFlowMapper.submitAgain(sysFlowId);
	}


	@Override
	public int checkIsUpdateGoodsAll(int projectOrderId) {
		return sysFlowMapper.checkIsUpdateGoodsAll(projectOrderId).size();
	}


	@Override
	public int emptyReason(int sysFlowId) {
		return sysFlowMapper.emptyReason(sysFlowId);
	}


	@Override
	public int deleteProjectOrderNotice(SysFlow sysFlow) {
		return sysFlowMapper.deleteProjectOrderNotice(sysFlow); 
	}


	@Override
	public void addExpiryDateNotice(SysFlow sf) {
		sysFlowMapper.addExpiryDateNotice(sf);		
	}


	@Override
	public int temporaryBatch(SysFlow sysFlow) {
		return sysFlowMapper.temporaryBatch(sysFlow);
	}


	@Override
	public int updateTemporaryBatch(int sysFlowId, int num) {
		try {
			sysFlowMapper.updateTemporaryBatch(sysFlowId, num);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}


	@Override
	public int selectBatch(Integer projectId,Integer buyerId) {
		return sysFlowMapper.selectBatch(projectId,buyerId);
	}


	@Override
	public int saveConsultation(List<Consultation> list) {
		try {
			sysFlowMapper.saveConsultation(list);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}


	@Override
	public int saveConsultationGoods(List<ConsultationGoods> list) {
		try {
			sysFlowMapper.saveConsultationGoods(list);
			sysFlowMapper.updateConsultationStatus(list.get(0).getConsultationId(),1);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}



	/*@Override
	public int submitCGB(ProjectOrderGoods orderGoods,User user) {
		SysFlow sysFlow = new SysFlow();
		sysFlow.setProjectId(orderGoods.getProjectId());
		sysFlow.setProjectOrderId(orderGoods.getProjectOrderId());
		sysFlow.setTitle(orderGoods.getName()+"：修改后再次提交");
		sysFlow.setBuyerId(user.getId());
		
		Project project = projectMapper.selectProject(orderGoods.getProjectId());
		sysFlow.setManagerId(project.getDutyUser());
		return insert(sysFlow);
	}*/

}
