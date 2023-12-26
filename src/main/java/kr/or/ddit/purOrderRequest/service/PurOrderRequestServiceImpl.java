package kr.or.ddit.purOrderRequest.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.purOrderRequest.controller.PurOrderRequestController;
import kr.or.ddit.purOrderRequest.dao.PurOrderRequestDAO;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;
import kr.or.ddit.purOrderRequest.vo.ReqItemVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author 유선영
 * @since 2023. 11. 27.
 * @version 1.0
 * 
 *         
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.    유선영      최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          
 */

@Slf4j
@Service
public class PurOrderRequestServiceImpl implements PurOrderRequestService{
	@Inject
	private PurOrderRequestDAO dao;
	@Inject
	private AlarmDAO alarmDao;
	
	@Inject
	private EmpDAO empDao;
	@Override
	public List<Map<String, Object>> retrievePurOrderList() {
		List<Map<String, Object>> purOrderList = dao.selectPurOrderList();
		List<Map<String, Object>> uniquepurOrderList = new ArrayList<>();
		
		Map<String, Integer> itemCountMap = new HashMap<>();
		
		for (Map<String, Object> item : purOrderList) {
	        String preqCd = (String) item.get("PREQ_CD");
	        BigDecimal parsedRdrecQty = (BigDecimal) item.get("REQ_ITEM_QTY");
	        int parseQty = parsedRdrecQty.intValue();

	        if (itemCountMap.containsKey(preqCd)) {
	            int count = itemCountMap.get(preqCd);
	            int qty = itemCountMap.containsKey(preqCd+"Qty") ? itemCountMap.get(preqCd+"Qty") : 0; // rdrecQty 키가 없으면 0을 기본값으로 사용
	         
	            int rdQty = qty + parseQty; //중복된 숫자만큼 값 증가

	            itemCountMap.put(preqCd, count + 1); // 중복일 경우 count를 1 증가
	            itemCountMap.put(preqCd+"Qty", rdQty); // rdrecQty 업데이트
	        } else {
	            itemCountMap.put(preqCd, 1); // 첫 항목은 1로 설정
	            item.put("itemCount", 1); // itemCount = 1 을 컬럼으로 추가
	            itemCountMap.put(preqCd+"Qty", parseQty); // id값을 포함하지 않으면 그대로 put
	            item.put("rdrecQty", parseQty);
	            uniquepurOrderList.add(item); 
	        }
	    }

	    //item에서 잡아온 count를 보낼 map에 저장
	    for (Map<String, Object> uniqueItem : uniquepurOrderList) {
	        String preqCd = (String) uniqueItem.get("PREQ_CD");
	        //int rdQty = (int) uniqueItem.get("rdrecQty");
	        
	        uniqueItem.put("itemCount", itemCountMap.get(preqCd)); // 각 항목의 itemCount 설정 
	        uniqueItem.put("itemQty", itemCountMap.get(preqCd+"Qty")); // 각 항목의 itemCount 설정
	    }
		return uniquepurOrderList;
	}

	@Override
	public List<Map<String, Object>> retrievePurOrder(String preqCd) {
		List<Map<String, Object>> purOrderDetail = dao.selectPurOrder(preqCd);
		if(purOrderDetail != null) {
			return purOrderDetail;
		}else {
			throw new RuntimeException("해당 발주요청서가 존재하지 않습니다.");
		}
	}

