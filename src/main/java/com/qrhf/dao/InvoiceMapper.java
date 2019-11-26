package com.qrhf.dao;

import com.qrhf.pojo.Invoice;

public interface InvoiceMapper {
	
	public Invoice findInvoice(int companyId);
	
	public void save(Invoice invoice);

	public void update(Invoice invoice);
	
//	public List<Invoice> findInvoiceList(Map <String ,Object> param);
}
