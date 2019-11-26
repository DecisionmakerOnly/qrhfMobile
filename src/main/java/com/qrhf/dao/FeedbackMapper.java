package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Feedback;

public interface FeedbackMapper {
	
	public List<Feedback> findFeedback(Map <String ,Object> param);
	
	public Integer saveFeedback(Feedback feedback);
}
