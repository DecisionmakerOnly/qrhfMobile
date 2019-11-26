package com.qrhf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qrhf.pojo.SellerGoods;
import com.qrhf.pojo.User;
import com.qrhf.service.SellerGoodsService;
import com.qrhf.tools.Tools;

@Controller
@RequestMapping("/sellerGoods")
public class SellerGoodsController {
	
	@Autowired
	private SellerGoodsService sellerGoodsService;
	
	/**
	 * 卖家登录时展示的商品信息
	 * @param pageSize
	 * @param pageNumber
	 * @param goodsType
	 * @param goodsName
	 * @param goodsCode
	 * @return
	 */
	@RequestMapping("/findList")
	public @ResponseBody Object list(HttpServletRequest req,int pageSize,int pageNumber,int goodsType,String goodsName,String goodsCode){
		User user = (User) req.getSession().getAttribute("user");
		Integer userId = user.getId();
		Map<String, Object> param=new HashMap<String, Object>();
		int a=(pageNumber-1)*pageSize;
		int b=pageSize;
		param.put("a", a);
		param.put("b", b);
		param.put("userId", userId);
		param.put("goodsType",goodsType==0?null:goodsType);
		param.put("goodsName",goodsName.equals("")?null:Tools.fuzzyQueryString(goodsName));
		param.put("goodsCode",goodsCode.equals("")?null:Tools.fuzzyQueryString(goodsCode));
		return sellerGoodsService.findList(param);
	}

	@RequestMapping("/addGoods")
	@ResponseBody
	public Integer addGoods(double price,int amount,int goodsId,int sellerId) {
		SellerGoods sellerGoods = new SellerGoods();
		sellerGoods.setPrice(price);
		sellerGoods.setAmount(amount);
		sellerGoods.setGoodsId(goodsId);
		sellerGoods.setSellerId(sellerId);
		Integer sg = sellerGoodsService.addGoods(sellerGoods);
		return sg;
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public Integer delGoods(Integer id) {
		Integer sg = sellerGoodsService.delGoods(id);
		return sg;
	}
	
	@RequestMapping("/toUpdate")
	@ResponseBody
	public ModelAndView toUpdate(Integer id) {
		SellerGoods sellerGoods = sellerGoodsService.toUpdate(id);
		ModelAndView mav = new ModelAndView();
		mav.addObject("sellerGoods", sellerGoods);
		mav.setViewName("/sellergoods/edit");
		return mav;
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public void update(SellerGoods sellerGoods) {
		sellerGoodsService.update(sellerGoods);
	}
	
	@RequestMapping("/view")
	public ModelAndView view(@RequestParam(value="pageNum", defaultValue="1")Integer pageNum,int sellerId,String name,Integer price1,Integer price2) {
		PageHelper.startPage(pageNum,4);
		Map<String, Object> param=new HashMap<String, Object>();
		param.put("sellerId", sellerId);
		param.put("name", name);
		param.put("price1", price1);
		param.put("price2", price2);
		List<SellerGoods> goods = sellerGoodsService.goodView(param);
		PageInfo page = new PageInfo(goods,5);
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageInfo", page);
		mav.addObject("sellerId", sellerId);
		mav.addObject("name", name);
		mav.addObject("price1", price1);
		mav.addObject("price2", price2);
		mav.setViewName("supplier/goodslist");
		return mav;
	}
}
