package kr.or.ddit.storage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reqItem")
public class ReqItemController {
	
	@GetMapping
	public String ReqItemRetrieve() {
		return "requestItem/requestItemList";
	}
}
