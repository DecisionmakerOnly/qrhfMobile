package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.ProjectStatistics;
import com.qrhf.pojo.Statistics;

public interface StatisticsMapper {

	List<Statistics> findList(Map<String, Object> sizeMap);

	List<ProjectStatistics> statistics(Map<String, Object> param);

	List<ProjectStatistics> priceStatistics(Map<String, Object> param);

	List<ProjectStatistics> amountStatistics(Map<String, Object> param);

	List<Statistics> fundsStatistics(Map<String, Object> param);

}
