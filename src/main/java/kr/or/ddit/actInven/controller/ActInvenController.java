package kr.or.ddit.actInven.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.actInven.service.ActInvenService;
import kr.or.ddit.actInven.vo.ActInvenVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.defect.vo.DefectVO;
import kr.or.ddit.mail.vo.AttatchVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 최광식
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Slf4j
@Controller
@RequestMapping("/actInven")
public class ActInvenController {
	
	@Inject
	ActInvenService service;
	
	@ModelAttribute("actInvenVO")
	public ActInvenVO actInvenVO() {
		ActInvenVO actInvenVO = new ActInvenVO();
		return actInvenVO;
	}
	
	@GetMapping("/list")
	public String actualInventoryList() {
		return "actInven/actInvenList";
	}
	
	@GetMapping("/listView")
	public String actualInventoryListView(
			@ModelAttribute("detailCondition") ActInvenVO detailCondition
			,@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			,Model model){
		
		PaginationInfo<ActInvenVO> paging = new PaginationInfo<ActInvenVO>(10,5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		
		service.retrieveActInvenList(paging);
		
		paging.setRenderer(new BootstrapPaginationRenderer());
		
		model.addAttribute("paging",paging);
		log.info("@@@@@paging: ", paging);
		/*
		 * List<ActInvenVO> actInvenList = service.retrieveActInvenList();
		 * model.addAttribute("actInvenList", actInvenList);
		 */
		return "jsonView";
	}
	
	@GetMapping("/view")
	public String actInvenView(@RequestParam("what") String realCd, Model model) {
		ActInvenVO actInvenView = service.retrieveActInven(realCd);
		
		model.addAttribute("actInvenView",actInvenView);
		
		return "jsonView";
	}
	
	@GetMapping("/form")	// post / put 으로 바꿀것
	public String insertActInven() {
		return "actInven/actInvenForm";
	}
	
	@PutMapping	
	public String updateActInven(@Valid @RequestBody ActInvenVO actInvenVO
			,Errors errors
			,Model model) {
		System.out.println("@@@@@List<ActInvenVO> 넘어오냐@##@@"+actInvenVO);
		boolean valid = !errors.hasErrors();
		
		Map<String, String> errorMap = new HashMap<>();
		List<ObjectError> errorList = errors.getAllErrors();
		
		if(valid) {
			ServiceResult result = service.modifyActInven(actInvenVO);
			switch (result) {
			case OK:	
				errorMap.put("rslt","success");
				break;
			default:
				model.addAttribute("message","서버오류입니다. 잠시후 다시 시도해주세요.");
				errorMap.put("rslt","fail");
				break;
			}
		}else {
			errorMap.put("rslt","fail");
			
			for(ObjectError error : errorList) {
				FieldError fieldError = (FieldError) error;
				String fieldName = fieldError.getField();
				String errorMessage = error.getDefaultMessage();
				
				errorMap.put(fieldName, errorMessage);
			}
		}
		model.addAttribute("errors",errorMap);
		
		return "jsonView";
	}
	
	@PostMapping
	public String insertActInven(@Valid @RequestBody ActInvenVO actInvenVO
			, Errors errors
			, Model model) {
		System.out.println("@@@@@insert actInvenVO 넘어오니@@@@@@@"+actInvenVO);
		boolean valid = !errors.hasErrors();
		
		Map<String, String> errorMap = new HashMap<String, String>();
		List<ObjectError> errorList = errors.getAllErrors();
		
		if(valid) {
			ServiceResult result = service.insertActInven(actInvenVO);
			switch (result) {
			case OK:
				errorMap.put("rslt","success");
				break;
			default:
				model.addAttribute("message","서버오류입니다. 잠시후 다시 시도해주세요.");
				errorMap.put("rslt","fail");
				break;
			}
		}else {
			errorMap.put("rslt","fail");
			
			for(ObjectError error : errorList) {
				FieldError fieldError = (FieldError)error;
				String fieldName = fieldError.getField();
				String errorMessage = error.getDefaultMessage();
				
				errorMap.put(fieldName, errorMessage);
			}
		}
		model.addAttribute("errors",errorMap);
		
		return "jsonView";
	}
	
	

}