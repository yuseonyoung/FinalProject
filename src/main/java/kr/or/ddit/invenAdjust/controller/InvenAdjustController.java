package kr.or.ddit.invenAdjust.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.actInven.vo.ActInvenVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.invenAdjust.service.InvenAdjustService;
import kr.or.ddit.invenAdjust.vo.InvenAdjustVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.vo.ItemWareVO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 최광식
 * @since 2023. 11. 8.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      최광식       최초작성
 * 2023. 11. 27.     최광식       리스트 출력
 * 2023. 11. 30.     최광식       itemInvenCheck 추가
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */
@Slf4j
@Controller
@RequestMapping("/invenAdjust")
public class InvenAdjustController {

	@GetMapping("/list")
	public String invenAdjustList() {
		return "invenAdjust/invenAdjustList";
	}

	@Inject
	private InvenAdjustService service;

	@GetMapping("/listView")
	public String invenAdjustListView(@ModelAttribute("detailCondition") ActInvenVO detailCondition, Model model) {

		log.info("@@@Controller.detailCondition@@@ : {}", detailCondition);
		PaginationInfo<ActInvenVO> paging = new PaginationInfo<ActInvenVO>();
		paging.setDetailCondition(detailCondition);

		service.retrieveInvenAdjustList(paging);

		log.info("@@@Controller.paging@@@ : {}", paging);

		model.addAttribute("paging", paging);

		return "jsonView";

	}

	@PostMapping("/insertInven")
	public String insertInvenAdjust(@RequestBody ActInvenVO actInvenVO, Errors errors, Model model) {

		log.info("@@@@@@@@나오냐@@@@@@@@ : {}",actInvenVO);
		boolean valid = !errors.hasErrors();

		Map<String, String> errorMap = new HashMap<>();
		List<ObjectError> errorList = errors.getAllErrors();

		System.out.println("@@@@@@@@@@@@@@@@@찍어@@@@@@@@@@" + valid);
		System.out.println("@@@@@@@@@@@@@@@@에러@@@@@@" + errors);

		if (valid) {
			ServiceResult result = service.createIndenAdjust(actInvenVO);
			switch (result) {
			case OK:
				errorMap.put("rslt", "success");
				break;
			default:
				model.addAttribute("message", "서버오류입니다. 잠시후 다시 시도해주세요.");
				errorMap.put("rslt", "fail");
				break;
			}
		} else {
			errorMap.put("rslt", "fail");

			for (ObjectError error : errorList) {
				FieldError fieldError = (FieldError) error;
				String fieldName = fieldError.getField();
				String errorMessage = error.getDefaultMessage();

				errorMap.put(fieldName, errorMessage);
			}
		}
	
		
		 model.addAttribute("errors", errorMap);
		 return "jsonView";
	}
	
	
	
	//재고 조회 메뉴
	
	@GetMapping("/itemInvenCheck")
	public String retrieveItemInvenCheck() {
		return "invenAdjust/itemInvntCheck";
	}
	
	@GetMapping("/itemList")
	public String selectInvenItemAll(
			@ModelAttribute("detailCondition") ItemWareVO detailCondition
			,@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			,Model model
			) {
		log.info("@@@Controller.detailCondition@@@ : {}", detailCondition);
		PaginationInfo<ItemWareVO> paging = new PaginationInfo<ItemWareVO>(10,5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);

		service.retrieveInvenItemAll(paging);
		
		paging.setRenderer(new BootstrapPaginationRenderer());

		log.info("@@@Controller.paging@@@ : {}", paging);

		model.addAttribute("paging", paging);
		
		return "jsonView";
	}
	
	@PostMapping("/itemInvenView")
	public String itemDetial(@RequestBody ItemWareVO itemWareVO , Model model) {
		
		log.info("itemWareVO : " ,itemWareVO);
		ItemWareVO itemDetail = service.retrieveItemDetail(itemWareVO);
		
		model.addAttribute("itemDetail",itemDetail);
		log.info("itemDetail{}",itemDetail);
		
		return "jsonView";
	}

//	@GetMapping("/form") // post / put 으로 바꿀것
//	public String insertInvenAdjust() {
//		return "invenAdjust/invenAdjustForm";
//	}
//
//	@PutMapping("/form")				//확인해보자 이걸 여기서 하는게 맞는지 일단 수정은 상세조회에서 할 수 있게 해야함
//	public String updateInvenAdjust() {
//		return "invenAdjust/invenAdjustForm";
//	}

}
