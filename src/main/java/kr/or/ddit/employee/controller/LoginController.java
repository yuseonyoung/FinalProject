package kr.or.ddit.employee.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 이수정
 * @since 2023. 11. 14.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 14.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Slf4j
@Controller
public class LoginController {

	@Inject
	private EmpService service;

	/**
	 * 로그인, 실패 시 에러 처리
	 * 
	 * @param error
	 * @param exception
	 * @param model
	 * @return
	 */
	@RequestMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception, Model model) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		return "/login/login/login";
	}

	/**
	 * 패스워드 찾기
	 * 
	 * @param emp
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findpw", method = RequestMethod.POST)
	@ResponseBody
	public String findPwPOST(@ModelAttribute EmpVO emp, HttpServletResponse response) throws Exception {
		String empCd = emp.getEmpCd();
		service.retrieveEmp(empCd);
		String result = service.findPw(emp);
		return result;
	}

}
