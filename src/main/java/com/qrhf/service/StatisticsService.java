package com.qrhf.service;

import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.ProjectStatistics;
import com.qrhf.pojo.Statistics;

import java.util.List;
import java.util.Map;

public interface StatisticsService {

	Map<String, Object> findList(Map<String, Object> param);

	List<ProjectStatistics> statistics(Map<String, Object> param);

	List<ProjectStatistics> amountStatistics(Map<String, Object> param);

	List<ProjectStatistics> priceStatistics(Map<String, Object> param);

	Statistics fundsStatistics(Map<String, Object> param);

	Map<String, Object> midAndAvg(ProjectOrderGoods goods);
}
