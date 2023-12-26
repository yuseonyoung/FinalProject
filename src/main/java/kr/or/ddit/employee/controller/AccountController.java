package kr.or.ddit.employee.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/*import jdk.internal.org.jline.utils.Log;*/
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.employee.dao.OthersDAO;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.employee.vo.OthersVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.paging.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 이수정
 * @since 2023. 11. 13.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 13.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Slf4j
@Controller
@RequestMapping("/account")
public class AccountController {

	@Inject
	private EmpService service;

	@GetMapping
	public String accountListRetrieve() throws Exception {
		return "account/account";
	}

	/**
	 * 계정 전체 목록 조회
	 * 
	 * @param simpleCondition
	 * @param currentPage
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/list")
	public String accountListRetrieve(@ModelAttribute("simpleCondition") SearchVO simpleCondition,
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage, Model model)
			throws Exception {

		// 페이징 처리 : 목록 10개, 페이지 번호 3개
		PaginationInfo<EmpVO> paging = new PaginationInfo<>(10, 3);

		// 키워드 검색 조건
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		service.retrieveEmpList(paging);
		paging.setRenderer(new BootstrapPaginationRenderer());
		model.addAttribute("paging", paging);
		List<EmpVO> empList = service.retrieveEmpList(paging);
		model.addAttribute("empList", empList);
		return "account/account";
	}

	/**
	 * 계정 신규 등록
	 * 
	 * @param emp
	 * @param model
	 * @param ra
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/form")
	public String accountCreate(EmpVO emp, Model model, RedirectAttributes ra) throws Exception {
		ServiceResult result = service.createEmp(emp);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "신규 사원이 등록 처리되었습니다.");
		} else {
			ra.addFlashAttribute("xmessage", "다시 시도해주세요.");
		}
		return "redirect:/account/list";
	}

	/**
	 * 계정 권한 수정 처리
	 * 
	 * @param emp
	 * @param model
	 * @param ra
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/edit")
	public String accountUpdate(EmpVO emp, Model model, RedirectAttributes ra) throws Exception {
		ServiceResult result = service.updateEmp(emp);
		if (result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "사원이 수정 처리되었습니다.");
		} else {
			ra.addFlashAttribute("xmessage", "다시 시도해주세요.");
		}
		return "redirect:/account/list";
	}

	/**
	 * 신규 등록 할 사원 목록
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/newEmpList", produces = "application/json;charset=utf-8")
	public ResponseEntity<List<EmpVO>> newEmpList() {
		List<EmpVO> empList = service.newEmpList();
		return new ResponseEntity<List<EmpVO>>(empList, HttpStatus.OK);
	}
}
