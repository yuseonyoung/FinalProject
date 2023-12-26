package kr.or.ddit.order.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.order.service.OrderPlayService;
import kr.or.ddit.order.vo.ItemUprcVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.OrderBootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.paging.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/orderPlay")
public class OrderPlayController {
	private final OrderPlayService service;
	
	@GetMapping("/current")
	public String orderPlayCurrentRetrieve(Model model) {
		return "order/orderPlayCurrentList";
	}
	
	@GetMapping("/list")
	public String orderPlayRetrieve(Model model) {
		return "order/orderPlayList";
	}
	
	/*
	 * @GetMapping("/list2")
	 * 
	 * @ResponseBody public List<PurOrdVO> orderPlayRetrieve(){ List<PurOrdVO>
	 * orderPlayList = service.retrieveOrderPlay(); return orderPlayList; }
	 */
	
	@GetMapping("/list2")
	@ResponseBody
	public PaginationInfo<PurOrdVO> orderPlayRetrieve(
			Model model
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			){
		PaginationInfo<PurOrdVO> paging = new PaginationInfo<>(10,5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		service.retrieveOrderPlay(paging);
		
		paging.setRenderer(new OrderBootstrapPaginationRenderer());
		model.addAttribute("paging",paging);
		
		return paging;
	}
	
	//leftMenu 클릭시 들어가고 시작 ~
	@GetMapping("/enroll")
	public String orderPlayEnrollRetrieve(Model model) {
		return "order/orderPlayEnrollList";
	}
	
	//회사 List 뽑기
	@GetMapping("/dealCom")
	@ResponseBody
	public List<ItemUprcVO> dealComRetrieve(){
		List<ItemUprcVO> dealComList = service.retrieveDealCompany();
		return dealComList;
	}
	
	@GetMapping("/com")
	@ResponseBody
	public List<CompanyVO> comRetrieve(){
		List<CompanyVO> comList = service.retrieveCompany();
		return comList;
	}
	
	
	//사원 List 뽑기
	@GetMapping("/emp")
	@ResponseBody
	public List<EmpVO> responsibleEmpRetrieve(){
		List<EmpVO> responsibleEmpList = service.retrieveResponsibleEmp();
		return responsibleEmpList;
	}
	
	//품목 List 뽑기
	@GetMapping("/dealItem")
	@ResponseBody
	public List<ItemUprcVO> dealItemRetrieve(){
		List<ItemUprcVO> dealItemList = service.retrieveDealItem();
		return dealItemList;
	}
	
	//거래처가 선택된 상태에서 품목List 뽑기..
	@GetMapping("/dealItem/{comCd}")
	@ResponseBody
	public List<ItemUprcVO> dealItemRetrieve(@PathVariable String comCd){
		List<ItemUprcVO> dealItemSpecialList = service.retrieveDealItemSpecial(comCd);
		return dealItemSpecialList;
	}
	
	@PostMapping(value="/insertOrder", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String orderPlayCreate(@RequestBody List<Map<String, String>> rowData) {
		
		ServiceResult abc = service.createOrder(rowData);
		
		return abc.name();
	}
	
	@GetMapping("/view")
	@ResponseBody
	public List<PurOrdVO> orderPlayDetailRetrieve(@RequestParam("what") String pordCd){
		List<PurOrdVO> poDetailList = service.retrieveOrderPlayDetail(pordCd);
		
		return poDetailList;
	}
	
	@PostMapping("/current")
	public String orderPlayCurrnetRetrieve(@RequestBody Map<String, Object> orderPlayParam, Model model) {
		List<Map<String, Object>> orderPlayCurrentList = service.orderPlayCurrnetRetrieve(orderPlayParam);
		model.addAttribute("orderPlayCurrentList",orderPlayCurrentList);
		
		return "jsonView";
	}
	
	// 발주요청 코드로 상세 정보 조회
		@GetMapping("/{pordCd}")
		public String retievePurOrderDetail(Model model,@PathVariable String pordCd) {
			try{
				List<Map<String, Object>> orderPlayDetailList = service.orderPlayDetailRetrieve(pordCd);		
				model.addAttribute("orderPlayDetailList",orderPlayDetailList);
			}catch(RuntimeException e) {
				String message = e.getMessage();
				model.addAttribute("message",message);
			}
			
			return "jsonView";
		}
		
	

}
