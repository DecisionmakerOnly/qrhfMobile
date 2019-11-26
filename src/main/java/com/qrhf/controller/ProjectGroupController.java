package com.qrhf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.ProjectGroup;
import com.qrhf.pojo.ProjectGroupGoods;
import com.qrhf.pojo.ProjectGroupGoodsForm;
import com.qrhf.service.ProjectGroupService;

@Controller
@RequestMapping("projectGroup")
public class ProjectGroupController {

	@Autowired
	private ProjectGroupService projectGroupService;
	
	@RequestMapping("/projectGroup")
	public @ResponseBody Object projectGroup(int projectId){
		return projectGroupService.projectGroup(projectId);
	}
	
	@RequestMapping("/save")
	public @ResponseBody Object save(ProjectGroupGoodsForm projectGroupGoodsForm,ProjectGroup projectGroup){
		int num = projectGroupService.checkDate(projectGroup);
		if(num<=0){
			projectGroupService.save(projectGroup);
			List<ProjectGroupGoods> list = projectGroupGoodsForm.getProjectGroupGoodss();
//			for(int i=0;i<list.size();i++){
//				list.get(i).setProjectGroupId(projectGroup.getId());
//			}
			projectGroupService.saveProjectGroupGoods(list,projectGroup.getProjectId(),projectGroup.getId());
			return "1";
		}
		return "0";
	}
	@RequestMapping("findList")
	public @ResponseBody Object list(int pageSize,int pageNumber,int projectId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId",projectId);
		return projectGroupService.findList(param);
	}
	
	@RequestMapping("/detail")
	public @ResponseBody Object detail(int projectGroupId){
		return projectGroupService.detail(projectGroupId);
	}
	
	@RequestMapping("/details")
	public @ResponseBody Object details(int projectId){
		return projectGroupService.details(projectId);
	}
	
	@RequestMapping("del")
	public @ResponseBody Object del(int projectGroupId){
		return projectGroupService.del(projectGroupId);
	}
	
	@RequestMapping("findProjectUpdateResourceList")
	public @ResponseBody Object findProjectUpdateResourceList(int projectId){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("projectId",projectId);
		return projectGroupService.findProjectUpdateResourceList(param);
	}
	
	@RequestMapping("findProjectGroupDetailsNav")
	public @ResponseBody Object findProjectGroupDetailsNav(int projectId){
		return projectGroupService.findProjectGroupDetailsNav(projectId);
	}
	@RequestMapping("/selectGroupQuantity")
	public @ResponseBody int selectGroupQuantity(Integer projectId) {
		Integer number=projectGroupService.selectGroupQuantity(projectId);
		if(number >0) {
			return 0;
		}else {
			return 1;
		}
	}
	@RequestMapping("/projectGroupById")
	public @ResponseBody Object projectGroupById(int projectGroupId,int projectId){
		return projectGroupService.projectGroupById(projectGroupId,projectId);
	}
	@RequestMapping("findProjectGroupIdDetailsNav")
	public @ResponseBody Object findProjectGroupIdDetailsNav(int projectGroupId){
		return projectGroupService.findProjectGroupIdDetailsNav(projectGroupId);
	}
	@RequestMapping("/updateAmount")
	public @ResponseBody Object updateAmount(ProjectGroupGoodsForm projectGroupGoodsForm,ProjectGroup projectGroup){
		int num = projectGroupService.checkUpdateDate(projectGroup);
		if(num <= 0) {
			List<ProjectGroupGoods> list = projectGroupGoodsForm.getProjectGroupGoodss();
			projectGroupService.updateProjectGroupGoods(list);
			return 1;
		}
		return 0;
	}
	@RequestMapping("delBatchGoods")
	public @ResponseBody Object delBatchGoods(int projectGroupId){
		return projectGroupService.delBatchGoods(projectGroupId);
	}
	@RequestMapping("findProjectGroupId")
	@ResponseBody
	public int findProjectGroupId(int projectGroupId) {
		int number=projectGroupService.findProjectGroupId(projectGroupId);
		if(number <= 1) {
			return 1;
		}else {
			return 2;
		}
	}
	@RequestMapping("findProjectOrderGroupId")
	@ResponseBody
	public int findProjectOrderGroupId(int projectGroupId) {
		int number=projectGroupService.findProjectOrderGroupId(projectGroupId);
		if(number > 0) {
			return 1;
		}else {
			return 2;
		}
	}
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        // 设置List的最大长度
        binder.setAutoGrowCollectionLimit(10000);
    }
	@RequestMapping("updateGroupDate")
	public @ResponseBody Object updateGroupDate(int projectGroupId,String startDate,String endDate) {
		return projectGroupService.updateGroupDate(projectGroupId,startDate,endDate);
	}
	
	
	@RequestMapping("selectProjectGroupDate")
	@ResponseBody
	public int selectProjectGroupDate(int projectGroupId) {
		int number=projectGroupService.selectProjectGroupDate(projectGroupId);
		if(number > 0) {
			return 1;
		}else {
			return 2;
		}
	}
	
	@RequestMapping("delProjectGroupDate")
	@ResponseBody
	public int delProjectGroupDate(int projectGroupId) {
		int number=projectGroupService.delProjectGroupDate(projectGroupId);
		if(number > 0) {
			return 1;
		}else {
			return 2;
		}
	}
	
	@RequestMapping("selectGroupDate")
	public @ResponseBody int selectGroupDate(int projectId) {
		return projectGroupService.selectGroupDate(projectId);
	}
//	findProjectGroupId
//	@RequestMapping("findProjectGroupByProjectId")
//	@ResponseBody
//	public int findProjectGroupByProjectId(int projectId) {
//		int number=projectGroupService.findProjectGroupByProjectId(projectId);
//		if(number <= 1) {
//			return 1;
//		}else {
//			return 2;
//		}
//	}
	
}