package com.qrhf.service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.CouponMapper;
import com.qrhf.pojo.Coupon;

@Service
public class CouponServiceImpl implements CouponService{
	@Autowired
	private CouponMapper couponMapper;
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		sizeMap.put("shareCode",param.get("shareCode"));
		int total=couponMapper.findList(null).size();
		List<Coupon> rows=couponMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
	@Override
	public int saveCoupon(String paymentOrderId) {
		try {
			couponMapper.saveCoupon(paymentOrderId);
			System.out.println("插入成功");
			return 1;
		} catch (Exception e) {
			System.out.println("插入失败");
			return 0;
		}
		
	}
	@Override
	public List<Coupon> findCouponList(Map<String, Object> param) {
		return couponMapper.findCouponList(param);
	}
	@Override
	public int updateCouponIsValud(int couponId, int isValid) {
		try {
			couponMapper.updateCouponIsValud(couponId, isValid);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

	}
	 
}
