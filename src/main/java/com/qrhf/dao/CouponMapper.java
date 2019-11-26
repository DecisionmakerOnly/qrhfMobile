package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.Coupon;

public interface CouponMapper {
	public List<Coupon> findList(Map <String ,Object> param);
	public List<Coupon> findCouponList(Map<String, Object> param);
//	public List<Coupon> queryCoupon(int shareCode);
	public int updateCoupon(@Param("id")int id);
	public int saveCoupon(String paymentOrderId);
	public void updateCouponIsValud(@Param("couponId")int couponId,@Param("isValid")int isValid);
}
