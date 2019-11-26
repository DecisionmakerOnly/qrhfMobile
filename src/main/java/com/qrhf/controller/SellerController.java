package com.qrhf.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qrhf.pojo.Seller;
import com.qrhf.pojo.User;
import com.qrhf.service.SellerService;
import com.qrhf.tools.UUIDGenerator;

@Controller
@RequestMapping("/seller")
public class SellerController {
	
	@Autowired
	private SellerService sellerService;
	/**
	 * 判断用户是否创建店铺 没有店铺就创建 有就跳转到店铺详情页
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/compareSeller")
	@ResponseBody
	public ModelAndView compareSel(HttpServletRequest request) throws IOException {
		User user = (User) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		ModelAndView mav = new ModelAndView();
		Seller sell = sellerService.compreSeller(userId);
		if(sell!=null) {
			mav.addObject("sell", sell);
			mav.setViewName("seller/sellerCenter");
		}else {
			mav.setViewName("seller/add");
		}
		return mav;
	}
	
	/**
	 * 买家可以看到的所有供应商的信息
	 * @param pageNum
	 * @param name
	 * @param infor
	 * @return
	 */
	@RequestMapping("/findList")
	public ModelAndView getEmps(@RequestParam(value="pageNum", defaultValue="1")Integer pageNum,String name,String infor) {
		//引入PageHelper分页插件
		//在查询之前只需要调用。传入页码，以及每页大小
		PageHelper.startPage(pageNum,4);
		//startPage后面紧跟的查询就是分页查询
		Map<String, Object> param=new HashMap<String, Object>();
		param.put("name", name);
		param.put("infor", infor);
		List<Seller> seller = sellerService.sellerList(param);
		//pageInfo包装查询后的结果，只需要将pageINfo交给页面
		//封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(seller,5);
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageInfo", page);
		mav.addObject("name", name);
		mav.addObject("infor", infor);
		mav.setViewName("supplier/list");
		return mav;
	}
	
	/**
	 * 添加卖家创建的店铺信息和上传店铺图片
	 * @param req
	 * @param resp
	 * @param file
	 * @param seller
	 * @return
	 */
	@RequestMapping("addSeller")
    @ResponseBody
    public Integer add(HttpServletRequest req, HttpServletResponse resp,
                    @RequestParam(value = "file", required = false) MultipartFile file, Seller seller) {
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		String userName = user.getUserName();
		seller.setUserId(userId);
		seller.setOwner(userName);
		Integer sel = null;
		try {
            //获得项目的绝对路径
            if(file!=null) {
//                String path = req.getSession().getServletContext().getRealPath("image\\brand");
                String path = req.getServletContext().getRealPath("image/");
                String filename = file.getOriginalFilename();
                String saveFileName = UUIDGenerator.getUUID() + filename.substring(filename.lastIndexOf("."));
                File targetFile = new File(path, saveFileName);
                //如果文件夹不存在 创建一个新的文件夹
                if (!targetFile.exists()) {
                    targetFile.mkdirs();
                }
                file.transferTo(targetFile);
                seller.setImageUrl(saveFileName);
            }
                sel = sellerService.addSeller(seller);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		return sel;
    }
	
	@RequestMapping("/toUpdate")
	public ModelAndView toUpdate(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User user = (User) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		Seller seller = sellerService.compreSeller(userId);
		mav.addObject("seller", seller);
		mav.setViewName("seller/edit");
		return mav;
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public void update(Seller seller) {
		sellerService.updateSeller(seller);
	}
	
	/**
	 * 验证供应商名称是否存在
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("checkName")
	public void checkName(HttpServletResponse response,String name) throws IOException {
		PrintWriter out = response.getWriter();
		Seller seller = sellerService.checkName(name);
		if (seller != null) {
			out.println(1);
		} else {
			out.println(2);
		}
	}
	
	/**
	 * 验证手机号是否存在
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("checkContact")
	public void checkLoginPhone(HttpServletResponse response,String contact) throws IOException {
		PrintWriter out = response.getWriter();
		Seller seller = sellerService.checkContact(contact);
		if (seller != null) {
			out.println(1);
		} else {
			out.println(2);
		}
	}
	
}
