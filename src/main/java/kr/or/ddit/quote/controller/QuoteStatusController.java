package kr.or.ddit.quote.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 김도현
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      김도현       최초작성
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Controller
@RequestMapping("/quote")
public class QuoteStatusController {
	
	@GetMapping("/status")
	public String statusQuoteList() {
		return "quote/quoteStatus";
	}
}
