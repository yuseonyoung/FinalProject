package kr.or.ddit.attend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <pre>
 * 
 * </pre>
 * @author 우정범
 * @since 2023. 11. 7.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 7.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Controller
@RequestMapping("/attend")
public class AttendController {
	
	@RequestMapping("/list")
	public String attendList() {
		return "attend/attend";
		
	}

}
