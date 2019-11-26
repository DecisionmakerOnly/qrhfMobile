package com.qrhf.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.qrhf.pojo.ExcelBean;
import com.qrhf.pojo.Project;
import com.qrhf.pojo.ProjectOrder;
import com.qrhf.pojo.ProjectOrderGoods;
import com.qrhf.pojo.ProjectOrderGoodsForm;
import com.qrhf.pojo.SysFlow;
import com.qrhf.pojo.TemporaryProjectGoods;
import com.qrhf.pojo.User;
import com.qrhf.service.ProjectOrderGoodsService;
import com.qrhf.service.ProjectOrderService;
import com.qrhf.service.ProjectService;
import com.qrhf.service.SysFlowService;
import com.qrhf.service.SysRoleService;
import com.qrhf.service.TemporaryProjectGoodService;
import com.qrhf.service.UserService;
import com.qrhf.tools.ExcelUtil;
import com.qrhf.tools.NumberUtils;
import com.qrhf.tools.Tools;

@Controller
@RequestMapping("/projectOrder")
public class ProjectOrderController {
	
	@Resource
	private ProjectOrderService projectOrderService;
	@Resource
	private ProjectOrderGoodsService projectOrderGoodsService;
	@Resource
	private SysFlowService sysFlowService;
	@Resource
	private ProjectService projectService;
	@Autowired
	private TemporaryProjectGoodService tpgService;
	@Autowired
	private UserService userService;
	@Autowired
	private SysRoleService sysRoleService;
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setAutoGrowCollectionLimit(2048);  
    }
	@RequestMapping("/findList")
	public @ResponseBody Object findList(int pageSize,int pageNumber,int projectId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId",projectId);
		return projectOrderService.findList(param);
	}

	@RequestMapping("/notPass")
	public @ResponseBody Object notPassCGB(int projectOrderId){
		Map<String, Object> param=new HashMap<String, Object>();
		param.put("projectOrderId",projectOrderId);
		return projectOrderGoodsService.notPass(param);
	}
	
	@RequestMapping("/edit")
	public @ResponseBody Object edit(int pageSize,int pageNumber,int projectOrderId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectOrderId",projectOrderId);
		return projectOrderGoodsService.edit(param);
	}
	
	@RequestMapping("toUpdate")
	@ResponseBody
	public ModelAndView toUpdate(int projectOrderGoodsId) {
		ModelAndView mav = new ModelAndView("order/orderGoodsEdit");
		TemporaryProjectGoods tpg =  projectOrderGoodsService.getById(projectOrderGoodsId);
		mav.addObject("tpg", tpg);
		return mav;
	}
	
	@RequestMapping("deletePOG")
	public @ResponseBody int deletePOG(Integer projectOrderGoodsId) {
		return projectOrderGoodsService.deletePOG(projectOrderGoodsId);
	}
	
	@RequestMapping("selectNotPass")
	public @ResponseBody int selectNotPass(Integer projectOrderId) {
		return projectOrderGoodsService.selectNotPass(projectOrderId);
	}
	@RequestMapping("selectDelPass")
	public @ResponseBody int selectDelPass(Integer projectOrderId) {
		return projectOrderGoodsService.selectDelPass(projectOrderId);
	}
	@RequestMapping("havePassedDel")
	public @ResponseBody int havePassedDel(Integer projectOrderId) {
		return projectOrderGoodsService.havePassedDel(projectOrderId);
	}
	@RequestMapping("/del")
	public @ResponseBody Object del(HttpServletRequest request,ProjectOrder projectOrder, int projectId) {
		projectOrderGoodsService.remove(projectOrder);
		return 1;
	}
	
	@RequestMapping("deleteGoodsAll")
	public @ResponseBody Object deleteGoodsAll(ProjectOrderGoods ProjectOrderGoods){
		sysFlowService.delete(ProjectOrderGoods.getProjectOrderId());
		projectOrderService.deleteGoodsAll(ProjectOrderGoods);
		return 1;
	}
	
	@RequestMapping("/orderDetail")
	public @ResponseBody Object orderDetail(int pageSize,int pageNumber,int projectOrderId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectOrderId",projectOrderId);
		return projectOrderGoodsService.orderDetail(param);
	}
	
	@RequestMapping("/modifiedData")
	public @ResponseBody Object modifiedData(int pageSize,int pageNumber,int projectOrderId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectOrderId",projectOrderId);
		return projectOrderGoodsService.modifiedData(param);
	}
	
	@RequestMapping("/orderBack")
	public @ResponseBody Object orderBack(int pageSize,int pageNumber,int projectOrderId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectOrderId",projectOrderId);
		return projectOrderGoodsService.orderBack(param);
	}
	
	@RequestMapping("/detail")
	public @ResponseBody Object detail(int pageSize,int pageNumber,int projectId,int projectOrderId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId",projectId);
		param.put("projectOrderId",projectOrderId);
		return projectOrderGoodsService.detail(param);
	}
	
	@RequestMapping("detail2")
	public @ResponseBody Object detail2(int projectOrderId) {
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("total",0);
		result.put("rows",projectOrderGoodsService.list(projectOrderId));
		return result;
	}
	
	@RequestMapping("/mismatch")
	public @ResponseBody Object mismatch(int pageSize,int pageNumber,int projectOrderId){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectOrderId",projectOrderId);
		return projectOrderGoodsService.mismatch(param);
	}

	@RequestMapping("/statistics")
	public @ResponseBody Object statistics(int pageSize,int pageNumber,int projectId,String startDate,String endDate){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId",projectId);
		param.put("startDate",startDate);
		param.put("endDate",endDate);
		return projectOrderGoodsService.statistics(param);
	}

	/**
	 * 比较采购表商品和项目采购控制表商品的价格数量，并把审批结果返回到前台
	 * @param projectId
	 * @param projectOrderId
	 * @param req
	 * @return
	 */
	@RequestMapping("/compareGoods")
	public ModelAndView compareGoods(int projectId,int projectOrderId) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("projectId", projectId);
		param.put("projectOrderId", projectOrderId);
		projectOrderGoodsService.compareGoods(param);
		List<ProjectOrderGoods> pogList = projectOrderGoodsService.list(projectOrderId);
		List<ProjectOrderGoods> pogs = new ArrayList<>();
		List<ProjectOrderGoods> list = new ArrayList<>();
		
		for (int i = 0; i < pogList.size(); i++) {
			if(pogList.get(i).getStatus() == 0) {
				pogs.add(pogList.get(i));
			}
			if((null != pogList.get(i).getTpgId())&&(-1 != pogList.get(i).gettStatus())) {
				list.add(pogList.get(i));
			}
		}
		
		if(pogs.size()>0) {
			projectOrderGoodsService.updateIsModify(pogs);
		}
		if(list.size()>0) {
			mav.addObject("list", list);
		}else {
			mav.addObject("list",pogList);
		}
		mav.addObject("projectId",projectId);
		mav.addObject("poId", pogList.get(0).getPeojectOrderId());
		mav.setViewName("/order/hx");
		return mav;
	}
	
	@RequestMapping("/homePage")
	public @ResponseBody ModelAndView approvalList(HttpServletRequest req) {
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		ModelAndView mav = new ModelAndView();
		List<SysFlow> list = sysFlowService.findSysFlow(userId);
		mav.addObject("list", list);
		mav.setViewName("homePage");
		return mav;
	}
	
	@RequestMapping("rejectOrder")
	public @ResponseBody void rejectOrder(String failreason,int projectOrderId,HttpServletRequest req) {
		Map<String, Object> param=new HashMap<String, Object>();
		param.put("projectOrderId", projectOrderId);
		param.put("failreason", failreason);
		sysFlowService.failOrder(param);
	}
	
	@RequestMapping("/upload")
	public @ResponseBody Object upload(@RequestParam(value="file",required = false) MultipartFile file,int projectId,HttpServletRequest req) throws Exception {
		if (!file.isEmpty()) {
			InputStream in = file.getInputStream();
			return save(in, file, projectId,req);
		}else {
			return 0;
		}
		
	}
	
	@RequestMapping("/exportExl")
	public @ResponseBody void exportExl(HttpServletRequest request, HttpServletResponse response,int projectOrderId) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("projectOrderId",request.getParameter("projectOrderId"));
