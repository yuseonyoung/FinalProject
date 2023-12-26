package kr.or.ddit.storage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("ioschedule")
public class InOutScheduleController {
	@GetMapping("/income")
	public String IncomeScheduleRetrieve(){
		return "ios/incomeScheduleList";
	}
	@GetMapping("/out")
	public String outScheduleRetrieve(){
		return "ios/outScheduleList";
	}
}
