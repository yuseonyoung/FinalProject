package kr.or.ddit.item.controller;

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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.defect.vo.DefectVO;
import kr.or.ddit.grouphint.UpdateGroup;
import kr.or.ddit.item.service.ItemService;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.vo.StorageVO;
import kr.or.ddit.util.commcode.dao.CommcodeDAO;
import kr.or.ddit.util.commcode.vo.CommcodeVO;
import lombok.extern.slf4j.Slf4j;
/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Slf4j
@RequestMapping("/item")
@Controller
public class ItemController {
	@Inject
	private ItemService service;

	@Inject
	private CommcodeDAO commcodeDAO;

	@ModelAttribute("itemData")
	public ItemVO item() {
		ItemVO item = new ItemVO();
		return item;
	}

	@GetMapping("/view")
	public String itemRetrieveView(Model model) {
		List<CommcodeVO> commcodeList = commcodeDAO.itemGroupList();
		model.addAttribute("commcodeList", commcodeList);

		return "item/itemList";
	}

	@GetMapping
	public String itemRetrieveList(@ModelAttribute("detailCondition") ItemVO detailCondition
			,@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			,Model model) {
		log.info("@@@@@@@@@@@@@@@@@@@@2detailCondition:{}",detailCondition);
		PaginationInfo<ItemVO> paging = new PaginationInfo<>(10,5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		
		service.retrieveItemList(paging);
		
		model.addAttribute("paging", paging);
		return "jsonView";
	}

	@GetMapping("form/view")
	public String itemFormView() {
		return "item/itemForm";
	}

	@PostMapping
	public String createItem(@Valid @RequestBody ItemVO itemVO, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		Map<String, String> errorMap = new HashMap<>();
		List<ObjectError> errorList = errors.getAllErrors();
		log.info("@@@@@@@@@@@@@@@@@@@@valid:{}",valid);
		if (valid) {
			ServiceResult duplicate_result = service.duplicateItemCode(itemVO.getItemCd());
			switch (duplicate_result) {
			case OK:
				ServiceResult insert_result = service.createItem(itemVO);
				switch (insert_result) {
				case OK:
					log.info("itemaskasd:@@{}",itemVO);
					model.addAttribute("itemVO", itemVO);
					errorMap.put("rslt", "success");
					break;
				default:
					model.addAttribute("message", "서버오류입니다. 다시 입력해 주세요");
					errorMap.put("rslt", "fail");
				}
				break;
			default:
				model.addAttribute("message", "코드 중복입니다. 다시 입력해 주세요");
				errorMap.put("rslt", "fail");
				errorMap.put("itemCd", "코드 중복입니다. 다시 입력해 주세요");
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

	@PutMapping
	public String updateItem(@Validated(UpdateGroup.class) @RequestBody ItemVO itemVO, Errors errors, Model model) {
		boolean valid = !errors.hasErrors();
		Map<String, String> errorMap = new HashMap<>();
		List<ObjectError> errorList = errors.getAllErrors();

		if (valid) {
			ServiceResult result = service.modifyItem(itemVO);
			switch (result) {
			case OK:
				model.addAttribute("itemVO", itemVO);
				errorMap.put("rslt", "success");
				break;
			default:
				model.addAttribute("message", "서버오류입니다. 다시 입력해 주세요");
				errorMap.put("rslt", "success");
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

	@ResponseBody
	@PutMapping("{itemCd}")
	public String unUseUpdateStorage(@PathVariable String itemCd) {
		ServiceResult result = service.modifyUnUseItem(itemCd);

		switch (result) {
		case OK:
			return "success";
		default:
			return "fail";
		}

	}
	
	@ResponseBody
	@PutMapping("/use/{itemCd}")
	public String useUpdateStorage(@PathVariable String itemCd) {
		ServiceResult result = service.modifyUseItem(itemCd);

		switch (result) {
		case OK:
			return "success";
		default:
			return "fail";
		}

	}
	
	public String itemRetrieveDetail(@RequestParam("what") String ItemCd ,Model model) {
		ItemVO itemVO = service.retrieveItemDetail(ItemCd);
		model.addAttribute(itemVO);
		return "jsonView";
	}
	
	@PostMapping("/datatable")
	public String retrieveItemListDataTable(@RequestBody StorageVO storageVO, Model model) {
		log.info("storageVO {}",storageVO);
		List<ItemVO> itemList = service.retrieveItemListDataTable(storageVO);
		model.addAttribute("itemList",itemList);
		
		return "jsonView";
	}
	
}