//		param.put("startDate",request.getParameter("startDate"));
//		param.put("endDate",request.getParameter("endDate"));
		ProjectOrder pro=projectOrderService.selectByPrimaryKey(projectOrderId);
		String salaryDate = URLEncoder.encode(pro.getName(), "UTF-8"); 
		response.reset(); // 清除buffer缓存
		response.setHeader("Content-Disposition", "attachment;filename=" + salaryDate + ".xlsx");
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		XSSFWorkbook workbook = null;
		// 根据条件查询数据，把数据装载到一个list中
		List<ProjectOrderGoods> list = projectOrderGoodsService.list(projectOrderId);
		// 导出Excel对象
		workbook = exportExcelInfo(salaryDate,list);
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
	@RequestMapping("/projectOrderExportExl")
	public @ResponseBody void projectOrderExportExl(HttpServletRequest request, HttpServletResponse response,int projectId,String startDate,String endDate) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("projectId",request.getParameter("projectId"));
		param.put("startDate",request.getParameter("startDate"));
		param.put("endDate",request.getParameter("endDate"));
		
		Project pro =projectService.selectByProjectPrimaryKey(projectId);
		String salaryDate = URLEncoder.encode(pro.getName()+"项目采购表"+"开始时间："+startDate+"结束时间："+endDate, "UTF-8"); 
		response.reset(); // 清除buffer缓存
		response.setHeader("Content-Disposition", "attachment;filename=" + salaryDate + ".xlsx");
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		XSSFWorkbook workbook = null;
		List<ProjectOrderGoods> list = projectOrderGoodsService.projectOrdeExport(param);
		// 导出Excel对象
		workbook = exportExcelInfo(salaryDate, list);
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
	public XSSFWorkbook exportExcelInfo(String salaryDate,List<ProjectOrderGoods> list) throws Exception {
		List<ExcelBean> excel = new ArrayList<>();
		Map<Integer, List<ExcelBean>> map = new LinkedHashMap<>();
		XSSFWorkbook xssfWorkbook = null;
		// 设置标题栏
		excel.add(new ExcelBean("系统商品名称", "name", 0));
		excel.add(new ExcelBean("采购表商品名称", "asName", 0));
		excel.add(new ExcelBean("编号", "code", 0));
		excel.add(new ExcelBean("规格", "type", 0));
		excel.add(new ExcelBean("单位", "unit", 0));
		excel.add(new ExcelBean("数量", "amount", 0));
		excel.add(new ExcelBean("单价", "price", 0));
		excel.add(new ExcelBean("总价", "total", 0));
		map.put(0, excel);
		String sheetName = salaryDate + "月份收入";
		// 调用ExcelUtil的方法
		xssfWorkbook = ExcelUtil.createExcelFile(ProjectOrderGoods.class, list, map, sheetName);
		return xssfWorkbook;
	}
	
	@RequestMapping("/toOrderGoodsList")
	public ModelAndView toOrderGoodsList(int projectId,int projectOrderId) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("projectId", projectId);
		mv.addObject("projectOrderId", projectOrderId);
		mv.setViewName("order/orderGoodsList");
		return mv;
	}
	
	@RequestMapping("/toOrderList")
	public ModelAndView toOrderList(int projectId,int projectOrderId) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("projectId", projectId);
		mv.addObject("projectOrderId", projectOrderId);
		mv.setViewName("order/orderList");
		return mv;
	}

	public Map<String, Object> save(InputStream in, MultipartFile file, int projectId,HttpServletRequest req) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
		Project project = projectService.selectProject(projectId);
		List<String> pname=projectOrderService.selectProjectOrder(project.getId());
		User user = (User) req.getSession().getAttribute("user");
		ProjectOrder order = new ProjectOrder();
		order.setProjectId(projectId);
		order.setName("《"+project.getName()+"》项目采购表"+String.format("%02d",NumberUtils.continuous(pname)));
		projectOrderService.insert(order);
		//系统流
		SysFlow flow = new SysFlow();
		flow.setTitle(order.getName());
		flow.setBuyerId(user.getId());
		flow.setProjectId(projectId);
		flow.setProjectOrderId(order.getId());
		List<ProjectOrderGoods> ogList = new ArrayList<>();
		for (int i = (Integer)listob.get(listob.size()-1).get(0); i < listob.size()-1; i++) {
			List<Object> ob = listob.get(i);
			
			ProjectOrderGoods orderGoods = new ProjectOrderGoods();
			if (ob.get(1) != null & !ob.get(1).equals("")) {
				orderGoods.setAsName(String.valueOf(ob.get(1)));
			}
			if (ob.get(2) != null & !ob.get(2).equals("")) {
				orderGoods.setCode(String.valueOf(ob.get(2)));
			}
			if (ob.get(3) != null & !ob.get(3).equals("")) {
				orderGoods.setType(String.valueOf(ob.get(3)));
			}
			if (ob.get(4) != null & !ob.get(4).equals("")) {
				orderGoods.setUnit(String.valueOf(ob.get(4)));
			}
			if (ob.get(6) != null & !ob.get(6).equals("")) {
				orderGoods.setPrice(Tools.priceFormat(Double.valueOf((String) ob.get(6))));
			}
			if (ob.get(5) != null & !ob.get(5).equals("")) {
				orderGoods.setAmount(Double.valueOf((String) ob.get(5)));
			}
			if (null != (String) ob.get(5) && !"".equals((String) ob.get(5)) && null != (String) ob.get(6)
					&& !"".equals((String) ob.get(6))) {
				Double d1 = Tools.priceFormat(Double.valueOf((String) ob.get(6)));
				Double num = Double.valueOf((String) ob.get(5));
				orderGoods.setTotal(d1 * num);
			}
			orderGoods.setProjectId(projectId);
			orderGoods.setProjectOrderId(order.getId());
			ogList.add(orderGoods);
		}
		projectOrderGoodsService.insertAll(ogList);
		sysFlowService.insert(flow);
		map.put("projectOrderName", order.getName());
		map.put("projectOrderId",order.getId());
		map.put("sysFlowId",flow.getId());
		return map;
	}

	@RequestMapping("/selectOrderQuantity")
	public @ResponseBody int selectOrderQuantity(Integer projectId) {
		Integer number=sysFlowService.selectSysFlow(projectId);
		//Integer pg = projectOrderService.selectOrderQuantity(projectId);
		if(number >0) {
			return 2;
		}else {
			return 0;
		}
	}
	
	@RequestMapping("/projectOrderDel")
	public @ResponseBody Object projectOrderDel(int projectId) {
		projectOrderService.projectOrderDel(projectId);
		return 1;
	}
	
	@RequestMapping("editProjectOrderGoods")
	public @ResponseBody int editProjectOrderGoods(ProjectOrderGoods orderGoods) {
		return projectOrderGoodsService.editProjectOrderGoods(orderGoods);
	}
	
	@RequestMapping("deleteProjectOrder")
	public @ResponseBody int deleteProjectOrder(int projectOrderId) {
		int pog = projectOrderGoodsService.deleteProjectOrder(projectOrderId);
		return pog;
	}
	
	@RequestMapping("deleteByProjectOrderId")
	public @ResponseBody int deleteByProjectOrderId(int projectOrderId) {
		return tpgService.deleteByProjectOrderId(projectOrderId);
	}
	
	@RequestMapping("selectCountPoId")
	public @ResponseBody int selectCountPogId(int projectOrderId) {
		int pogId = tpgService.selectCountPoId(projectOrderId); 
		return pogId;
		
	}
	
	@RequestMapping("merge")
	public @ResponseBody int merge(int projectOrderId) {
		int tpg = tpgService.merge(projectOrderId);
		return tpg;
	}
	
	@RequestMapping("deleteAll")
	public @ResponseBody int deleteAll(int projectOrderId) {
		return  projectOrderGoodsService.deleteAll(projectOrderId);
		
	}
	
	
	@RequestMapping("selectStatus")
	public @ResponseBody int selectStatus(int id) {
		return  projectOrderGoodsService.selectStatus(id);
		
	}
	
	@RequestMapping("deleteById")
	public @ResponseBody int deleteById(int projectOrderGoodsId) {
		return  projectOrderGoodsService.deleteById(projectOrderGoodsId);
		
	}
	
	@RequestMapping("selectPogExtra")
	public @ResponseBody int selectPogExtra(int projectOrderId) {
		return  projectOrderGoodsService.selectPogExtra(projectOrderId); 
		
	}
	
	
	@RequestMapping("deletePogExtra")
	public @ResponseBody int deletePogExtra(int projectOrderId) {
		return  projectOrderGoodsService.deletePogExtra(projectOrderId); 
		
	}
	
	@RequestMapping("deleteProUseless")
	public @ResponseBody int deleteProUseless(int projectOrderId) {
		return  projectOrderGoodsService.deleteProUseless(projectOrderId); 
		
	}
	
	@RequestMapping("deleteProjectOrderAll")
	public @ResponseBody int deleteProjectOrderAll(int projectOrderId,int projectId,String name,HttpServletRequest req) throws UnsupportedEncodingException {
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		List<User> manager = userService.selectManager(user);
		SysFlow sysFlow = new SysFlow();
		sysFlow.setProjectId(projectId);
//		sysFlow.setProjectOrderId(projectOrderId);
		sysFlow.setBuyerId(userId);
		if(manager != null && manager.size()!=0) {
			sysFlow.setManagerId(manager.get(0).getId());
		}
		sysFlow.setTitle(name);
//		sysFlow.setTitle(new String(name.getBytes("ISO8859-1"),"UTF-8"));
		int sf = sysFlowService.deleteProjectOrderNotice(sysFlow);
		int po = 0;
		if(sf==1) {
			po = projectOrderGoodsService.deleteProjectOrderAll(projectOrderId);
		}
		return po; 
	}
	
	@RequestMapping("orderPass")
	public @ResponseBody int orderPass(int sysFlowId,int projectOrderId) {
		int poId = tpgService.deleteByProjectOrderId(projectOrderId);
		int status = 0;
		if(poId>=1) {
			projectOrderGoodsService.delpog(projectOrderId);
			status = sysFlowService.updateStatus(sysFlowId, 1);
		}
		return  status;
	}
	@RequestMapping("delpog")
	public @ResponseBody int delpog(Integer projectOrderId) {
		return projectOrderGoodsService.delpog(projectOrderId);
	}
	@RequestMapping("/selectUserCode")
	public @ResponseBody int selectUserCode(Integer userId,Integer projectId) {
		String code=sysRoleService.selectInvestorsCode(userId);
		Integer number=sysFlowService.selectSysFlow(projectId);
		if(number >0 && code.equals("TZRDB")) {
			return 1;//已上传采购表或有审批流程未完成并且是投资人代表的
		}else if(number >0) {
			return 2;//申请分批
		}else {
			return 3;
		}
	}
	
	@RequestMapping("findProjectGroup")
	public @ResponseBody Object findProjectGroupDetail(int projectGroupId){
		return projectOrderService.findProjectGroupDetail(projectGroupId);
	} 
	
	@RequestMapping("findProjectGroupGoodsByprojectGroupId")
	public @ResponseBody Object findProjectGroupGoodsByprojectGroupId(int projectId,int projectGroupId){
		return projectOrderService.findProjectGroupGoodsByprojectGroupId(projectId,projectGroupId);
	}
	
	@RequestMapping("save")
	public @ResponseBody Object save(ProjectOrderGoodsForm projectOrderGoodsForm,ProjectOrder projectOrder){
		try {
			Double total;
			List<String> pname=projectOrderService.selectProjectOrder(projectOrder.getProjectId());
			projectOrder.setName("《"+projectOrder.getName()+"》项目采购表"+String.format("%02d",NumberUtils.continuous(pname)));
			projectOrderService.insert(projectOrder);
			
			List<ProjectOrderGoods> list = projectOrderGoodsForm.getProjectOrderGoodss();
			for(int i=0;i<list.size();i++){
				if(list.get(i).getAmount()>0 && list.get(i).getPrice()>0){
					list.get(i).setProjectId(projectOrder.getProjectId());
					list.get(i).setProjectOrderId(projectOrder.getId());
					list.get(i).setContractId(projectOrder.getContractId());
					total=list.get(i).getPrice()*list.get(i).getAmount();
					list.get(i).setTotal(total);
				}else{
					list.remove(i);
					i--;
				}
			}
			if(list.size()>0){
				SysFlow flow = new SysFlow();
				flow.setTitle(projectOrder.getName());
				flow.setBuyerId(projectOrder.getUserId());
				flow.setProjectId(projectOrder.getProjectId());
				flow.setProjectOrderId(projectOrder.getId());
				sysFlowService.insert(flow);
				
				projectOrderGoodsService.insertAll(list);
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("projectOrderName", projectOrder.getName());
				map.put("projectOrderId",projectOrder.getId());
				map.put("sysFlowId",flow.getId());
				return map;
			}else{
				projectOrderService.del(projectOrder.getId());
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@RequestMapping("selectContractList")
	public @ResponseBody Object selectContractList(int companyId){
		return projectOrderService.selectContractList(companyId);
	}
	@RequestMapping("findProjectUpdateOrderById")
	public @ResponseBody int findProjectUpdateOrderById(int projectId,int goodsId) {
		return projectOrderService.findProjectUpdateOrderById(projectId,goodsId);
	}
	
}