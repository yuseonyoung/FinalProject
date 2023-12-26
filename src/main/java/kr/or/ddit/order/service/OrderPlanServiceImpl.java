package kr.or.ddit.order.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.order.dao.OrderPlanDAO;
import kr.or.ddit.order.dao.OrderPlayDAO;
import kr.or.ddit.order.dao.OrderUnitPriceDAO;
import kr.or.ddit.order.vo.OrderPlanVO;
import kr.or.ddit.order.vo.OrderUnitPriceItemVO;
import kr.or.ddit.order.vo.OrderUnitPriceVO;
import kr.or.ddit.order.vo.PurOrdItemVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.order.vo.egaemajaVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.purOrderRequest.dao.PurOrderRequestDAO;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderPlanServiceImpl implements OrderPlanService {
	
	private final OrderPlanDAO orderPlanDAO;
	private final OrderUnitPriceDAO orderUnitPriceDAO;
	private final OrderPlayDAO orderPlayDAO;
	private final PurOrderRequestDAO purOrderRequestDAO;

	@Override
	public List<OrderPlanVO> retrieveOrderPlan() {
		List<OrderPlanVO> opList = orderPlanDAO.selectOrderPlanList();
		
		return opList;
	}
	
	@Override
	public List<OrderPlanVO> retrieveOrderPlanOne(String pplanCd) {
		List<OrderPlanVO> opList = orderPlanDAO.selectOrderPlanListOne(pplanCd);
		return opList;
	}
	
	@Override
	public List<OrderPlanVO> retrieveOrderPlanOneUnitPrice(String pplanCd) {
		List<OrderPlanVO> opList = orderPlanDAO.selectOrderPlanListOneUnitPrice(pplanCd);
		return opList;
	}

	@Override
	public List<OrderPlanVO> retrieveOrderPlanOneOrder(String pplanCd) {
		List<OrderPlanVO> opList = orderPlanDAO.selectOrderPlanListOneOrderPlan(pplanCd);
		return opList;
	}
	
	// 요청서 조회.
	@Override
	public List<PurOrderRequestVO> retrieveOrderPlanEnroll() {
		List<PurOrderRequestVO> opeList = orderPlanDAO.selectOrderPlanEnrollList();
		
		return opeList;
	}
	
	//요청서 상세조회!
	@Override
	public List<PurOrderRequestVO> retrieveOrderPlanEnrollOne(String preqCd) {
		List<PurOrderRequestVO> aa = orderPlanDAO.selectOrderPlanEnrollOne(preqCd);
		return aa;
	}

	@Transactional
	@Override 
	public ServiceResult createOrderPlan(OrderPlanVO orderPlan) {
		int aa= orderPlanDAO.insertOrderPlan(orderPlan);
		
		modifyOrderRequest(orderPlan.getPreqCd());
	
		ServiceResult result = null;
	
		if(aa>0) { 
			result = ServiceResult.OK; 
		}else { 
			result = ServiceResult.FAIL; 
			}
		return result; 
	}
	
	@Override
	public ServiceResult createOrderPlanMulti(PurOrderRequestVO[] data) {
		int aa=0;
		ServiceResult result = null;
		
		
		for (int i = 0; i < data.length; i++) { 
		OrderPlanVO opvo = new OrderPlanVO();
		
		opvo.setPplanDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		
		opvo.setPreqCd(data[i].getPreqCd());
		
		opvo.setEmpCd(data[i].getEmpCd());
		
		aa=orderPlanDAO.insertOrderPlan(opvo);
		
		modifyOrderRequest(opvo.getPreqCd());
		
		}
		
		if(aa>0) { 
			result = ServiceResult.OK; 
		}else { 
			result = ServiceResult.FAIL; 
			}
		
		return result; 
	}
	
	
	
	@Override
	public ServiceResult modifyOrderRequest(String preqCd) {
		int aa = orderPlanDAO.updateOrderReq(preqCd);
		
		ServiceResult result = null;
		
		if(aa>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}
	
	//단가요청서 insert 문 단가요청서 insert 문 단가요청서 insert 문 단가요청서 insert 문 단가요청서 insert 문
	/**
	 * 단가요청서 insert 문 
	 */
	@Transactional
	@Override
	public ServiceResult createUnit(egaemajaVO[] egae) {
		ServiceResult aa = null;
		
		LocalDate today = LocalDate.now();
		
		LocalDate nextMonth = today.plusMonths(1);
		
		LocalDate futureDate = today.plusMonths(3);
		
		OrderUnitPriceVO oup = new OrderUnitPriceVO();
		
		oup.setEmpCd(egae[0].getEmpCd());
		
		oup.setUpreqDate(today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		
		oup.setUpreqValDate(nextMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		
		oup.setPplanCd(egae[0].getPplanCd());
		
		System.out.println("oupoupoupoupoupoupoupoupoupoupoup"+oup);
		
		aa =createUnitPirce(oup);
		
		for (int i = 0; i < egae.length; i++) {
			OrderUnitPriceItemVO oupi = new OrderUnitPriceItemVO();
			
			oupi.setItemCd(egae[i].getItemCd());
			
			oupi.setUprcItQty(egae[i].getReqItemQty());
			
			oupi.setUpreqDur(futureDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
			
			aa = createUnitPriceItem(oupi);
			
		}
		OrderPlanVO op = new OrderPlanVO();
		op.setPplanCd(egae[0].getPplanCd());
		aa = modifyOrderPlan(op);
		return aa;
	}
	
	@Override
	public ServiceResult createUnitPirce(OrderUnitPriceVO oup) {
		ServiceResult aa = null;
		int a = orderUnitPriceDAO.insertUnitPrice(oup);
		
		if(a>0) {
			aa = ServiceResult.OK;
		}else {
			aa= ServiceResult.FAIL;
		}
		return aa;
	}
	
	@Override
	public ServiceResult createUnitPriceItem(OrderUnitPriceItemVO oupi) {
		ServiceResult aa = null;
		
		int a = orderUnitPriceDAO.insertUnitPriceItem(oupi);
		
		if(a>0) {
			aa = ServiceResult.OK;
		}else {
			aa= ServiceResult.FAIL;
		}
		return aa;
	}

	//단가요청서 insert 끝 단가요청서 insert 끝 단가요청서 insert 끝 단가요청서 insert 끝 단가요청서 insert 끝
	
	
	@Override
	public ServiceResult modifyOrderPlan(OrderPlanVO orderPlan) {
		ServiceResult aa = null;
		int a = orderPlanDAO.updateOrderPlan(orderPlan);
		if(a>0) {
			aa = ServiceResult.OK;
		}else {
			aa= ServiceResult.FAIL;
		}
		return aa;
	}
	
	// 발주서 insert 문 발주서 insert 문 발주서 insert 문 발주서 insert 문 발주서 insert 문 발주서 insert 문

	@Override
	public ServiceResult createOrder(egaemajaVO[] egae) {
		ServiceResult aa = null;
		
		LocalDate today = LocalDate.now();
		
		LocalDate nextMonth = today.plusMonths(1);
		
		PurOrdVO po = new PurOrdVO();
		
		po.setEmpCd(egae[0].getEmpCd());
		
		po.setPplanCd(egae[0].getPplanCd());
		
		po.setPordDate(today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		
		po.setDueDate(nextMonth.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		
		System.out.println("popopopopopopopopopopo"+po);
		
		aa=createOrderPlay(po);
		// comCd 에 따라서 구분지어서 insert해야된다. . 
		for (int i = 0; i < egae.length; i++) {
			PurOrdItemVO poi = new PurOrdItemVO();
			
			poi.setItemCd(egae[i].getItemCd());
			poi.setPordQty(egae[i].getReqItemQty());
			poi.setPordUprc(egae[i].getInUprc());
			poi.setComCd(egae[i].getComCd());
			
			aa=createOrderPlayItem(poi);
			
		}
		OrderPlanVO op = new OrderPlanVO();
		op.setPplanCd(egae[0].getPplanCd());
		aa = modifyOrderPlan(op);
		return aa;
	}

	@Override
	public ServiceResult createOrderPlay(PurOrdVO po) {
		ServiceResult aa = null;
		int a =orderPlayDAO.insertPurOrd(po);
		if(a>0) {
			aa = ServiceResult.OK;
		}else {
			aa= ServiceResult.FAIL;
		}
		return aa;
	}

	@Override
	public ServiceResult createOrderPlayItem(PurOrdItemVO poi) {
		ServiceResult aa = null;
		int a =orderPlayDAO.insertPurOrdItem(poi);
		if(a>0) {
			aa = ServiceResult.OK;
		}else {
			aa= ServiceResult.FAIL;
		}
		return aa;
	}

	@Override
	public void retrieveOrderPlan(PaginationInfo<OrderPlanVO> paging) {
		int totalRecord = orderPlanDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<OrderPlanVO> dataList = orderPlanDAO.selectOrderPlanList2(paging);
		paging.setDataList(dataList);
		
	}

	@Override
	public void retrieveOrderPlanEnroll(PaginationInfo<PurOrderRequestVO> paging) {
		int totalRecord = purOrderRequestDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<PurOrderRequestVO> dataList = purOrderRequestDAO.selectOrderPlanList2(paging);
		paging.setDataList(dataList);
		
		
	}

	

	// 발주서 insert 끝 발주서 insert 끝 발주서 insert 끝 발주서 insert 끝 발주서 insert 끝 발주서 insert 끝


}
