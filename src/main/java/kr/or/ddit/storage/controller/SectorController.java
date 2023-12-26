package kr.or.ddit.storage.controller;

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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.item.service.ItemService;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.service.SectorService;
import kr.or.ddit.storage.service.StorageService;
import kr.or.ddit.storage.vo.ItemWareVO;
import kr.or.ddit.storage.vo.StorageVO;
import kr.or.ddit.storage.vo.WareSecVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/sector")
public class SectorController {
	@Inject
	private StorageService storService;

	@Inject
	private SectorService sectorService;

	@Inject
	private ItemService itemService;

	@GetMapping("/view")
	public String sectorRetrieveView(Model model) {
		List<HashMap<String, Object>> totalWareList = storService.retrieveStorageSecList();
		model.addAttribute("totalWareList", totalWareList);
		return "sector/sectorList";
	}
	
	
	//-------------------------------페이징중-------------------------------
	@GetMapping("/list")
	public String invenReceiptPaymentList(@ModelAttribute("detailCondition") ItemVO detailCondition
			,@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage
			,Model model) {
		PaginationInfo<ItemVO> paging = new PaginationInfo<>(10,5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		
		itemService.retrieveItemList(paging);
		
		paging.setRenderer(new BootstrapPaginationRenderer());
		model.addAttribute("paging", paging);			
		
		return "jsonView";
	}
	

	@GetMapping("/item")
	public String storageCreateItem(Model model) {
		List<HashMap<String, Object>> totalWareList = storService.retrieveStorageSecList();
		model.addAttribute("totalWareList", totalWareList);

		return "sector/sectorView";
	}

	@GetMapping("/{selectedWareCd}")
	public String sectorRetrieve(@PathVariable String selectedWareCd, Model model) {
		List<StorageVO> wareList = storService.retrieveStorageSectorList(selectedWareCd);
		model.addAttribute("wareList", wareList);
		log.info("SectorController나야야야{}",wareList);
		return "jsonView";
	}

	@GetMapping("/form")
	public String sectorForm(Model model) {
		List<HashMap<String, Object>> wareSecList = storService.retrieveStorageSecList();
		model.addAttribute("wareSecList", wareSecList);

		return "sector/sectorForm";
	}

	// 창고의 한 섹터 아이템 조회
	@PostMapping("/itemList")
	public String sectorItemRetrieve(@RequestBody WareSecVO wareSecVO, Model model) {
		List<WareSecVO> sectorList = sectorService.retrieveSelectSectorItem(wareSecVO);
		model.addAttribute("secList", sectorList);
		return "jsonView";
	}

	// 창고의 모든 섹터 아이템 조회
	@PostMapping("/itemsList")
	public String sectorItemsRetrieve(@RequestBody WareSecVO wareSecVO, Model model) {
		List<WareSecVO> sectorList = sectorService.retrieveSelectSectorItems(wareSecVO);
		model.addAttribute("secList", sectorList);
		return "jsonView";
	}

	@PostMapping
	public String sectorCreate(@Valid @RequestBody List<WareSecVO> wareSecList, Errors errors, Model model) {
		Map<String, String> totalMap = new HashMap<>();

		if (!errors.hasErrors()) {
			// 유효성 검사 통과 시
			ServiceResult result = sectorService.createOrModifySector(wareSecList);

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

	@PostMapping("/item")
	public String itemWareCreate(@Valid @RequestBody List<ItemWareVO> itemWareList, Errors errors, Model model) {
		Map<String, String> totalMap = new HashMap<>();

		if (!errors.hasErrors()) {
			ServiceResult result = sectorService.CreateMergeItemWare(itemWareList);

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
	
	@DeleteMapping("/remove")
	public String removeWareSector(@Valid @RequestBody WareSecVO wareSecVO, Errors errors, Model model) {
		Map<String, String> totalMap = new HashMap<>();

		if (!errors.hasErrors()) {
			ServiceResult result = sectorService.removeWareSector(wareSecVO);
			
			if (result == ServiceResult.OK) {
				totalMap.put("rslt", "success");
			}else if(result == ServiceResult.NOTEXIST) {
				totalMap.put("rslt","NotExist");
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
}
