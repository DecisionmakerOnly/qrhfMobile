package com.qrhf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.CouponMapper;
import com.qrhf.dao.RealInfoMapper;
import com.qrhf.dao.RefundMapper;
import com.qrhf.pojo.RealInfo;
import com.qrhf.pojo.Refund;
@Service
public class RealInfoServiceImpl implements RealInfoService{

	@Autowired
	private RealInfoMapper realInfoMapper;
	@Autowired
	private CouponMapper couponMapper;
	@Autowired
	private RefundMapper refundMapper;
	
	@Override
	public int addInfo(RealInfo realInfo) {
		int i = realInfoMapper.addInfo(realInfo);
		if(i==1) {
			Refund refund = new Refund();
			refund.setUserId(realInfo.getUserId());
			refund.setCompanyId(realInfo.getCompanyId());
			refund.setBusinessId(realInfo.getCouponId());
			refund.setBusinessType(1);
			refund.setIsValid(1);
			refund.setStatus(0);
			int r = refundMapper.add(refund);
			if(r==1) {
				couponMapper.updateCoupon(realInfo.getCouponId());
			}
			
		}
		return i;
	}

}
