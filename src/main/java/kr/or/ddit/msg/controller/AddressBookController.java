package kr.or.ddit.msg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 김종명
 *
 */
@Slf4j
@RequestMapping("/address")
@Controller
public class AddressBookController {
	
	/**
	 * 주소록 팝업
	 * @return /address/popup/book
	 */
	@PostMapping("/book/popup")
	public String book() {
		return "/address/popup/book";
	}
	
	/**
	 * 주소록 관리 페이지
	 * @return address/manage
	 */
	@GetMapping("/manage")
	public String manage() {
		return "address/manage";
	}
	
	
}
