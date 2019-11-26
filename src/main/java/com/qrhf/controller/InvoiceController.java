package com.qrhf.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.AddressManagement;
import com.qrhf.pojo.Invoice;
import com.qrhf.pojo.InvoiceList;
import com.qrhf.service.AddressManagementService;
import com.qrhf.service.InvoiceListService;
import com.qrhf.service.InvoiceService;

@Controller
@RequestMapping("invoice")
public class InvoiceController {
	
	@Autowired
	private InvoiceService invoiceService;
	@Autowired
	private InvoiceListService invoiceListService;
	@Autowired
	private AddressManagementService addressManagementService;
	
	@RequestMapping("findInvoiceAndAddressManagement")
	public @ResponseBody List<Object> findInvoiceAndAddressManagement(int companyId){
		List<Object> list = new ArrayList<Object>();
		list.add(invoiceService.findInvoice(companyId));
		list.add(addressManagementService.findAddressManagement(companyId));
		return list;
	}
	
	@RequestMapping("save")
	public @ResponseBody String save(HttpServletRequest request) throws Exception{
		request.setCharacterEncoding("utf-8");
		Invoice invoice = new Invoice();
		AddressManagement addressManagement = new AddressManagement();
		invoice.setCompanyId(Integer.valueOf(request.getParameter("companyId")));
		invoice.setUserId(Integer.valueOf(request.getParameter("userId")));
		invoice.setUnitName(URLDecoder.decode(request.getParameter("unitName"),"utf-8"));
		invoice.setTaxpayerId(URLDecoder.decode(request.getParameter("taxpayerId"),"utf-8"));
		invoice.setRegisteredAddress(URLDecoder.decode(request.getParameter("registeredAddress"),"utf-8"));
		invoice.setRegisteredPhone(URLDecoder.decode(request.getParameter("registeredPhone"),"utf-8"));
		invoice.setOpeningBank(URLDecoder.decode(request.getParameter("openingBank"),"utf-8"));
		invoice.setBankAccount(URLDecoder.decode(request.getParameter("bankAccount"),"utf-8"));
		addressManagement.setCompanyId(Integer.valueOf(request.getParameter("companyId")));
		addressManagement.setUserId(Integer.valueOf(request.getParameter("userId")));
		addressManagement.setRecipientName(URLDecoder.decode(request.getParameter("recipientName"),"utf-8"));
		addressManagement.setRecipientPhone(URLDecoder.decode(request.getParameter("recipientPhone"),"utf-8"));
		addressManagement.setRecipientAddress(URLDecoder.decode(request.getParameter("recipientAddress"),"utf-8"));
		int num1 = invoiceService.save(Integer.valueOf(request.getParameter("invoiceId")),invoice);
		int num2 = addressManagementService.save(Integer.valueOf(request.getParameter("addressManagementId")),addressManagement);
		if(num1 == 1 && num2 == 1){
			return "1";
		}
		return "0";
	}
	
	@RequestMapping("saveInvoiceList")
	public @ResponseBody int saveInvoiceList(HttpServletRequest request) throws Exception{
		request.setCharacterEncoding("utf-8");
		InvoiceList invoiceList=new InvoiceList();
		invoiceList.setCompanyId(Integer.valueOf(request.getParameter("companyId")));
		invoiceList.setUserId(Integer.valueOf(request.getParameter("userId")));
		invoiceList.setUnitName(URLDecoder.decode(request.getParameter("unitName"),"utf-8"));
		invoiceList.setTaxpayerId(URLDecoder.decode(request.getParameter("taxpayerId"),"utf-8"));
		invoiceList.setRegisteredAddress(URLDecoder.decode(request.getParameter("registeredAddress"),"utf-8"));
		invoiceList.setRegisteredPhone(URLDecoder.decode(request.getParameter("registeredPhone"),"utf-8"));
		invoiceList.setOpeningBank(URLDecoder.decode(request.getParameter("openingBank"),"utf-8"));
		invoiceList.setBankAccount(URLDecoder.decode(request.getParameter("bankAccount"),"utf-8"));
		invoiceList.setRecipientName(URLDecoder.decode(request.getParameter("recipientName"),"utf-8"));
		invoiceList.setRecipientPhone(URLDecoder.decode(request.getParameter("recipientPhone"),"utf-8"));
		invoiceList.setRecipientAddress(URLDecoder.decode(request.getParameter("recipientAddress"),"utf-8"));
		invoiceListService.save(invoiceList);
		return invoiceList.getId();
	}
}	