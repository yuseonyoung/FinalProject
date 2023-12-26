package kr.or.ddit.storage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.storage.service.StorageInOutService;
import kr.or.ddit.storage.vo.InventoryReceiptPaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/storInOut")
public class StorageInOutController {
	@Inject
	public StorageInOutService inOutService;
	
	@GetMapping("outView")
	public String storageOutViewRetrieve() {
		return "storageInOut/storageInOutList";
	}
	
	@GetMapping("out")
	public String storageOutInsertRetrieve(Model model) {
		
		List<Map<String, Object>> inOutList = inOutService.retrieveShippingProcessForm();

		model.addAttribute("inOutList",inOutList);
		
		return "jsonView";
	}
	
	@ResponseBody
	@PostMapping("/out")
	public String storageOutInsert(Model model, @RequestBody List<Map<String, Object>> outMap) {
		
		//넘어온값중 null이나 공백을 가지고 있는 데이터를 제외시키기 위해 새로운 List를 만들어 깊은복사를 함.
		List<Map<String, Object>> copyInOutList = new ArrayList<>();

	    for (Map<String, Object> map : outMap) {
	        // 각 map에서 'inQty' 키의 값을 확인하여 빈 값이거나 null인 경우에는 리스트 추가에서 제외 
	        if (map.containsKey("inQty") && (map.get("inQty") == null || map.get("inQty").toString().isEmpty())) {
	        	// 'inQty'가 빈 값이거나 null이면 다음 map으로 넘어감
	        	continue; 
	        }
	        // 'inQty'가 비어있지 않으면 새 리스트에 추가
	        copyInOutList.add(new HashMap<>(map)); 
	    }
		
		ServiceResult result =  inOutService.createStorageOut(copyInOutList);
		String viewName="";
		switch(result) {
		case OK:
			viewName = "ok";
			break;
		default:
			viewName = "fail";
		}
		return viewName;
	}
	
	@GetMapping("/inView")
	public String storageInViewRetreive(Model model) {
		
		return "storageInOut/storageInFormList";
	}
	
	@GetMapping("/in")
	public String storageInFormRetreive(Model model) {
		List<Map<String, Object>> inList = inOutService.retrievePurOrderConfirmed();

		model.addAttribute("inList",inList);
		
		return "jsonView";
	}
	
	@ResponseBody
	@PostMapping("/in")
	public String storageInFormRetreive(Model model, @RequestBody List<InventoryReceiptPaymentVO> inMap) {
		log.info("inMap{}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",inMap);
		List<InventoryReceiptPaymentVO> copyVoList = new ArrayList<InventoryReceiptPaymentVO>();
		for (InventoryReceiptPaymentVO vo : inMap) {
			// 각 map에서 'inQty' 키의 값을 확인하여 빈 값이거나 null인 경우에는 리스트 추가에서 제외 
			InventoryReceiptPaymentVO copyVo = new InventoryReceiptPaymentVO();
			if (
		    	vo.getItemCd() != null &&
		        !vo.getWareCd().equals("undefined") &&
		        vo.getRmstQty() > 0 &&
		        !vo.getSecCd2().equals("undefined")) {
		    	
		        copyVo.setRmstQty(vo.getRmstQty());
		        copyVo.setItemCd(vo.getItemCd());
		        copyVo.setWareCd(vo.getWareCd());
		        copyVo.setSecCd2(vo.getSecCd2());
		        copyVo.setRmstNote(vo.getRmstNote());
		        copyVo.setPordCd(vo.getPordCd());
		        copyVoList.add(copyVo);
				copyVo.setStorCate("B001");
				copyVo.setStorRsn("C001");
		    }
		}

		
		ServiceResult result =  inOutService.createStorageIn(copyVoList);
		String viewName="";
		switch(result) {
		case OK:
			viewName = "ok";
			break;
		default:
			viewName = "fail";
		}
		return viewName;
	}
	
	@PostMapping("/move")
	public String moveWare(Model model, @RequestBody List<InventoryReceiptPaymentVO> inMap) {
		Map<String, String> totalMap = new HashMap<>();
		
		log.info("inMap{}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",inMap);
		
		ServiceResult result =  inOutService.createStorageInOut(inMap);
		String viewName="";
		switch(result) {
		case OK:
			totalMap.put("rslt", "success");
			break;
		default:
			totalMap.put("rslt", "fail");
		}
		model.addAttribute("totalValue", totalMap);
		return "jsonView";
	}
}
