package com.qrhf.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.SysLog;
import com.qrhf.service.SysLogService;

@Controller
@RequestMapping("/sysLog")
public class SysLogController {

	@Autowired
	private SysLogService sysLogService;
	
	@RequestMapping("saveLog")
	public @ResponseBody Object saveLog(SysLog sysLog) throws Exception{
		return sysLogService.saveLog(sysLog);
	}
	
}