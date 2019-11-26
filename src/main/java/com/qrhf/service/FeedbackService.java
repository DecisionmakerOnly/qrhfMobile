package com.qrhf.service;

import java.util.Map;

import com.qrhf.pojo.Feedback;

public interface FeedbackService {
	
	public Map<String, Object> findFeedback(Map<String, Object> param);
	
	public Integer saveFeedback(Feedback feedback);
}