	@Override
	public ServiceResult modifyPurOrdReq(PurOrderRequestVO purOrderReVO, List<ReqItemVO> reqItemList) {
		ServiceResult result = null;
		ArrayList<Integer> results = new ArrayList<Integer>();
		
		int reqResult = dao.updatePurOrdReq(purOrderReVO);
		
		if (reqResult > 0 ) {
			for(ReqItemVO reqItemVO : reqItemList) {
				int itemResult = dao.updateReqItem(reqItemVO);
				results.add(itemResult);
			}
			
			if(results.contains(0)) {
				result = ServiceResult.FAIL;
			} else {
				result = ServiceResult.OK;
			}
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult removePurOrdReq(String preqCd) {
		ServiceResult result = null;

		int itemResult= dao.deleteReqItem(preqCd);
		if (itemResult > 0 ) {
			int reqResult = dao.deletePurOrdReq(preqCd);
			
			if(reqResult > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAIL;
			}
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult createPurOrdReq(PurOrderRequestVO purOrderReVO, List<ReqItemVO> reqItemList) {
		ServiceResult result = null;
		AlarmVO alarmVO = new AlarmVO();
		log.info("ssssssssssssssssssssssssssssssss{}",purOrderReVO);
		ArrayList<Integer> results = new ArrayList<Integer>();
		
		int reqResult = dao.insertPurOrdReq(purOrderReVO);
		
		if(reqResult > 0) {
			String preqCd = dao.selectPreqCd();
			for(ReqItemVO reqItemVO : reqItemList) {
				reqItemVO.setPreqCd(preqCd);
				int itemResult = dao.insertReqItem(reqItemVO);
				results.add(itemResult);
			}
			
			if(results.contains(0)) {
				result = ServiceResult.FAIL;
				 
			} else {
				result = ServiceResult.OK;
				List<EmpVO> empList= empDao.selectEmpList();
				
				if (empList != null && empList.size() > 0) {
				    for (EmpVO emp : empList) {
				        String deptNm = emp.getDeptNm();
				        String empNm = purOrderReVO.getEmpNm();
				        String empCd = purOrderReVO.getEmpCd();
				        if (deptNm != null && deptNm.equals("구매부")) {
				            alarmVO.setAlarmReceiver(emp.getEmpCd());
				            alarmVO.setAlarmUrl("/orderPlan/enroll");
				            alarmVO.setAlarmCont("발주 요청서가 " + empNm + "[자재부]님 으로부터 도착하였습니다.");
				            log.info("ssssssssssssssss222222222222222222ssssssssssssssss{}",alarmVO);
				            alarmDao.insertMailAlarm(alarmVO);
				        }
				    }
				}
			}
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> retrieveWherePurOrderList(Map<String, Object> purOrderParam) {
		List<Map<String, Object>> purOrderList = dao.whereSelectPurOrderList(purOrderParam);
		
		List<Map<String, Object>> uniquepurOrderList = new ArrayList<>();
		
		Map<String, Integer> itemCountMap = new HashMap<>();
		
		for (Map<String, Object> item : purOrderList) {
	        String preqCd = (String) item.get("PREQ_CD");
	        BigDecimal parsedRdrecQty = (BigDecimal) item.get("REQ_ITEM_QTY");
	        int parseQty = parsedRdrecQty.intValue();

	        if (itemCountMap.containsKey(preqCd)) {
	            int count = itemCountMap.get(preqCd);
	            int qty = itemCountMap.containsKey(preqCd+"Qty") ? itemCountMap.get(preqCd+"Qty") : 0; // rdrecQty 키가 없으면 0을 기본값으로 사용
	         
	            int rdQty = qty + parseQty; //중복된 숫자만큼 값 증가

	            itemCountMap.put(preqCd, count + 1); // 중복일 경우 count를 1 증가
	            itemCountMap.put(preqCd+"Qty", rdQty); // rdrecQty 업데이트
	        } else {
	            itemCountMap.put(preqCd, 1); // 첫 항목은 1로 설정
	            item.put("itemCount", 1); // itemCount = 1 을 컬럼으로 추가
	            itemCountMap.put(preqCd+"Qty", parseQty); // id값을 포함하지 않으면 그대로 put
	            item.put("preqCd", parseQty);
	            uniquepurOrderList.add(item); 
	        }
	    }

	    //item에서 잡아온 count를 보낼 map에 저장
	    for (Map<String, Object> uniqueItem : uniquepurOrderList) {
	        String preqCd = (String) uniqueItem.get("PREQ_CD");
	        //int rdQty = (int) uniqueItem.get("rdrecQty");
	        
	        uniqueItem.put("itemCount", itemCountMap.get(preqCd)); // 각 항목의 itemCount 설정 
	        uniqueItem.put("itemQty", itemCountMap.get(preqCd+"Qty")); // 각 항목의 itemCount 설정
	    }
		return uniquepurOrderList;
 	}
	
	
}
