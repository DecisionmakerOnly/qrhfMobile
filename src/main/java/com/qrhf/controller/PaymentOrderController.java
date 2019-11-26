package com.qrhf.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.api.AlipayApiException;
import com.qrhf.pojo.Company;
import com.qrhf.pojo.InvoiceList;
import com.qrhf.pojo.PaymentOrder;
import com.qrhf.service.CompanyService;
import com.qrhf.service.PaymentOrderService;

@Controller
@RequestMapping("paymentOrder")
public class PaymentOrderController {
	
	@Autowired
	private PaymentOrderService paymentOrderService;
	@Autowired
	private CompanyService companyService;
	
	@RequestMapping("save")
	public @ResponseBody Object save(PaymentOrder paymentOrder,String userIds,int timeLength) throws AlipayApiException{
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSS");
		String date = df.format(new Date());
		Company company = companyService.getCompanyByUserId(paymentOrder.getUserId());
		paymentOrder.setRemark(company.getCode()+date);
		paymentOrderService.save(paymentOrder,userIds,timeLength);
		return paymentOrder.getId();
	}
	
	@RequestMapping("findPaymentOrderById")
	public @ResponseBody Object findPaymentOrderById(int paymentOrderId){
		return paymentOrderService.findPaymentOrderById(paymentOrderId);
	}
	
	@RequestMapping("/findPaymentOrder")
	public @ResponseBody Object list(HttpServletRequest request, int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		return paymentOrderService.findPaymentOrder(param);
	}
	
	@RequestMapping("alipayReturnTradeNO")
	public @ResponseBody String alipayReturnTradeNO(String paymentOrderId,String tradeNo){
		return paymentOrderService.alipayReturnTradeNO(paymentOrderId,tradeNo);
	}
	
	@RequestMapping("pay99")
	public @ResponseBody int pay99(int paymentOrderId,String remark){
		return paymentOrderService.pay99(paymentOrderId,remark);
	}
	@RequestMapping("cancelOrder")
	public @ResponseBody int cancelOrder(int id,int status){
		PaymentOrder po = new PaymentOrder();
		po.setId(id);
		po.setIsValid(status);
		return paymentOrderService.updateOrderStatus(po); 
	}
	
	@RequestMapping("/findList")
	public @ResponseBody Object findList(HttpServletRequest request, int pageSize, int pageNumber,int userId) {
		paymentOrderService.checkOrder(userId);
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("userId", userId);
		return paymentOrderService.findList(param);
	}
	
	@RequestMapping("pay99Complete")
	public @ResponseBody Object pay99Complete(String paymentOrderId,String remark,String payDate){
		return paymentOrderService.pay99Complete(paymentOrderId,remark,payDate);
	}
	@RequestMapping("/findInvoicList")
	public @ResponseBody Object findInvoicList(HttpServletRequest request, int companyId,int pageSize, int pageNumber) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyId", companyId);
		return paymentOrderService.findPayInvoic(param);
	}
	@RequestMapping("findInvoiceListAndAddressManagementById")
	public @ResponseBody InvoiceList findInvoiceListAndAddressManagementById(int invoiceListId){
		return paymentOrderService.findInvoiceListAndAddressManagementById(invoiceListId);
	}
	@RequestMapping("firmOrder")
	public void firmOrder(int paymentOrderId,String couponId,String orderAmount,String payAmount){
		paymentOrderService.firmOrder(paymentOrderId,couponId,orderAmount,payAmount);
	}
	@RequestMapping("findPaymentOrderId")
	public @ResponseBody PaymentOrder findPaymentOrderId(String remark){
		return 	paymentOrderService.findPaymentOrderId(remark);
	}
	
}
