package kr.or.ddit.empInfo.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.empInfo.service.EmpInfoService;

@RequestMapping("/empChart")
@Controller
public class EmpChartController {
	
	@Inject
	EmpInfoService empInfoService;
	
	
	@RequestMapping("/empInfo")
	public String empChart(){
		
		
		return "empInfo/empChart";
	}

}
