package com.qrhf.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.service.CouponService;

@Controller
@RequestMapping("/coupon")
public class CouponController {
	@Autowired
	private CouponService couponService;
	
	@RequestMapping("/findList")
	public @ResponseBody Object list(String isValid,int shareCode,HttpServletRequest request, int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("isValid",isValid);
		param.put("shareCode",shareCode);
		return couponService.findList(param);
	}
	
	@RequestMapping("/findCouponList")
	public @ResponseBody Object findCouponList(String isValid,int userId) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("isValid",isValid);
		param.put("userId",userId);
		return couponService.findCouponList(param);
	}

	@RequestMapping("/updateCouponIsValud")
	public void updateCouponIsValud(int couponId,int isValid){
		couponService.updateCouponIsValud(couponId, isValid);
	}
	
}
