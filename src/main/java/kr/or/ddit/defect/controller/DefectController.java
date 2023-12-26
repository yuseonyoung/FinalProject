package kr.or.ddit.defect.controller;

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

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.defect.service.DefectService;
import kr.or.ddit.defect.vo.DefectVO;
import kr.or.ddit.item.service.ItemService;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.util.commcode.dao.CommcodeDAO;
import kr.or.ddit.util.commcode.vo.CommcodeVO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * 
 * </pre>
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
@RequestMapping("/defect")
public class DefectController {
	
	@Inject
	private DefectService service;
	
	@Inject
	private ItemService itemService;
	
	@Inject 
	private CommcodeDAO commDao;
	
	@ModelAttribute("defectVO")
	public DefectVO defectVO (){
		DefectVO defectVO = new DefectVO();
		return defectVO;
	}
	
	@GetMapping("/list")
	public String defectList(){
		return "defect/defectList";
	}
	
	@GetMapping("/listView")
	public String defectListJson(
			@ModelAttribute("detailCondition") DefectVO detailCondition
			,@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			,Model model) {
		
		log.info("@@@@@@@detail",detailCondition);
		PaginationInfo<DefectVO> paging = new PaginationInfo<>(10,5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		
		service.retrieveDefecList(paging);
		
		paging.setRenderer(new BootstrapPaginationRenderer());
		
		model.addAttribute("paging", paging);
		log.info("@@@@@@@@paging",paging);
//		log.info("@@@@@@@@?????타입",paging.getDetailCondition().getSearch().getSearchType());
//		log.info("@@@@@@@@?????워드",paging.getDetailCondition().getSearch().getSearchWord());
		
		return "jsonView";
	}
	
	@GetMapping("/view")
	public String defectView(@RequestParam("what") String procCd ,Model model) {
		DefectVO defectView = service.retrieveDefect(procCd);
		List<CommcodeVO> defectTypeList = commDao.defectTypeGroupList();
		
		String itemCd = defectView.getItemCd();
		ItemVO itemView = itemService.retrieveItemDetail(itemCd);
		
		model.addAttribute("defectView",defectView);
		model.addAttribute("defectTypeList",defectTypeList);
		model.addAttribute("itemView",itemView);
		return "jsonView";
	}

	@GetMapping("/type")
	public String defectType(Model model) {
		List<CommcodeVO> defectList = commDao.defectGroupList();
		
		model.addAttribute("defectList",defectList);
		
		return "jsonView";
	}
	
	@GetMapping("/form")	// post / put 으로 바꿀것
	public String defectForm(Model model) {
		List<CommcodeVO> comm = commDao.defectGroupList();
		List<CommcodeVO> defectTypeList = commDao.defectTypeGroupList();
		model.addAttribute("defectTypeList",comm);
		model.addAttribute("defectTypeList",defectTypeList);
		return "defect/defectForm";
	}
	
	@PostMapping
	public String insertForm(@Valid @RequestBody DefectVO defectVO
			,Errors errors 
			,Model model) {
		List<CommcodeVO> defectTypeList = commDao.defectTypeGroupList();
		model.addAttribute("defectTypeList",defectTypeList);		
		boolean valid = !errors.hasErrors();
		
		Map<String, String> errorMap = new HashMap<>();
		List<ObjectError> errorList = errors.getAllErrors();
		System.out.println("@@@@@@@@@@@@@@@@@찍어@@@@@@@@@@"+valid);
		System.out.println("@@@@@@@@@@@@@@@@에러@@@@@@"+errors);
		if(valid) {
			ServiceResult result = service.createDefect(defectVO);
			switch (result) {
			case OK:
				errorMap.put("rslt", "success");
				break;
			default:
				model.addAttribute("message","서버오류입니다. 잠시후 다시 시도해주세요.");
				errorMap.put("rslt", "fail");
				break;
			}
		}else {
			errorMap.put("rslt", "fail");
			
			for (ObjectError error : errorList) {
                FieldError fieldError = (FieldError) error;
                String fieldName = fieldError.getField();
                String errorMessage = error.getDefaultMessage();

                errorMap.put(fieldName, errorMessage);	            
	      }
				
		}
		System.out.println("@@@@@@@@나오냐@@@@@@@@"+defectVO);
		
		 model.addAttribute("errors", errorMap);
		 return "jsonView";
	}
	
	@PutMapping
	public String updatedefect(@Valid @RequestBody DefectVO defectVO
			, Errors errors
			, Model model) {
		System.out.println("@@@@@@@@@@@@@@@@@@@수정 확인@@@@@@@@@@@@"+defectVO);
		boolean valid = !errors.hasErrors();
		
		Map<String, String> errorMap = new HashMap<>();
		List<ObjectError> errorList = errors.getAllErrors();
		
		if(valid) {
			ServiceResult result = service.modifyDefect(defectVO);
			switch (result) {
			case OK:
				errorMap.put("rslt", "success");
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
	
	@GetMapping("/crntSttn")
	public String defectCrntSttn() {
		return "defect/defectCrntSttn";
	}

}
