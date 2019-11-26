package com.qrhf.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.InvoiceMapper;
import com.qrhf.pojo.Invoice;

@Service
public class InvoiceServiceImpl implements InvoiceService {

	@Autowired
	private InvoiceMapper invoiceMapper;
	

	@Override
	public Invoice findInvoice(int companyId) {
		return invoiceMapper.findInvoice(companyId);
	}
	
	@Override
	public int save(int id,Invoice invoice) {
		try {
			if(id!=0){
				invoice.setId(id);
				invoiceMapper.update(invoice);
			}else{
				invoiceMapper.save(invoice);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public Map<String, Object> findInvoiceList(Map<String, Object> param) {
		return null;
	}

}
