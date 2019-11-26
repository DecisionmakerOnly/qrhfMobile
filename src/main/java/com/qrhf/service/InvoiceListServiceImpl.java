package com.qrhf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qrhf.dao.InvoiceListMapper;
import com.qrhf.pojo.InvoiceList;
@Service
public class InvoiceListServiceImpl implements InvoiceListService{
	@Autowired
	private InvoiceListMapper invoiceListMapper;
	
	@Override
	public int save(InvoiceList invoiceList) {
		return invoiceListMapper.save(invoiceList);
	}

}
