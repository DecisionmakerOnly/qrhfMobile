package com.qrhf.service;

import com.qrhf.dao.ProjectOrderGoodsMapper;
import com.qrhf.dao.StatisticsMapper;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.ProjectStatistics;
import com.qrhf.pojo.Statistics;
import com.qrhf.tools.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StatisticsServiceImpl implements StatisticsService{

	@Autowired
	private StatisticsMapper statisticsMapper;

	@Autowired
	private ProjectOrderGoodsMapper goodsMapper;

	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("projectId",param.get("projectId"));
		sizeMap.put("startDate",param.get("startDate"));
		sizeMap.put("endDate",param.get("endDate"));
		sizeMap.put("name",param.get("name"));
		int total=statisticsMapper.findList(sizeMap).size();
		List<Statistics> rows=statisticsMapper.findList(param); 
		result.put("total",total);
 		result.put("rows",rows);
		return result;
	}

	@Override
	public List<ProjectStatistics> statistics(Map<String, Object> param) {
		return statisticsMapper.statistics(param); 
	}

	@Override
	public List<ProjectStatistics> amountStatistics(Map<String, Object> param) {
		return statisticsMapper.amountStatistics(param); 
	}

	@Override
	public List<ProjectStatistics> priceStatistics(Map<String, Object> param) {
		return statisticsMapper.priceStatistics(param);
	}

	@Override
	public Statistics fundsStatistics(Map<String, Object> param) {
		List<Statistics> list = statisticsMapper.fundsStatistics(param);
		double a = 0,b = 0,c = 0;
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getTotalGap()!=null) {
				a+=list.get(i).getTotalGap();
			}else {
				b+=list.get(i).getControlTotal();
			}
			c=list.get(0).getOrderTotal();
		}
		Statistics sta = new Statistics();
		sta.setControlTotal(Tools.priceFormat(a+b));
		sta.setOrderTotal(Tools.priceFormat(c));
		sta.setTotalGap(Tools.priceFormat((a+b)-c));
		return sta;
	}

	@Override
	public Map<String, Object> midAndAvg(ProjectOrderGoods goods) {
		List<Double> list = goodsMapper.midAndAvg(goods);
		Double result = 0.0;
		int size = list.size();
		for (Double price : list) {
			result+=price;
		}

		double mid = 0;
		if(size % 2 == 1){
			mid = list.get((size-1)/2);
		}else {
			//加0.0是为了把int转成double类型，否则除以2会算错
			mid = (list.get(size/2-1) + list.get(size/2) + 0.0)/2;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("middlePrice",mid);
		map.put("averagePrice",result/size);
		return map;
	}


}
