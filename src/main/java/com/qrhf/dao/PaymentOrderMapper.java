package com.qrhf.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.qrhf.pojo.InvoiceList;
import com.qrhf.pojo.PaymentOrder;
import com.qrhf.pojo.PaymentOrderUser;

public interface PaymentOrderMapper {

	public void savePaymentOrder(PaymentOrder paymentOrder);
	
	public void savePaymentOrderUsers(List<PaymentOrderUser> list);
	
	public List<PaymentOrder> findPaymentOrder(Map <String ,Object> param);
	
	public PaymentOrder findPaymentOrderById(int paymentOrderId);
	
	public void alipayReturnTradeNO(@Param("paymentOrderId")String paymentOrderId,@Param("tradeNo")String tradeNo);
	
	public int pay99(@Param("paymentOrderId")int paymentOrderId,@Param("remark")String remark);

	public List<PaymentOrder> findList(Map<String, Object> param);

	public int updateOrderStatus(PaymentOrder po);
	
	public int selectPaymentOrder(int paymentOrderId);
	
	public void pay99Complete(@Param("remark")String remark,@Param("payDate")String payDate);
	
	public void firmOrder(@Param("paymentOrderId")int paymentOrderId,@Param("couponId")String couponId,@Param("orderAmount")String orderAmount,@Param("payAmount")String payAmount);

	public List<PaymentOrder> findPayInvoic(Map <String ,Object> param);
	
	public InvoiceList findInvoiceListAndAddressManagementById(int invoiceListId);
	
	public PaymentOrder findPaymentOrderId(String remark);
}
