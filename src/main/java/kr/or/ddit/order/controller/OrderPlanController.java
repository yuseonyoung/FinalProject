package kr.or.ddit.order.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.order.service.OrderPlanService;
import kr.or.ddit.order.vo.OrderPlanVO;
import kr.or.ddit.order.vo.egaemajaVO;
import kr.or.ddit.paging.OrderBootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.paging.vo.SearchVO;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/orderPlan")
public class OrderPlanController {

	private final OrderPlanService service;


	@GetMapping("/list")
	public String orderPlanRetrieve(Model model) {
		return "order/orderPlanList";
	}

	@GetMapping("/list22")
	@ResponseBody
	public List<OrderPlanVO> orderPlanRetrieve() {
		List<OrderPlanVO> orderPlanList = service.retrieveOrderPlan();
		return orderPlanList;
	}
	@GetMapping("/list2")
	@ResponseBody
	public PaginationInfo<OrderPlanVO> orderPlanRetrieve(
			Model model
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			) {
		PaginationInfo<OrderPlanVO> paging = new PaginationInfo<>(10,5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		service.retrieveOrderPlan(paging);
		
		paging.setRenderer(new OrderBootstrapPaginationRenderer());
		model.addAttribute("paging",paging);
		
		return paging;
	}

	@GetMapping("/enroll")
	public String orderPlanEnroll(Model model) {
		return "order/orderPlanEnroll";
	}

	@GetMapping("/enroll22")
	@ResponseBody
	public List<PurOrderRequestVO> orderPlanEnroll() {
		List<PurOrderRequestVO> opeList = service.retrieveOrderPlanEnroll();
		return opeList;
	}
	@GetMapping("/enroll2")
	@ResponseBody
	public PaginationInfo<PurOrderRequestVO> orderPlanEnroll(
			Model model
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @RequestParam(value="page", required=false, defaultValue="1") int currentPage
			) {
		PaginationInfo<PurOrderRequestVO> paging = new PaginationInfo<>(10,5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		service.retrieveOrderPlanEnroll(paging);
		
		paging.setRenderer(new OrderBootstrapPaginationRenderer());
		model.addAttribute("paging",paging);
		
		return paging;
	}

	/**
	 * 단가기간이 남아있기에 바로 발주서로 간다. 진행상태는 몰라..
	 * @param vo
	 * @param errors
	 * @param principal
	 * @param model
	 * @return
	 */
	@PostMapping(value="/order", produces = MediaType.TEXT_PLAIN_VALUE) 
	@ResponseBody
	public String orderForm(@Valid
	@RequestBody egaemajaVO[] vo
	, Errors errors, Authentication principal, Model model
	) {
		for (int i = 0; i < vo.length; i++) {
			vo[i].setEmpCd(principal.getName()); 
		}
		
	
		ServiceResult Result=service.createOrder(vo);
		
		return Result.name();
	}
	

	/**
	 * 단가기간이 만료됐거나 첫상품 주문시 단가요청서로 가서 단가를 받아와야된다! 
	 * @param vo
	 * @param errors
	 * @param principal
	 * @param model
	 * @return
	 */
	@PostMapping(value="/unitPrice", produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String unitPriceForm(@Valid @RequestBody egaemajaVO[] vo,
			Errors errors, Authentication principal, Model model) {
		
		for (int i = 0; i < vo.length; i++) {
			vo[i].setEmpCd(principal.getName());
		}
		ServiceResult Result =	service.createUnit(vo);
			
		return Result.name();
	}

	
	
	@PostMapping
	public String orderPlanForm(@Valid @RequestBody OrderPlanVO vo, Errors errors, Authentication principal,
			Model model) {
		boolean valid = !errors.hasErrors();

		vo.setEmpCd(principal.getName());

		vo.setPplanDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));

		String viewName = null;

		if (valid) {
			ServiceResult result = service.createOrderPlan(vo);

			switch (result) {
			case OK:
				viewName = "order/orderPlanList";
				break;
			default:
				model.addAttribute("message", "오류");
				viewName = "order/orderPlanEnroll";
				break;
			}
		} else {
			viewName = "order/orderPlanEnroll";
		}
		
		return viewName;
	}

	@PostMapping("/enrollData")
	public String multiEnroll(@Valid @RequestBody PurOrderRequestVO[] data, Errors errors, Authentication principal,
			Model model) {
		
			for (int i = 0; i < data.length; i++) {
				data[i].setEmpCd(principal.getName());
			}
			
			System.out.println(data[0]);
			
			service.createOrderPlanMulti(data);

	
		
		return "order/orderPlanEnroll";
	}



	@GetMapping("/view")
	@ResponseBody
	public List<PurOrderRequestVO> orderPlanEnrollView(@RequestParam("what") String preqCd) {

		List<PurOrderRequestVO> porOne = service.retrieveOrderPlanEnrollOne(preqCd);

		return porOne;
	}

	/**
	 * 발주계획서 상세 리스트
	 * 
	 * @param preqCd
	 * @return
	 */
	@GetMapping("/listView")
	@ResponseBody
	public List<OrderPlanVO> orderPlanListView(@RequestParam("what") String preqCd) {
		List<OrderPlanVO> porOne = service.retrieveOrderPlanOne(preqCd);
		return porOne;
	}
	
	/**
	 * 발주계획서 상세 리스트
	 * 
	 * @param preqCd
	 * @return
	 */
	@GetMapping("/listViewUnitPrice")
	@ResponseBody
	public List<OrderPlanVO> orderPlanListViewUnitPrice(@RequestParam("what") String preqCd) {
		List<OrderPlanVO> porOne = service.retrieveOrderPlanOneUnitPrice(preqCd);
		return porOne;
	}
	
	/**
	 * 발주계획서 상세 리스트
	 * 
	 * @param preqCd
	 * @return
	 */
	@GetMapping("/listViewOrderPlan")
	@ResponseBody
	public List<OrderPlanVO> orderPlanListViewOrderPlan(@RequestParam("what") String preqCd) {
		List<OrderPlanVO> porOne = service.retrieveOrderPlanOneOrder(preqCd);
		return porOne;
	}

}
