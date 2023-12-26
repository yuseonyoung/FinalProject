package kr.or.ddit.storage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.item.dao.ItemDAO;
import kr.or.ddit.item.service.ItemService;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.dao.InventoryReceiptPaymentDAO;
import kr.or.ddit.storage.service.InventoryReceiptPaymentService;
import kr.or.ddit.storage.service.StorageService;
import kr.or.ddit.storage.vo.StorageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/invenSituation")
public class InventoryReceiptPaymentController {
	
	@Inject
	private InventoryReceiptPaymentService invenService;
	@Inject
	private ItemService itemService;
	@Inject
	private StorageService service;
	
	@Inject
	InventoryReceiptPaymentDAO irpDao;
	
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
	
	@GetMapping
	public String invenReceiptPaymentView(Model model) {
		List<StorageVO> wareList =  service.retrieveStorageList();
		log.info("invenReceiptPaymentView->wareList : " + wareList);
		model.addAttribute("wareList", wareList);				
		return "inventory/invenReceiptPayment";
	}
	
	@PostMapping
	public String invenReceiptPayment(Model model, @RequestBody  Map<String, Object> searchMap){
		
		String inputSData = (String)searchMap.get("rmstSdate");
		String inputLData = (String)searchMap.get("rmstLdate");
		
		String outputSDate="";
		String outputLDate="";
		
		
		if (StringUtils.isNotBlank(inputSData) && StringUtils.isNotBlank(inputLData)) {
			//-에서 /로 변환
			outputSDate = inputSData.replace("-", "/");
			outputLDate = inputLData.replace("-", "/");
			
			searchMap.put("rmstSdate", outputSDate);
			searchMap.put("rmstLdate", outputLDate);
		}
		
		// 새로운 map에 원하는 데이터[itemCd, rmstSdate,rmstLdate,storCate]만 넣어서 보내는 작업
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("rmstSdate", outputSDate);
		dataMap.put("rmstLdate", outputLDate);
		
		List<ItemVO> invenList = invenService.retrieveInventoryList(searchMap);
		
		model.addAttribute("invenList",invenList);
		//속도가 느림
		log.info("값좀보자꾸나 : {}",invenList);
		return "jsonView";
	}
}
