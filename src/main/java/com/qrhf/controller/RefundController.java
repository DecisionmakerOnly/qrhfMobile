package com.qrhf.controller;

import java.util.HashMap;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.Refund;
import com.qrhf.service.RefundService;

@Controller
@RequestMapping("/refund")
public class RefundController {
	@Autowired
	private RefundService refundService;
	
	@RequestMapping("/findList")
	public @ResponseBody Object list(int userId, int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("userId", userId);
		return refundService.findList(param);
	}
	
	@RequestMapping("/selectAll")
	public @ResponseBody Object selectAll(int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		return refundService.selectAll(param); 
	}
	
	@ResponseBody
	@RequestMapping("/updateStatus")
	public int updateStatus(Refund refund) {
		int i = refundService.updateStatus(refund);
		return i;
	}
}
