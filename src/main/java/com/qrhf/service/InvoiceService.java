package com.qrhf.service;

import java.util.Map;

import com.qrhf.pojo.Invoice;

public interface InvoiceService {
	
	public Invoice findInvoice(int companyId);

	public int save(int id,Invoice invoice);
	
	public Map<String, Object> findInvoiceList(Map<String, Object> param);
	
}
