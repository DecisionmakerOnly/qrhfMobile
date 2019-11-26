package com.qrhf.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.CouponMapper;
import com.qrhf.dao.PaymentOrderMapper;
import com.qrhf.dao.UserMapper;
import com.qrhf.pojo.InvoiceList;
import com.qrhf.pojo.PaymentOrder;
import com.qrhf.pojo.PaymentOrderUser;

@Service
public class PaymentOrderServiceImpl implements PaymentOrderService {
	
	@Autowired
	private PaymentOrderMapper paymentOrderMapper;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private CouponMapper couponMapper;

	@Override
	public PaymentOrder save(PaymentOrder paymentOrder,String userIds,int timeLength) {
		try {
			paymentOrderMapper.savePaymentOrder(paymentOrder);
			List<PaymentOrderUser> list = new ArrayList<PaymentOrderUser>();
			PaymentOrderUser paymentOrderUser = null;
			String[] ids= userIds.split(",");
			for(String id : ids){
				paymentOrderUser = new PaymentOrderUser();
				paymentOrderUser.setPaymentOrderId(paymentOrder.getId());
				paymentOrderUser.setUserId(Integer.parseInt(id));
				paymentOrderUser.setTimeLength(timeLength);
				list.add(paymentOrderUser);
			}
			paymentOrderMapper.savePaymentOrderUsers(list);
			return paymentOrder;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public PaymentOrder findPaymentOrderById(int paymentOrderId) {
		return paymentOrderMapper.findPaymentOrderById(paymentOrderId);
	}

	@Override
	public String alipayReturnTradeNO(String paymentOrderId, String tradeNo) {
		try {
			paymentOrderMapper.alipayReturnTradeNO(paymentOrderId,tradeNo);
			userMapper.addUserTimeLength(paymentOrderId);
			int number=paymentOrderMapper.selectPaymentOrder(Integer.valueOf(paymentOrderId));
 			if (number <1) {
				couponMapper.saveCoupon(paymentOrderId);
			}
 			return "1";
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
	}

	@Override
	public int pay99(int paymentOrderId, String remark) {
		try {
			paymentOrderMapper.pay99(paymentOrderId,remark);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public Map<String, Object> findPaymentOrder(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		int total=paymentOrderMapper.findPaymentOrder(sizeMap).size();
		List<PaymentOrder> rows=paymentOrderMapper.findPaymentOrder(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}
	
	@Override
	public Map<String, Object> findList(Map<String, Object> param) {
		Map<String,Object> result = new HashMap<String,Object>();
		Map<String,Object> sizeMap = new HashMap<String,Object>();
		sizeMap.put("userId",param.get("userId"));
		int total=paymentOrderMapper.findList(sizeMap).size();
		List<PaymentOrder> rows=paymentOrderMapper.findList(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public int updateOrderStatus(PaymentOrder po) {
		return paymentOrderMapper.updateOrderStatus(po);
	}

	/**
	 * 用户查看订单时检查并清除所有 到期订单
	 */
	@Override
	public void checkOrder(int userId) {
//		List<Integer> orderIds = new ArrayList<>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userId",userId);
		List<PaymentOrder> rows=paymentOrderMapper.findList(param);
		long now = System.currentTimeMillis();		//当前时间
		long effectiveTime = 24*60*60*1000;			//有效时间24小时
		for (int i = 0; i < rows.size(); i++) {
			long createTime = rows.get(i).getCreateDate().getTime();
			int orderStatus=rows.get(i).getOrderStatus();
			if((now-createTime)>effectiveTime && orderStatus !=2 && orderStatus !=1) {
				PaymentOrder po = new PaymentOrder();
				po.setId(rows.get(i).getId());
//				po.setOrderStatus(-1);
				po.setIsValid(0);
				updateOrderStatus(po);
			}
		}
	}

	@Override
	public int pay99Complete(String paymentOrderId,String remark, String payDate) {
		try {
			paymentOrderMapper.pay99Complete(remark,payDate);
			int number=paymentOrderMapper.selectPaymentOrder(Integer.valueOf(paymentOrderId));
			userMapper.addUserTimeLength(paymentOrderId);
 			if (number <1) {
				couponMapper.saveCoupon(String.valueOf(paymentOrderId));
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public int firmOrder(int paymentOrderId,String couponId,String orderAmount,String payAmount) {
		try {
			paymentOrderMapper.firmOrder(paymentOrderId,couponId,orderAmount,payAmount);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public Map<String, Object> findPayInvoic(Map<String, Object> param) {
		Map<String,Object> result =new HashMap<String ,Object>();
		Map<String,Object> sizeMap =new HashMap<String,Object>();
		sizeMap.put("companyId",param.get("companyId"));
		int total=paymentOrderMapper.findPayInvoic(sizeMap).size();
		List<PaymentOrder> rows=paymentOrderMapper.findPayInvoic(param);
		result.put("total",total);
		result.put("rows",rows);
		return result;
	}

	@Override
	public InvoiceList findInvoiceListAndAddressManagementById(int invoiceListId) {
		return paymentOrderMapper.findInvoiceListAndAddressManagementById(invoiceListId);
	}

	@Override
	public PaymentOrder findPaymentOrderId(String remark) {
		return paymentOrderMapper.findPaymentOrderId(remark);
	}


}
