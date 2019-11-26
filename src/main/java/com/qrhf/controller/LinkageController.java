package com.qrhf.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.Linkage;
import com.qrhf.service.LinkageService;
import com.qrhf.vo.LinkageVO;
@Controller
@RequestMapping("/linkage")
public class LinkageController {
	@Autowired
	private LinkageService linkageService; 
	
	@RequestMapping("selectLinkage")
	public @ResponseBody List<LinkageVO> getLikage(HttpServletRequest request){
		String pid=request.getParameter("pid");
		List<Linkage> list =linkageService.getLikage(pid);
		List<LinkageVO> toList = new ArrayList<LinkageVO>();
		if(list !=null) {
			for(Linkage lin :list) {
				LinkageVO link =new LinkageVO();
				link.setId(lin.getId());
				link.setPid(lin.getPid());
				link.setName(lin.getName());
				toList.add(link);
			}
		}
		return toList;
	}
	@RequestMapping("findByLinkage")
	public @ResponseBody Object findByLinkage() {
		List<Linkage> list=	linkageService.findByLikage();
		return list;
	}
}
