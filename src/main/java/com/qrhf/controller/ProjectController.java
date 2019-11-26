package com.qrhf.controller;

import com.qrhf.pojo.*;
import com.qrhf.service.*;
import com.qrhf.tools.ExcelUtil;
import com.qrhf.tools.Tools;
import com.qrhf.tools.TreeviewUtil;
import com.qrhf.vo.Node;
import com.qrhf.vo.ProjectUpdateGoodsVO;
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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.IntrospectionException;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.util.*;


@Controller
@RequestMapping("/project")
public class ProjectController {

	@Autowired
	private ProjectService projectService;
	@Autowired
	private ProjectGoodsService projectGoodsService;
	@Autowired
	private ProjectOrderGoodsService projectOrderGoodsService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private TemporaryProjectGoodService tpgService;
	@Autowired
	private ProjectUpdateService projectUpdateService;
	@Autowired
	private ProjectUpdateGoodsService projectUpdateGoodsService;
	@Autowired
	private ProjectGroupService projectGroupService;
	@Resource
	private ProjectOrderService projectOrderService;
	
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setAutoGrowCollectionLimit(10000);  
    }
	@RequestMapping("/findList")
	public @ResponseBody Object list(HttpServletRequest request, int pageSize, int pageNumber) {
		User user = (User) request.getSession().getAttribute("user");
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("userId", user.getId());
		param.put("companyId", user.getCompanyId());
		param.put("departmentId", user.getDepartmentId());
		return projectService.findList(param);
	}
	
	@RequestMapping("findProjectGoodsListNoPagination")
	public @ResponseBody List<ProjectGoods> findProjectGoodsListNoPagination(int projectId,int projectUpdateId,int isSysGoods,int isValid,String searchName,int companyId){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("projectId",projectId);
		param.put("companyId",companyId);
		param.put("projectUpdateId",projectUpdateId);
		param.put("isSysGoods",isSysGoods);
		param.put("isValid",isValid);
		param.put("searchName",Tools.fuzzyQueryString(searchName));
		param.put("searchCode",searchName);
		return projectGoodsService.findListNoPagination(param);
	}
	
	@RequestMapping("findUpdateGoodsListNoPagination")
	public @ResponseBody List<ProjectGoods> findUpdateGoodsListNoPagination(int projectId,int projectUpdateId,int isSysGoods,int isValid,String searchName,int companyId){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("projectId",projectId);
		param.put("companyId",companyId);
		param.put("projectUpdateId",projectUpdateId);
		param.put("isSysGoods",isSysGoods);
		param.put("isValid",isValid);
		param.put("searchName",searchName);
		return projectGoodsService.findListNoPagination(param);
	}
	
	@RequestMapping("/findSystemGoods")
	public @ResponseBody Object findSystemGoods(int pageSize, int pageNumber,int projectId,int projectUpdateId,String searchName) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId",projectId);
		param.put("projectUpdateId",projectUpdateId);
		param.put("searchName",Tools.fuzzyQueryString(searchName));
		param.put("searchCode",searchName);
		return goodsService.findSystemGoods(param);
	}
	
	@RequestMapping("/findCompanyCustomGoods")
	public @ResponseBody Object findCompanyCustomGoods(int pageSize, int pageNumber,int companyId,int projectId,int projectUpdateId,String searchName) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyId",companyId);
		param.put("projectId",projectId);
		param.put("projectUpdateId",projectUpdateId);
		param.put("searchName",Tools.fuzzyQueryString(searchName));
		param.put("searchCode",searchName);
		return goodsService.findCompanyCustomGoods(param);
	}
	
	
	
	@RequestMapping("findProjectGoodsById")
	public @ResponseBody ProjectGoods findProjectGoodsById(int projectGoodsId,int projectUpdateId){
		return projectGoodsService.findProjectGoodsById(projectGoodsId,projectUpdateId);
	}
	
	@RequestMapping("findProjectGoodsByCode")
	public @ResponseBody ProjectGoods findProjectGoodsByCode(int projectId,String code,int projectUpdateId,int companyId){
		return projectGoodsService.findProjectGoodsByCode(projectId,code,projectUpdateId,companyId);
	}
	
	@RequestMapping("findProjectUpdateGoodsById")
	public @ResponseBody ProjectUpdateGoodsVO findProjectUpdateGoodsById(int projectUpdateGoodsId){
		return projectUpdateGoodsService.findProjectUpdateGoodsById(projectUpdateGoodsId);
	}
	
	@RequestMapping("saveProjectUpdate")
	public @ResponseBody Object saveProjectUpdate(ProjectUpdate projectUpdate){
		return projectUpdateService.saveProjectUpdate(projectUpdate);
	}

	@RequestMapping("saveOrUpdateForProjectUpdateGoods")
	public @ResponseBody Object saveOrUpdateForProjectUpdateGoods(ProjectUpdateGoods projectUpdateGoods,Goods goods,double oldAmount,double oldPrice,int editStatus,Integer projectId,Integer goodsId){
		Double price = projectUpdateGoods.getPrice();
		Double amount = projectUpdateGoods.getAmount();
		if(price==null) {
			projectUpdateGoods.setPrice(oldPrice);
		}else {
			String format = String.format("%.2f", price);
			projectUpdateGoods.setPrice(Double.parseDouble(format));
		}

		int projectOrderAmount=projectOrderService.findProjectUpdateOrderById(projectId,goodsId);
		if(amount==null) {
			projectUpdateGoods.setAmount(oldAmount);
		}else {
			if(editStatus==1) {
				projectUpdateGoods.setAmount(oldAmount+amount);
			}else if(editStatus==2) {
				if(amount>oldAmount) {
					return 2;
				}
				if((double) projectOrderAmount>(oldAmount-amount)) {
					return 3;
				}
				projectUpdateGoods.setAmount(oldAmount-amount);
			}
		}

		if(projectUpdateGoods.getGoods() == 0){
			goodsService.insert(goods);
			projectUpdateGoods.setGoods(goods.getId());
		}
		projectUpdateGoods.setIsValid(0);
		projectUpdateGoods.setEditStatus(editStatus);
		projectUpdateGoods.setEditAmount(amount==null?0:amount);
		return projectUpdateGoodsService.saveOrUpdate(projectUpdateGoods);
	}
	
	@RequestMapping("saveForProjectUpdateGoods")
	public @ResponseBody Object saveForProjectUpdateGoods(ProjectUpdateGoods projectUpdateGoods,Goods goods,Integer projectId,Integer goodsId){
		projectUpdateGoods.setStatus(1);
		projectUpdateGoods.setIsValid(0);
		return projectUpdateGoodsService.saveOrUpdate(projectUpdateGoods);
	}

	@RequestMapping("/detail")
	public @ResponseBody Object detail(Integer pageSize, Integer pageNumber, Integer projectId,Integer isValid,Integer updateType,String searchName,Integer projectUpdate) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId", projectId);
		param.put("isValid",isValid);
		param.put("projectUpdate",projectUpdate);
		param.put("updateType",updateType);
		param.put("searchName",searchName);
		return projectGoodsService.findList(param);
	}
	
	@RequestMapping("/mismatch")
	public @ResponseBody Object mismatch(Integer pageSize, Integer pageNumber, int projectId,int isValid,int updateType,String searchName,Integer projectUpdate,Integer companyId) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId", projectId);
		param.put("companyId", companyId);
		param.put("isValid", isValid);
		param.put("projectUpdate",projectUpdate);
		param.put("updateType", updateType);
		param.put("searchName",searchName);
		return projectGoodsService.findMismatch(param);
	}

	@RequestMapping("/findListForUpdate")
	public @ResponseBody List<ProjectUpdateGoodsVO> findListForUpdate(int projectId,int projectUpdateId,int sysFlowId) {
		return projectUpdateGoodsService.findListForUpdate(projectId,projectUpdateId,sysFlowId);
	}

	@RequestMapping("/del")
	public @ResponseBody Object del(int projectId) {
		projectService.del(projectId);
		return 1;
	}
	@RequestMapping("/projectGoodsDel")
	public @ResponseBody Object projectGoodsDel(int projectId) {
		projectGoodsService.projectGoodsDel(projectId);
		return 1;
	}
	@RequestMapping("deleteGoodsAll")
	public @ResponseBody Object deleteGoodsAll(int projectId) {
		return projectService.deleteGoodsAll(projectId);
	}

	@RequestMapping("/export")
	public @ResponseBody void export(HttpServletRequest request, HttpServletResponse response) throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		String salaryDate = request.getParameter("测试");
		if (salaryDate != "") {
			response.reset(); // 清除buffer缓存
			// 指定下载的文件名
			response.setHeader("Content-Disposition", "attachment;filename=" + salaryDate + ".xlsx");
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			XSSFWorkbook workbook = null;
			// 导出Excel对象
			workbook = exportExcelInfo(user, salaryDate);
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

	public XSSFWorkbook exportExcelInfo(User user, String salaryDate) throws InvocationTargetException,
			ClassNotFoundException, IntrospectionException, ParseException, IllegalAccessException {
		// 根据条件查询数据，把数据装载到一个list中
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", user.getId());
		param.put("departmentId", user.getDepartmentId());
		param.put("companyId", user.getCompanyId());
		List<Project> list = (List<Project>) projectService.findList(param).get("rows");
		List<ExcelBean> excel = new ArrayList<>();
		Map<Integer, List<ExcelBean>> map = new LinkedHashMap<>();
		XSSFWorkbook xssfWorkbook = null;
		// 设置标题栏
		excel.add(new ExcelBean("序号", "id", 0));
		excel.add(new ExcelBean("名称", "name", 0));
		// excel.add(new ExcelBean("工号","number",0));
		// excel.add(new ExcelBean("姓名","name",0));
		// excel.add(new ExcelBean("性别","sex",0));
		// excel.add(new ExcelBean("开户名","cardName",0));
		// excel.add(new ExcelBean("银行卡号","bankCard",0));
		// excel.add(new ExcelBean("开户行","bank",0));
		// excel.add(new ExcelBean("金额","money",0));
		// excel.add(new ExcelBean("备注","remark",0));
		map.put(0, excel);
		String sheetName = salaryDate + "月份收入";
		// 调用ExcelUtil的方法
		xssfWorkbook = ExcelUtil.createExcelFile(Project.class, list, map, sheetName);
		return xssfWorkbook;
	}

	@RequestMapping("/upload")
	public @ResponseBody Integer upload(@RequestParam(value = "file", required = false) MultipartFile file,int projectId,int companyId) throws Exception   {
		if (!file.isEmpty()) {
			InputStream in = file.getInputStream();
			return save(in, file, projectId,companyId);
		} else {
			return 0;
		}
	}

	@RequestMapping("/selectGoodsQuantity")
	@ResponseBody
	public int selectGoodsQuantity(Integer projectId) {
		Integer pg = projectGoodsService.selectGoodsQuantity(projectId);
		if (pg > 0) {
			return 1;
		} else {
			return 0;
		}
	}

	@RequestMapping("/selectDutyCount")
	public @ResponseBody int selectDutyCount(int projectId) {
		return projectService.selectDutyCount(projectId);
	}

	public int save(InputStream in, MultipartFile file, int projectId,int companyId) throws Exception {
		List<List<Object>> listob = ExcelUtil.getBankListByExcel(in, file.getOriginalFilename());
		List<ProjectGoods> pgList = new ArrayList<>();
		Set<Goods> goodSet = new HashSet<>();
		for (int i = (Integer) listob.get(listob.size() - 1).get(0); i < listob.size() - 1; i++) {
			List<Object> ob = listob.get(i);
			ProjectGoods record = new ProjectGoods();
			Goods goods = new Goods();
			
			if (ob.get(2) != null & !ob.get(2).equals("")) {
				record.setCode(String.valueOf(ob.get(2)));
				goods.setCode(String.valueOf(ob.get(2)));
			} else {
				continue;
			}
			if (ob.get(1) != null & !ob.get(1).equals("")) {
				record.setAsName(String.valueOf(ob.get(1)));
				goods.setName(String.valueOf(ob.get(1)));
			}
			if (ob.get(3) != null & !ob.get(3).equals("")) {
				record.setType(String.valueOf(ob.get(3)));
				goods.setType(String.valueOf(ob.get(3)));
			}
			if (ob.get(4) != null & !ob.get(4).equals("")) {
				record.setUnit(String.valueOf(ob.get(4)));
				goods.setUnit(String.valueOf(ob.get(4)));
			}
			if (ob.get(5) != null & !ob.get(5).equals("")) {
				record.setAmount(Double.valueOf((String) ob.get(5)));
			}
			if (ob.get(6) != null & !ob.get(6).equals("")) {
				record.setPrice(Tools.priceFormat(Double.valueOf((String) ob.get(6))));
			}
			if (null != (String) ob.get(5) && !"".equals((String) ob.get(5)) && null != (String) ob.get(6)
					&& !"".equals((String) ob.get(6))) {
				Double d1 = Tools.priceFormat(Double.valueOf((String) ob.get(6)));
				Double num = Double.valueOf((String) ob.get(5));
				record.setTotal(d1 * num);
			}
			record.setProjectId(projectId);
			record.setCompanyId(companyId);
			goods.setCompanyId(companyId);
			pgList.add(record);
			goodSet.add(goods);
		}
		goodsService.queryCode(goodSet,pgList, companyId);
		return projectGoodsService.insertAll(pgList, projectId,companyId);
	}

	@RequestMapping("updateProject")
	public @ResponseBody Integer updateProject(Project project) {
		return projectService.updateByPrimaryKey(project);
	}

	@RequestMapping("addProject")
	public @ResponseBody Integer addProject(Project project) {
		return projectService.insert(project);
	}

	@RequestMapping("updateProjectUpdateResourceAll")
	public @ResponseBody Object updateProjectUpdateResourceAll(ProjectUpdateResourceForm projectUpdateResourceForm) {
		return projectService.updateProjectUpdateResourceAll(projectUpdateResourceForm.getProjectUpdateResources());
	}

	@RequestMapping("updateProjectGoodsAll")
	public @ResponseBody Object updateProjectGoodsAll(ProjectGoodsForm projectGoodsForm) {
		return projectService.updateProjectGoodsAll(projectGoodsForm.getProjectGoodss());
	}
	
	/**
	 * 点击项目采购控制表修改 把选中的数据插入到临时表
	 * @param id
	 * @return
	 */
	@RequestMapping("selectProjectGoodsById")
	@ResponseBody
	public ModelAndView selectProjectGoodsById(int id) {
		TemporaryProjectGoods tpg = tpgService.selectTemporaryProjectGoodsByPGId(id);
		ModelAndView mav = new ModelAndView("/project/goodsEdit");
		mav.addObject("tpg", tpg);
		return mav;
	}
	
	@RequestMapping("updateTemporaryProjectGoods")
	@ResponseBody
	public int updateTemporaryProjectGoods(TemporaryProjectGoods temporaryprojectGoods) {
		int tpg = tpgService.updateTemporaryProjectGoods(temporaryprojectGoods);
		return tpg;
	}
	
	@RequestMapping("addTemporaryProjectGoods")
	@ResponseBody
	public int addTemporaryProjectGoods(int projectOrderGoodsId) {
		int pog = projectOrderGoodsService.selectById(projectOrderGoodsId);
		return pog;
	}
	
	@RequestMapping("deleteProjectGoodsById")
	@ResponseBody
	public int deleteProjectGoodsById(int projectGoodsId,int projectUpdateId) {
		ProjectGoods projectGoods = projectGoodsService.selectProjectGoodsById(projectGoodsId);
		ProjectUpdateGoods projectUpdateGoods = new ProjectUpdateGoods();
		projectUpdateGoods.setProject(projectGoods.getProjectId());
		projectUpdateGoods.setProjectUpdate(projectUpdateId);
		projectUpdateGoods.setGoods(projectGoods.getGoodsId());
		projectUpdateGoods.setAsName(projectGoods.getAsName());
		projectUpdateGoods.setPrice(projectGoods.getPrice());
		projectUpdateGoods.setAmount(projectGoods.getAmount());
		projectUpdateGoods.setTotal(projectGoods.getPrice() * projectGoods.getAmount());
		projectUpdateGoods.setStatus(-1);
		projectUpdateGoodsService.saveOrUpdate(projectUpdateGoods);
		
		
		
//		BeanUtils.copyProperties(projectGoods,projectUpdateGoods);
//		projectUpdateGoods.setStatus(0);
//		int tpg = tpgService.addTemporaryProjectGoods(projectGoods);
//		if(tpg==1) {
//			return tpg;
//		}
//		int pg = projectGoodsService.deleteProjectGoodsById(id);
		return 1;
	}
	
	@RequestMapping("updateProjectGoodsByProjectUpdateGoods")
	public @ResponseBody int updateProjectGoodsByProjectUpdateGoods(int projectId,int projectUpdateId,int companyId) {
		int num = projectGoodsService.updateProjectGoodsByProjectUpdateGoods(projectId,projectUpdateId,companyId); 
		if(num == 1){
			projectUpdateGoodsService.updateAll(projectUpdateId);
			projectUpdateService.updateAll(projectUpdateId);
		}
		int number=projectGroupService.selectGroupDate(projectId);
		int smallCurrentGroup=projectGroupService.selectSmallCurrentGroup(projectId);
		if(number > 0) {
			projectGoodsService.selectProjectUpdateGroup(projectId,projectUpdateId);
		}else if(number<=0 && smallCurrentGroup>0){
			projectGoodsService.updateNotProjectGroup(projectId,projectUpdateId);
		}
		return num;
	}
	
	@ResponseBody
	@RequestMapping("selectProjectGoodsCount")
	public int selectProjectGoodsCount(int projectId) {
		int pog = projectGoodsService.selectProjectGoodsCount(projectId);
		return pog;
	}
	
	@ResponseBody
	@RequestMapping("selectByPoId")
	public int selectByPoId(int projectOrderId) {
		List<TemporaryProjectGoods> list = tpgService.selectByPoId(projectOrderId);
		return list.size();
	}
	
	@RequestMapping("/contrastProjectGoods")
	@ResponseBody
	public int contrastProjectGoods(Integer projectId) {
		Integer number=projectService.contrastProjectGoods(projectId);
		if(number >0) {
			return 1;
		}else  {
			return 2;
		}
		 
	}
	
	@RequestMapping("preservation")
	public void preservation(int projectId){
		projectGoodsService.preservation(projectId);
	}
	
	@RequestMapping("selectProject")
	@ResponseBody
	public Project selectProject(int id) {
		Project project = projectService.selectProject(id);
		return project;
	}
	
	@RequestMapping("selectDutyUserNum")
	public @ResponseBody Object selectDutyUserNum(int projectId) {
		List<Node> user = projectService.selectDutyUser(projectId);
		return user;
	}
	
	@RequestMapping("selectDutyUser")
	public @ResponseBody Object selectDutyUser(int projectId) {
		return TreeviewUtil.conversionDataFromList(projectService.selectDutyUser(projectId));
	}
	
	@RequestMapping("selectZero")
	public @ResponseBody int selectZero(int projectOrderId) {
		return tpgService.selectZero(projectOrderId);
	}
	@RequestMapping("returnCheckBox")
	public @ResponseBody Object returnCheckBox(@RequestParam("departmentId") int departmentId,@RequestParam("companyId")int companyId ) {
		return TreeviewUtil.conversionDataFromList(projectService.getCheckBox(departmentId, companyId));
	}
	@RequestMapping("selectProjectQuantity")
	@ResponseBody
	public int selectProjectQuantity(int companyId) {
		int number=projectService.selectProjectQuantity(companyId);
		if(number>0) {
			return 1;
		}else {
			return 2;
		}
	}
	@RequestMapping("updateDepartmentId")
	public @ResponseBody int updateDepartmentId(int companyId,int projectId,int departmentId) {
		return projectService.updateDepartmentId(projectId, departmentId);
	}
	@RequestMapping("submitTable")
	public @ResponseBody int submitTable(ProjectUpdate projectUpdate) {
		return	projectUpdateService.updateProjectUpdate(projectUpdate);
	}
	
	@RequestMapping("findProjectUpdateById")
	public @ResponseBody Object findProjectUpdateById(int projectUpdateId){
		return projectUpdateService.findProjectUpdateById(projectUpdateId);
	}
	
	@RequestMapping("projectUpdateGoodsUpdate")
	public @ResponseBody int projectUpdateGoodsUpdate(ProjectUpdateGoods projectUpdateGoods,double oldAmount,double oldPrice,
													  int editStatus,Integer projectId,Integer goodsId,int oldEditStatus){
		Double price = projectUpdateGoods.getPrice();
		Double amount = projectUpdateGoods.getAmount();
		Double editAmount = projectUpdateGoods.getEditAmount();
		if(oldEditStatus==2){
			editAmount = editAmount*-1;
		}
		projectUpdateGoods.setProjectGoodsAmount(oldAmount);
		if(price==null) {
			projectUpdateGoods.setPrice(oldPrice);
		}else {
			String format = String.format("%.2f", price);
			projectUpdateGoods.setPrice(Double.parseDouble(format));
		}
		int projectOrderAmount=projectOrderService.findProjectUpdateOrderById(projectId,goodsId);
		if(amount==null) {
			projectUpdateGoods.setAmount(oldAmount);
		}else {
			if(editStatus==1) {
				projectUpdateGoods.setEditStatus(1);
				projectUpdateGoods.setAmount(oldAmount+amount);
				projectUpdateGoods.setEditAmount(editAmount+amount);
			}else if(editStatus==2) {
				if(amount>oldAmount) {
					return 2;
				}
				if((double) projectOrderAmount>(oldAmount-amount)) {
					return 3;
				}
				double result = editAmount-amount;
				if(result>0){
					projectUpdateGoods.setEditStatus(2);
				}else{
					projectUpdateGoods.setEditStatus(1);
				}
				projectUpdateGoods.setAmount(oldAmount-amount);
				projectUpdateGoods.setEditAmount(result);
			}
		}
		return projectUpdateGoodsService.projectUpdateGoodsUpdate(projectUpdateGoods);
	}
	@RequestMapping("projectUpdateGoodsDel")
	public @ResponseBody int projectUpdateGoodsDel(int projectUpdateGoodsId){
		return projectUpdateGoodsService.projectUpdateGoodsDel(projectUpdateGoodsId);
	}
	
	@RequestMapping("selectCount")
	@ResponseBody
	public int selectCount(int projectId,int projectUpdateId) {
		return projectUpdateGoodsService.selectCount(projectId,projectUpdateId);
	}
	
	@RequestMapping("isExists")
	public void isExists() {
		System.out.println("session存活");
	}
	
	@RequestMapping("dataHistory")
	@ResponseBody
	public Object dataHistory(int pageSize, int pageNumber,int projectId,int isValid,String searchName,int updateType){
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId", projectId);
		param.put("isValid", isValid);
		param.put("updateType", updateType);
		param.put("searchName",searchName);
		return projectUpdateGoodsService.findList(param);
	}

	@RequestMapping("getEditCount")
	@ResponseBody
	public int getEditCount(ProjectUpdateGoods goods) {
		return projectUpdateGoodsService.getEditCount(goods);
	}
	@RequestMapping("singleProjectGoodsData")
	@ResponseBody
	public Object singleProjectGoodsData(int pageSize, int pageNumber,int projectId,int goodsId) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("projectId", projectId);
		param.put("goodsId", goodsId);
		return projectUpdateGoodsService.findSingle(param);
	}
	@RequestMapping("findProjectUpdateBatches")
	@ResponseBody
	public Object findProjectUpdateBatches(int projectId,int updateType) {
		List<ProjectUpdate> list =projectUpdateService.findProjectUpdateBatches(projectId,updateType);
		return list;
	}
	
}
