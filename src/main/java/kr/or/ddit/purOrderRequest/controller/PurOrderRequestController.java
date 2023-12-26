package kr.or.ddit.purOrderRequest.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.grouphint.InsertGroup;
import kr.or.ddit.purOrderRequest.service.PurOrderRequestService;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author 유선영
 * @since 2023. 11. 27.
 * @version 1.0
 * 
 *         
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.    유선영      최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          
 */

@Slf4j
@Controller
@RequestMapping("/pur")
public class PurOrderRequestController {
	@Inject
	private PurOrderRequestService purOrderReService;
	
	@GetMapping("/list")
	public String purOrderRequestList() {
		return "purorder/purOrderList";
	}
	
	@GetMapping("/form")
	public String purOrderRequestForm() {
		return "purorder/purOrderForm";
	}
	
	@GetMapping("/cond")
	public String purOrderRequestCond() {
		return "purorder/purOrderPreCond";
	}
	
	
	@GetMapping
	public String retrievePurOrder(Model model) {
		List<Map<String, Object>> purOrderList = purOrderReService.retrievePurOrderList();
		model.addAttribute("purOrderList", purOrderList);
		
		return "jsonView";
	}
	
	// 발주요청 코드로 상세 정보 조회
	@GetMapping("/{preqCd}")
	public String retievePurOrderDetail(Model model,@PathVariable String preqCd) {
		try{
			List<Map<String, Object>> purOrderDetailList = purOrderReService.retrievePurOrder(preqCd);		
			model.addAttribute("purOrderDetailList",purOrderDetailList);
		}catch(RuntimeException e) {
			String message = e.getMessage();
			model.addAttribute("message",message);
		}
		
		return "jsonView";
	}
	
	// 발주요청 등
	@PostMapping("/create")
	public String createPurOrderDetail(@Validated(InsertGroup.class) @RequestBody PurOrderRequestVO purOrderVO, Errors errors, Model model) {
		Map<String, String> totalMap = new HashMap<>();
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@{}",purOrderVO);
		
		purOrderVO.setPreqStat("T001");
		
		if (!errors.hasErrors()) {
			ServiceResult purOrderResult =null;
			if(purOrderVO.getReqItem().size()==0||purOrderVO.getReqItem()==null) {
				totalMap.put("itemNull","품목을 등록해 주어야 합니다.");
			}else {
				purOrderResult = purOrderReService.createPurOrdReq(purOrderVO,purOrderVO.getReqItem());
			}
			
			if (purOrderResult == ServiceResult.OK) {
				totalMap.put("rslt", "success");
			} else {
				model.addAttribute("message", "서버 오류입니다. 다시 입력해 주세요");
				totalMap.put("rslt", "fail");
			}
		}else {
			// 유효성 검사 실패 시
			totalMap.put("rslt", "fail");
			if(purOrderVO.getReqItem().size()==0||purOrderVO.getReqItem()==null) {
				totalMap.put("itemNull","품목을 등록해 주어야 합니다.");
			}
			List<ObjectError> errorList = errors.getAllErrors();
			log.info("ddddd@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@{}",errorList);
			for (ObjectError error : errorList) {
				if (error instanceof FieldError) {
					FieldError fieldError = (FieldError) error;
					String fieldName = fieldError.getField();
					String errorMessage = error.getDefaultMessage();
					totalMap.put(fieldName, errorMessage);
				} else {
					totalMap.put("error", error.getDefaultMessage());
				}
			}
		}
		totalMap.put("deptNm",purOrderVO.getDeptNm());
		model.addAttribute("totalValue", totalMap);
		
		return "jsonView";
	}
		
	// 발주요청 수정
	@PostMapping("/update")
	public String modifyPurOrderDetail(@Valid @RequestBody PurOrderRequestVO purOrderVO, Errors errors, Model model) {
		Map<String, String> totalMap = new HashMap<>();
		log.info("이건너ㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓ:{}",purOrderVO);
		
		if (!errors.hasErrors()) {
			ServiceResult purOrderResult=null;
			if(StringUtils.isEmpty(purOrderVO.getPreqDate())) {
				totalMap.put("dateNull","일자를 등록해야 합니다.");
			}else{
				purOrderResult = purOrderReService.modifyPurOrdReq(purOrderVO,purOrderVO.getReqItem());
			}
			
			if (purOrderResult == ServiceResult.OK) {
				totalMap.put("rslt", "success");
			} else {
				model.addAttribute("message", "서버 오류입니다. 다시 입력해 주세요");
				totalMap.put("rslt", "fail");
			}
		}else {
			// 유효성 검사 실패 시
			totalMap.put("rslt", "fail");
			if(StringUtils.isEmpty(purOrderVO.getPreqDate())) {
				totalMap.put("dateNull","일자를 등록해야 합니다.");
			}
			List<ObjectError> errorList = errors.getAllErrors();
			log.info("ddddd@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@{}",errorList);
			for (ObjectError error : errorList) {
				if (error instanceof FieldError) {
					FieldError fieldError = (FieldError) error;
					String fieldName = fieldError.getField();
					String errorMessage = error.getDefaultMessage();
					totalMap.put(fieldName, errorMessage);
				} else {
					// 일반적인 오류 처리
					totalMap.put("error", error.getDefaultMessage());
				}
			}
		}
		model.addAttribute("totalValue", totalMap);
		
		return "jsonView";
	}
	
	// 발주요청 삭제
	@PostMapping("/remove")
	public String removePurOrder(@Valid @RequestBody String preqCd, Errors errors, Model model) {
		Map<String, String> totalMap = new HashMap<>();
		
		if (!errors.hasErrors()) {
			ServiceResult result = purOrderReService.removePurOrdReq(preqCd);
			
			if (result == ServiceResult.OK) {
				totalMap.put("rslt", "success");
			} else {
				model.addAttribute("message", "서버 오류입니다. 다시 입력해 주세요");
				totalMap.put("rslt", "fail");
			}
		} else {
			// 유효성 검사 실패 시
			totalMap.put("rslt", "fail");
			List<ObjectError> errorList = errors.getAllErrors();
			for (ObjectError error : errorList) {
				if (error instanceof FieldError) {
					FieldError fieldError = (FieldError) error;
					String fieldName = fieldError.getField();
					String errorMessage = error.getDefaultMessage();
					totalMap.put(fieldName, errorMessage);
				} else {
					// 일반적인 오류 처리
					totalMap.put("error", error.getDefaultMessage());
				}
			}
		}
		model.addAttribute("totalValue", totalMap);
		
		return "jsonView";
	}
	
	@PostMapping("/retrieve")
	public String retrievePurOrderWhereList(@RequestBody Map<String, Object> purOrderParam, Model model) {
		log.info("#################################{}",purOrderParam);
		List<Map<String, Object>> purOrderList = purOrderReService.retrieveWherePurOrderList(purOrderParam);
		model.addAttribute("purOrderList", purOrderList);
		
		return "jsonView";
	}
}
