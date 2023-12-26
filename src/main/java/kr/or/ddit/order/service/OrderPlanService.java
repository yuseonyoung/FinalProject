package kr.or.ddit.order.service;

import java.util.List;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.order.vo.OrderPlanVO;
import kr.or.ddit.order.vo.OrderUnitPriceItemVO;
import kr.or.ddit.order.vo.OrderUnitPriceVO;
import kr.or.ddit.order.vo.PurOrdItemVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.order.vo.egaemajaVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;

public interface OrderPlanService {
	//조회
	public List<OrderPlanVO> retrieveOrderPlan();
	
	public void retrieveOrderPlan(PaginationInfo<OrderPlanVO> paging);
	
	//상세조회
	public List<OrderPlanVO> retrieveOrderPlanOne(String pplanCd);
	//상세조회 조건1 UnitPrice 에 관한..
	public List<OrderPlanVO> retrieveOrderPlanOneUnitPrice(String preqCd);
	//상세조회 조건2
	public List<OrderPlanVO> retrieveOrderPlanOneOrder(String preqCd);
	
	//조회
	public List<PurOrderRequestVO> retrieveOrderPlanEnroll();
	public void retrieveOrderPlanEnroll(PaginationInfo<PurOrderRequestVO> paging);
	//상세조회
	public List<PurOrderRequestVO> retrieveOrderPlanEnrollOne(String preqCd);
	
	//insert
	public ServiceResult createOrderPlan(OrderPlanVO orderPlan);
	//여러개 insert
	public ServiceResult createOrderPlanMulti(PurOrderRequestVO[] data);
	
	//신규 계획서 등록시 요청서 상태 update
	public ServiceResult modifyOrderRequest(String preqCd);
	
	//service에서 단가요청서 만들어주기
	public ServiceResult createUnit(egaemajaVO[] egae);
	
	//insert 단가요청서
	public ServiceResult createUnitPirce(OrderUnitPriceVO oup);
	
	public ServiceResult createUnitPriceItem(OrderUnitPriceItemVO oupi);
	
	//service에서 발주서 만들어주기
	public ServiceResult createOrder(egaemajaVO[] egae);
	
	//insert 발주서
	public ServiceResult createOrderPlay(PurOrdVO po);
	
	public ServiceResult createOrderPlayItem(PurOrdItemVO poi);
	
	//update
	public ServiceResult modifyOrderPlan(OrderPlanVO orderPlan);
	
	//delete 는 어떤거 ? 
}
