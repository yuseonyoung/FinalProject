package kr.or.ddit.scheduledStock.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.scheduledStock.service.ScheduledStackService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/scheduledStock")
public class ScheduledStackController {
	
	@Inject
	private ScheduledStackService schduleService;
	/**
	 * 시작시 출고예정서 jsp와 연결
	 * 
	 * @return
	 */
	@GetMapping("/outView")
	public String outScheduledStackListView(){
		return "scheduledStack/outScheduledStackList";
	}
	
	/**
	 * 시작시 입고예정서 jsp와 연결
	 * 
	 * @return
	 */
	@GetMapping("/inView")
	public String inScheduledStackListView(){
		return "scheduledStack/inScheduledStackList";
	}
	
	
	/**
	 * 출고예정서 조회
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/out")
	public String outScheduledStackList(Model model){
		
		List<Map<String, Object>> schduledStockList =  schduleService.retrieveOutStocked();
		
		model.addAttribute("stockList",schduledStockList);
		
		return "jsonView";
	}
	
	
	/**
	 * 입고예정서 조회
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("/in")
	public String inScheduledStackList(Model model){
		
		List<Map<String, Object>> schduledInStockList =  schduleService.retrieveInStocked();
		
		model.addAttribute("schduledInStockList",schduledInStockList);
		
		return "jsonView";
	}
	
	/**
	 * 출하예정인 출하지시서 상세 조회
	 * 
	 * @param rdrecCd
	 * @param model
	 * @return
	 */
	@GetMapping("/out/{rdrecCd}")
	public String outScheduledStackDetail(@PathVariable String rdrecCd, Model model) {
		try{
			List<Map<String, Object>> stockDetail = schduleService.retrieveScheduledOutStockDetail(rdrecCd);			
			model.addAttribute("stockDetail",stockDetail);
		}catch(RuntimeException e) {
			String message = e.getMessage();
			model.addAttribute("message",message);
		}
		return "jsonView";
	}
	
	
	
	/**
	 * 입고예정인 발주서 상세조회
	 * 
	 * @param 
	 * @param model
	 * @return
	 */
	@GetMapping("/in/{pordCd}")
	public String inScheduledStackDetail(@PathVariable String pordCd, Model model) {
		log.info("d:@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@{}:",pordCd);
		try{
			List<Map<String, Object>> stockDetail = schduleService.retrieveScheduledInStockDetail(pordCd);			
			model.addAttribute("stockDetail",stockDetail);
		}catch(RuntimeException e) {
			String message = e.getMessage();
			model.addAttribute("message",message);
		}
		return "jsonView";
	}
}
