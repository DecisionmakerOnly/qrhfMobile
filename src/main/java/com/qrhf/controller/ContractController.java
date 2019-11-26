package com.qrhf.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.qrhf.pojo.Contract;
import com.qrhf.pojo.ContractInvoice;
import com.qrhf.pojo.ContractList;
import com.qrhf.pojo.ContractListGoods;
import com.qrhf.pojo.ContractPay;
import com.qrhf.pojo.User;
import com.qrhf.service.ContractListGoodsService;
import com.qrhf.service.ContractListService;
import com.qrhf.service.ContractService;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/contract")
public class ContractController {
	
	@Autowired
	private ContractService contractService;
	@Autowired
	private ContractListService contractListService;
	@Autowired
	private ContractListGoodsService contractListGoodsService;
	
	@RequestMapping("findProjectOrder")
	public @ResponseBody Object findProjectOrder(int projectOrderId){
		return contractListGoodsService.findProjectOrder(projectOrderId);
	}
	
	@RequestMapping("saves")
	public @ResponseBody int saves(HttpServletRequest request,@RequestParam("datalist")String list,int contractId,int projectId,int projectOrderId) {
		User user = (User) request.getSession().getAttribute("user");
		ContractList contractList = new ContractList();
		contractList.setCompanyId(user.getCompanyId());
		contractList.setName(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
		contractList.setProjectId(projectId);
		contractList.setProjectOrderId(projectOrderId);
		contractList.setContractId(contractId);
		contractListService.save(contractList);
		List<Map<String, Object>>mapListJson  = (List)JSONArray.fromObject(list);
		for (Map<String, Object> param : mapListJson) {
			param.put("contractListId",contractList.getId());
			param.put("projectOrderId",projectOrderId);
			param.put("projectId",projectId);
			
		}
		int saves = contractListGoodsService.saves(mapListJson);
		if(saves>=1) {
			return contractList.getId();
		}else {
			return 0;
		}
	}
	
	@RequestMapping("findList")//1
	public @ResponseBody Object findList(int pageSize,int pageNumber,HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("user");
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("companyId",user.getCompanyId());
		param.put("userId",user.getId());
		return contractService.findList(param);
	}
	
	@RequestMapping("findProjectList")
	public @ResponseBody Object findProjectList(int contractId){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("contractId",contractId);
		return contractService.findProjectList(param);
	}
	
	@RequestMapping("findProjectOrderList")
	public @ResponseBody Object findProjectOrderList(int projectId,int contractId){
		return contractService.findProjectOrderList(projectId,contractId);
	}
	
	@RequestMapping("findProjectOrderGoodsList")
	public @ResponseBody Object findProjectOrderGoodsList(int projectOrderId){
		return contractListGoodsService.findProjectOrder(projectOrderId);
	}
	
	@RequestMapping("findGoods")
	public @ResponseBody Object findGoods(int contractId,int projectId,int projectOrderId){
		return contractListGoodsService.findGoods(contractId,projectId,projectOrderId);
	}
	
	@RequestMapping("detail")//1
	public @ResponseBody Object detail(int pageSize,int pageNumber,int contractId,int projectId,int contractListId) {
		Map<String, Object> param = new HashMap<String, Object>();
		int a = (pageNumber - 1) * pageSize;
		int b = pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("contractId",contractId);
		param.put("projectId",projectId);
		param.put("contractListId",contractListId);
		return contractListGoodsService.findList(param);
	}
	
	@RequestMapping("findContractFilePath")//1
	public @ResponseBody Object findContractFilePath(int contractId){
		Contract contract = contractService.findContractFilePath(contractId);
		return contract.getFilePath();
	}
	
	@RequestMapping("del")
	public @ResponseBody Object del(int contractId){
		return contractService.del(contractId);
	}
	@RequestMapping("delContractListId")
	public @ResponseBody Object delContractListId(int contractListId){
		return contractListService.delContractListId(contractListId);
	}
	@RequestMapping("selectProject")
	public @ResponseBody Object selectProject(int userId){
		return contractService.selectProject(userId);
	}
	
	@RequestMapping("selectProjectOrder")
	public @ResponseBody Object selectProjectOrder(int projectId){
		return contractService.selectProjectOrder(projectId);
	}
	
	@RequestMapping("exportContract")
    public @ResponseBody void exportContract(HttpServletResponse response,HttpServletRequest request,int contractId) throws IOException{
		Contract contract = contractService.findContractFilePath(contractId);
        List<ContractListGoods> goodsList = contractListGoodsService.findContractListGoodsList(contractId);
		String filePath = request.getSession().getServletContext().getRealPath("file/upload/contract/"+contract.getFilePath());
		
		FileInputStream stream = new FileInputStream(new File(filePath));
		XWPFDocument doc = new XWPFDocument(stream);// 创建Word文件
		//XWPFDocument document = new XWPFDocument();
        FileOutputStream out = new FileOutputStream(new File(filePath));
        XWPFTable table = doc.createTable();
        table.setWidth(1000);
        
        XWPFTableRow title = table.getRow(0);
        title.getCell(0).setText("序号");
        title.addNewTableCell().setText("名称");
        title.addNewTableCell().setText("规格");
        title.addNewTableCell().setText("单位");
        title.addNewTableCell().setText("数量");
        title.addNewTableCell().setText("单价");
        title.addNewTableCell().setText("合计");
        
        for(int i=0;i<goodsList.size();i++){
        	ContractListGoods goods = goodsList.get(i);
        	XWPFTableRow row = table.createRow();
        	row.getCell(0).setText((i+1)+"");
        	row.getCell(1).setText(goods.getName());
        	row.getCell(2).setText(goods.getType());
        	row.getCell(3).setText(goods.getUnit());
        	row.getCell(4).setText(goods.getAmount()+"");
        	row.getCell(5).setText(goods.getPrice()+"");
        	row.getCell(6).setText(goods.getTotal()+"");
        }
        doc.write(out);
        out.close();
        downloadLocal(response,contract.getName(),filePath);
    }
	
	public void downloadLocal(HttpServletResponse response,String fileName,String filePath) throws FileNotFoundException {
        // 读到流中
        InputStream inStream = new FileInputStream(filePath);// 文件的存放路径
        // 设置输出的格式
        response.reset();
        response.setContentType("bin");
        response.addHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        // 循环取出流中的数据
        byte[] b = new byte[100];
        int len;
        try {
            while ((len = inStream.read(b)) > 0) 
            	response.getOutputStream().write(b, 0, len);
            inStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

	/**
     * 文件上传功能
     * @param fileO
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="/upload",method=RequestMethod.POST)
    public @ResponseBody Object upload(HttpServletRequest request,MultipartFile file){
    	try {
    		User user = (User) request.getSession().getAttribute("user");
    		Long time = new Date().getTime();
    		String path = request.getSession().getServletContext().getRealPath("file/upload/contract/"+time);
	        String fileName = file.getOriginalFilename().substring(0,file.getOriginalFilename().lastIndexOf('.'));  
	        File dir = new File(path,+time+".doc");      
	        if(!dir.exists()){
	            dir.mkdirs();
	        }
	        //MultipartFile自带的解析方法
	        file.transferTo(dir);
	        Contract contract = new Contract();
	        contract.setCompanyId(user.getCompanyId());
	        contract.setName(fileName);
	        contract.setFilePath(time+"/"+time+".doc");
	        contractService.save(contract);
	        return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
    }
    
    @RequestMapping("delContractListGoodsByIds")
    public @ResponseBody int delContractListGoodsByIds(String ids){
    	return contractListGoodsService.delContractListGoodsByIds(ids);
    }
    
    @RequestMapping("selectNameByProjectOrderId")
    @ResponseBody
    public Contract selectNameByProjectOrderId(int projectOrderId) {
    	return contractService.selectNameByProjectOrderId(projectOrderId);
    }
    
    @RequestMapping("contractPay")
    public @ResponseBody Object contractPay(ContractPay contractPay){
    	return contractService.contractPay(contractPay);
    }
    
    @RequestMapping("contractPayList")
    public @ResponseBody Object contractPayList(int contractId){
    	return contractService.contractPayList(contractId);
    }
    
    @RequestMapping("contractPayDel")
    public @ResponseBody Object contractPayDel(int contractPayId){
    	return contractService.contractPayDel(contractPayId);
    }
    
    @RequestMapping("contractInvoice")
    public @ResponseBody Object contractInvoice(HttpSession httpSession,ContractInvoice contractInvoice){
    	User user = (User)httpSession.getAttribute("user");
    	contractInvoice.setCompanyId(user.getCompanyId());
    	return contractService.contractInvoice(contractInvoice);
    }
    
    @RequestMapping("contractInvoiceList")
    public @ResponseBody Object contractInvoiceList(int contractId){
    	return contractService.contractInvoiceList(contractId);
    }
    
    @RequestMapping("contractInvoiceDel")
    public @ResponseBody Object contractInvoiceDel(int contractInvoiceId){
    	return contractService.contractInvoiceDel(contractInvoiceId);
    }
}
