package com.qrhf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.FeedbackMapper;
import com.qrhf.pojo.Feedback;
@Service
public class FeedbackServiceImpl implements FeedbackService{
	@Autowired
	private FeedbackMapper feedbackMapper;
	
	@Override
	public Integer saveFeedback(Feedback feedback) {
		return feedbackMapper.saveFeedback(feedback);
	}

	@Override
	public Map<String, Object> findFeedback(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		int total=feedbackMapper.findFeedback(sizeMap).size();
		List<Feedback> rows=feedbackMapper.findFeedback(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

}
