package com.qrhf.controller;

import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.ProjectStatistics;
import com.qrhf.pojo.Statistics;
import com.qrhf.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {

	@Autowired
	private StatisticsService statisticsService;
	
	@RequestMapping("/findList")
	public @ResponseBody Object detail(int pageSize, int pageNumber,int projectId, String startDate,String endDate,String name) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId", projectId);
		param.put("startDate",startDate);
		param.put("endDate",endDate);
		param.put("name", name);
		Map<String, Object> list = statisticsService.findList(param);
		return list;
	}
	
	
	@RequestMapping("/amountStatistics")
	@ResponseBody
	public List<ProjectStatistics> amountStatistics(int projectId,String startDate,String endDate,String name) {
		Map<String, Object> param = new HashMap<>();
		param.put("projectId", projectId);
		param.put("endDate", endDate);
		param.put("startDate", startDate);
		param.put("name", name);
		
		List<ProjectStatistics> list = statisticsService.amountStatistics(param);
		
		return list;
	}
	
	@RequestMapping("/priceStatistics")
	@ResponseBody
	public List<ProjectStatistics> priceStatistics(int projectId,String startDate,String endDate,String name) {
		Map<String, Object> param = new HashMap<>();
		param.put("projectId", projectId);
		param.put("endDate", endDate);
		param.put("startDate", startDate);
		param.put("name", name);
		
		List<ProjectStatistics> list = statisticsService.priceStatistics(param);
		
		return list;
	}
	
	@RequestMapping("/priceTrend")
	@ResponseBody
	public List<ProjectStatistics> priceTrend(int projectId,int goodsId,String startDate,String endDate) {
		Map<String, Object> param = new HashMap<>();
		param.put("projectId", projectId);
		param.put("goodsId", goodsId);
		param.put("endDate", endDate);
		param.put("startDate", startDate);
		
		List<ProjectStatistics> list = statisticsService.statistics(param); 
		
		return list;
	}
	
	@RequestMapping("fundsStatistics")
	@ResponseBody
	public Statistics fundsStatistics(int projectId,String startDate,String endDate) {
		Map<String, Object> param = new HashMap<>();
		param.put("projectId", projectId);
		param.put("endDate", endDate);
		param.put("startDate", startDate);
		Statistics sta = statisticsService.fundsStatistics(param);
		return sta;
	}

	@RequestMapping("midAndAvg")
	@ResponseBody
	public Map<String,Object> midAndAvg(ProjectOrderGoods goods){
		return statisticsService.midAndAvg(goods);
	}
}
