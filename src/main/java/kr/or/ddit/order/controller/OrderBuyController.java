package kr.or.ddit.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

//@Controller
@RequestMapping("/orderBuy")
public class OrderBuyController {
	
	@GetMapping
	public String buyRetrieve() {
		return "order/orderBuyList";
	}

}
