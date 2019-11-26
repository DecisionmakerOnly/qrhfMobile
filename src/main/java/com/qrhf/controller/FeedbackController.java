package com.qrhf.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.Feedback;
import com.qrhf.service.FeedbackService;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {
	@Resource
	private FeedbackService feedbackService;
	
	
	@RequestMapping("saveFeedback")
	public @ResponseBody Object saveFeedback(HttpServletRequest request,Feedback feedback) throws Exception {
		try {
			feedbackService.saveFeedback(feedback);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return 1;
	}
	@RequestMapping("/findFeedback")
	public @ResponseBody Object findFeedback(HttpServletRequest request, int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		return feedbackService.findFeedback(param);
	}
}
