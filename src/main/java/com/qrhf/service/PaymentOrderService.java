package com.qrhf.service;

import java.util.Map;

import com.qrhf.pojo.InvoiceList;
import com.qrhf.pojo.PaymentOrder;

public interface PaymentOrderService {
	
	public PaymentOrder save(PaymentOrder paymentOrder,String userIds,int timeLength);
	
	public Map<String, Object> findPaymentOrder(Map<String, Object> param);
	
	public PaymentOrder findPaymentOrderById(int paymentOrderId);
	
	public String alipayReturnTradeNO(String paymentOrderId,String tradeNo);
	
	public int pay99(int paymentOrderId,String remark);
	
	public Map<String,Object> findList(Map<String,Object> param);

	public int updateOrderStatus(PaymentOrder po);

	public void checkOrder(int userId);
	
	public int pay99Complete(String paymentOrderId,String remark,String payDate);
	
	public int firmOrder(int paymentOrderId,String couponId,String orderAmount,String payAmount);
	
	public Map<String, Object> findPayInvoic(Map<String, Object> param);
	
	public InvoiceList findInvoiceListAndAddressManagementById(int invoiceListId);
	
	public PaymentOrder findPaymentOrderId(String remark);
}
