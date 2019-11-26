package com.qrhf.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.qrhf.pojo.ExcelBean;
import com.qrhf.pojo.Quota;
import com.qrhf.pojo.QuotaRole;
import com.qrhf.pojo.QuotaStatistics;
import com.qrhf.pojo.SysUnit;
import com.qrhf.pojo.User;
import com.qrhf.service.QuotaRoleService;
import com.qrhf.service.QuotaService;
import com.qrhf.service.SysUnitService;
import com.qrhf.tools.ExcelUtil;
import com.qrhf.tools.Tools;

@Controller
@RequestMapping("/quota")
public class QuotaController {
	@Autowired
	private QuotaService quotaService;
	@Autowired
	private SysUnitService sysUnitService;
	@Autowired
	private QuotaRoleService quotaRoleService;
	@RequestMapping("saveQuota")
	public @ResponseBody String saveQuota(Quota quota,HttpServletRequest request,QuotaRole quotaRole) {
		quota.setRegionId(quota.getProvince());
		quota.setRegionPid(quota.getCity());
		quota.setRegionSonId(quota.getArea());
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		try {
//			quota.setStartDate(sdf.parse(quota.getStartDateStr()));
//			quota.setEndDate(sdf.parse(quota.getEndDateStr()));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		if(quota.getId()==null){
			quotaService.saveQuota(quota);
			quotaRole.setCompanyId(quota.getCompanyId());
			quotaRole.setQuotaId(quota.getId());
			quotaRole.setUserId(quota.getUserId());
			quotaRoleService.insertQuotaRole(quotaRole);
		}else {
			quotaService.updateQuota(quota);
		}
		
		return "1";
	}
	@RequestMapping("findList")
	public @ResponseBody Object list(HttpServletRequest request,int pageSize,int pageNumber){
		User user = (User) request.getSession().getAttribute("user");
		Map<String,Object> param=new HashMap<String,Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyId", user.getCompanyId());
		return quotaService.findList(param);
		
	}
	@RequestMapping("listAll")
	public @ResponseBody Object listAll(HttpServletRequest request,int pageSize,int pageNumber,String quotaName,String workload) {
		Map<String,Object> param=new HashMap<String,Object>();
		int a=(pageNumber -1)* pageSize;
		int b=pageSize;
		param.put("quotaName",quotaName.equals("")?null:Tools.fuzzyQueryString(quotaName));
//		param.put("workload",workload.equals("")?null:Tools.fuzzyQueryString(workload));
		param.put("a", a);
		param.put("b",b);
		return quotaService.findAll(param);
	}
	@RequestMapping("quotaAll")
	public ModelAndView quotaAll() {
		ModelAndView mav = new ModelAndView();
		List<QuotaStatistics> list=quotaService.quotaAll();
		QuotaStatistics quos=list.get(0);
		if(quos !=null) {
			mav.addObject("name", quos.getName());
			mav.addObject("linkageCount",quos.getLinkageCount());
			mav.addObject("wages",quos.getWages());
			mav.addObject("workload",quos.getWorkload());
			mav.setViewName("/quota/statistics");
		}else {
			mav.setViewName("quota/error"); 
		}
		
		return mav;
	}
	@RequestMapping("del")
	public @ResponseBody Integer del(Integer id) {
		Integer quota=quotaService.del(id);
		return quota;
	}
	@RequestMapping("getQuotaById")
	public @ResponseBody Object id(Integer id) {
		return quotaService.getQuotaById(id);
	}
	@RequestMapping("findByUnit")
	public @ResponseBody Object findByUnit() {
		List<SysUnit> list=	sysUnitService.findByUnit();
		return list;
	}
	@RequestMapping("detail")
	public ModelAndView detail(int id) {
	ModelAndView mav= new ModelAndView();
		List<Quota> list =quotaService.getListQuotaId(id);
		mav.addObject("list", list);
		mav.addObject("id",id);
		mav.setViewName("/quota/details");
		return mav;
	}
	@RequestMapping("/toExport")
	public @ResponseBody void exportExl(HttpServletRequest request, HttpServletResponse response,int id,Integer companyId,Integer quotaId,QuotaRole quotaRole) throws Exception {
		if(quotaRoleService.getQuotaRoleQuotaId(companyId,quotaId)==null) {
			quotaService.updateById(id);
			quotaRole.setCompanyId(companyId);
			quotaRole.setQuotaId(quotaId);
			quotaRoleService.insertQuotaRole(quotaRole);
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("id",request.getParameter("id"));
			String linkageName=request.getParameter("id");
			response.reset(); // 清除buffer缓存
			response.setHeader("Content-Disposition", "attachment;filename=" + linkageName + ".xlsx");
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			XSSFWorkbook workbook = null;
			// 导出Excel对象
			workbook = exportExcelInfo(linkageName,param,id);
			OutputStream output;
			try {
				output = response.getOutputStream();
				BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
				bufferedOutPut.flush();
				workbook.write(bufferedOutPut);
				bufferedOutPut.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("id",request.getParameter("id"));
			String linkageName=request.getParameter("id");
			response.reset(); // 清除buffer缓存
			response.setHeader("Content-Disposition", "attachment;filename=" + linkageName + ".xlsx");
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			XSSFWorkbook workbook = null;
			// 导出Excel对象
			workbook = exportExcelInfo(linkageName,param,id);
			OutputStream output;
			try {
				output = response.getOutputStream();
				BufferedOutputStream bufferedOutPut = new BufferedOutputStream(output);
				bufferedOutPut.flush();
				workbook.write(bufferedOutPut);
				bufferedOutPut.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
	}
	public XSSFWorkbook exportExcelInfo(String linkageName,Map<String,Object> param,int id) throws Exception {
		// 根据条件查询数据，把数据装载到一个list中
		List<Quota> list =quotaService.getListQuotaId(id);
		List<ExcelBean> excel = new ArrayList<>();
		Map<Integer, List<ExcelBean>> map = new LinkedHashMap<>();
		XSSFWorkbook xssfWorkbook = null;
		// 设置标题栏
		excel.add(new ExcelBean("序号", "id", 0));
		excel.add(new ExcelBean("项目分类", "linkageName", 0));
		excel.add(new ExcelBean("项目描述", "name", 0));
		excel.add(new ExcelBean("施工地址", "region", 0));
		excel.add(new ExcelBean("技工人数", "seniorWorker", 0));
		excel.add(new ExcelBean("技工金额/天", "seniorWorkerWages", 0));
		excel.add(new ExcelBean("普工人数", "primaryWorker", 0));
		excel.add(new ExcelBean("普工金额/天", "primaryWorkerWages", 0));
		excel.add(new ExcelBean("机械数", "mechanics", 0));
		excel.add(new ExcelBean("机械金额/天", "mechanicsWages", 0));
		excel.add(new ExcelBean("完成工程量", "workloadUnit", 0));
		excel.add(new ExcelBean("有机定额", "organicQuota", 0));
		map.put(0, excel);
		String sheetName = linkageName + "工程详情";
		// 调用ExcelUtil的方法
		xssfWorkbook = ExcelUtil.createExcelFile(Quota.class, list, map, sheetName);
		return xssfWorkbook;
	}
}