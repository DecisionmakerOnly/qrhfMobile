package com.qrhf.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.qrhf.pojo.Goods;
import com.qrhf.pojo.Seller;
import com.qrhf.pojo.User;
import com.qrhf.service.GoodsService;
import com.qrhf.service.SellerService;
import com.qrhf.tools.Tools;
import com.qrhf.tools.TreeviewUtil;

@Controller
@RequestMapping("/goods")
public class GoodsController {
	
	@Resource
	private GoodsService goodsService;
	@Resource
	private SellerService sellerService;
	
	/**
	 * 根据商品类型、名称、编码查询商品
	 * @param pageSize
	 * @param pageNumber
	 * @param goodsType
	 * @param goodsName
	 * @param goodsCode
	 * @return
	 */
	@RequestMapping("/findList")
	public @ResponseBody Object findList(int pageSize,int pageNumber,int goodsType,String goodsName,String goodsCode){
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("goodsType",goodsType==0?null:goodsType);
		param.put("goodsName",goodsName.equals("")?null:Tools.fuzzyQueryString(goodsName));
		param.put("goodsCode",goodsCode.equals("")?null:Tools.fuzzyQueryString(goodsCode));
		return goodsService.findList(param);
	}
	
	/**
	 * 查询商品类别树形结构
	 * @return
	 */
	@RequestMapping("/findGoodsTypeTree")
	public @ResponseBody Object findGoodsTypeTree(){
		return TreeviewUtil.conversionDataFromList(goodsService.findGoodsTypeTreeList());
	}
	
	@RequestMapping("/getGoodsById")
	public ModelAndView selectGoodsById(Integer id,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Goods goods = goodsService.getGoodsById(id);
		
		User user = (User) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		Seller seller = sellerService.compreSeller(userId);
		
		mav.addObject("seller", seller);
		mav.addObject("goods", goods);
		mav.setViewName("/sellergoods/addgoods");
		return mav;
	}
	
	@RequestMapping("findGoodsById")
	public @ResponseBody Object findGoodsById(int goodsId){
		return goodsService.getGoodsById(goodsId);
	}
	
	@RequestMapping("addCompanyCustomGoods")
	public @ResponseBody Object addCompanyCustomGoods(Goods goods){
		return goodsService.addCompanyCustomGoods(goods);
	}
}
