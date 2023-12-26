package kr.or.ddit;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;


/**
 * <pre>
 * 
 * </pre>
 * @author 우정범
 * @since 2023. 11. 4.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 4.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Slf4j
@Controller
public class HomeController {

	
	@GetMapping("/")
	public String home(Model model, Principal principal) throws Exception {
		log.info("mainTemplate");


		return "mainTemplate";
	}

}
