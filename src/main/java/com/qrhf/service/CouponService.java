package com.qrhf.service;

import java.util.List;
import java.util.Map;

import com.qrhf.pojo.Coupon;


public interface CouponService {
	public Map<String, Object> findList(Map<String, Object> param);
	public List<Coupon> findCouponList(Map<String, Object> param);
//	public boolean updateCouponDate(int shareCode, int[] id);
	public int saveCoupon(String paymentOrderId);
	public int updateCouponIsValud(int couponId,int isValid);
}
