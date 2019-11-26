package com.qrhf.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qrhf.pojo.Region;
import com.qrhf.service.RegionService;
import com.qrhf.vo.RegionVO;

@Controller
@RequestMapping("/region")
public class RegionController {
	@Autowired
	private RegionService regionService;
	
	@RequestMapping("selectRegion")
	public @ResponseBody List<RegionVO> getRegion(HttpServletRequest request){
		String pid =request.getParameter("pid");
		List<Region> list=regionService.getRegion(pid);
		List<RegionVO> toList=new ArrayList<RegionVO>();
		if(list !=null) {
			for(Region re :list) {
				RegionVO reg=new RegionVO();
				reg.setId(re.getId());
				reg.setName(re.getName());
				reg.setPid(re.getPid());
 				toList.add(reg);
			}
		}
		return toList;
	}
}
