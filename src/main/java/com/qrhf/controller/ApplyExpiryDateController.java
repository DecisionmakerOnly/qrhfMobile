package com.qrhf.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.ApplyExpiryDate;
import com.qrhf.service.ApplyExpiryDateService;

@Controller
@RequestMapping("applyExpiryDate")
public class ApplyExpiryDateController {

	@Autowired
	private ApplyExpiryDateService applyExpiryDateService;
	
	@RequestMapping("addApplyExpiryDate")
	public @ResponseBody Object addApplyExpiryDate(ApplyExpiryDate applyExpiryDate){
		return applyExpiryDateService.addApplyExpiryDate(applyExpiryDate);
	}
	@RequestMapping("/findApplyExpiryDate")
	public @ResponseBody Object list(HttpServletRequest request, int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		return applyExpiryDateService.findApplyExpiryDate(param);
	}
	@RequestMapping("updateApplyExpiryDate")
	public @ResponseBody int updateApplyExpiryDate(int id,int processUserId) {
		return applyExpiryDateService.updateApplyExpiryDate(id,processUserId);
	}
	
	@RequestMapping("applyExpiryDateNo")
	public @ResponseBody int applyExpiryDateNo(int id,String reason,int processUserId) {
		return applyExpiryDateService.applyExpiryDateNo(id,reason,processUserId);
	}
	
	@RequestMapping("deleteApplyExpiryDate")
	public @ResponseBody int deleteApplyExpiryDate(int id) {
		return applyExpiryDateService.deleteApplyExpiryDate(id);
	}
}
