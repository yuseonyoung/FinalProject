package kr.or.ddit.scheduledStock.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.order.dao.OrderPlayDAO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.rels.dao.RelsDAO;
import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class ScheduledStackServiceImpl implements ScheduledStackService{
	
	@Inject
	private RelsDAO relsDao;
	@Inject
	private OrderPlayDAO orderDao;
	
	@Override
	public List<Map<String, Object>> retrieveOutStocked() {
	    List<Map<String, Object>> scheduledStack = relsDao.selectScheduledStock();
	    List<Map<String, Object>> uniqueScheduledStack = new ArrayList<>();
	    log.info("scheduledStack : {}",scheduledStack);
	    //count를 잡기위한 map 등록
	    Map<String, Integer> itemCountMap = new HashMap<>();

	    //조회되는 데이터중 출하지시서 한개에 여러개의 품목의 수량을 알기위한 count 확인  
	    for (Map<String, Object> item : scheduledStack) {
	        String rdrecCd = (String) item.get("rdrecCd");
	        BigDecimal parsedRdrecQty = (BigDecimal) item.get("rdrecQty");
	        int rdrecQty = parsedRdrecQty.intValue();

	        if (itemCountMap.containsKey(rdrecCd)) {
	            int count = itemCountMap.get(rdrecCd);
	            int qty = itemCountMap.containsKey(rdrecCd+"Qty") ? itemCountMap.get(rdrecCd+"Qty") : 0; // rdrecQty 키가 없으면 0을 기본값으로 사용
	            log.info("이것의  qty값을 보자 {}",itemCountMap.get(rdrecCd+"Qty"));
	            log.info("일단 qty값을 보자 {}",qty);
	            int rdQty = qty + rdrecQty; //중복된 숫자만큼 값 증가

	            itemCountMap.put(rdrecCd, count + 1); // 중복일 경우 count를 1 증가
	            itemCountMap.put(rdrecCd+"Qty", rdQty); // rdrecQty 업데이트
	        } else {
	            itemCountMap.put(rdrecCd, 1); // 첫 항목은 1로 설정
	            item.put("itemCount", 1); // itemCount = 1 을 컬럼으로 추가
	            itemCountMap.put(rdrecCd+"Qty", rdrecQty); // id값을 포함하지 않으면 그대로 put
	            item.put("rdrecQty", rdrecQty);
	            uniqueScheduledStack.add(item); 
	        }
	    }

	    //item에서 잡아온 count를 보낼 map에 저장
	    for (Map<String, Object> uniqueItem : uniqueScheduledStack) {
	        String rdrecCd = (String) uniqueItem.get("rdrecCd");
	        //int rdQty = (int) uniqueItem.get("rdrecQty");
	        
	        uniqueItem.put("itemCount", itemCountMap.get(rdrecCd)); // 각 항목의 itemCount 설정
	        uniqueItem.put("itemQty", itemCountMap.get(rdrecCd+"Qty")); // 각 항목의 itemCount 설정
	    }


	    return uniqueScheduledStack;
	}
	
	
	@Override
	public List<Map<String, Object>> retrieveScheduledOutStockDetail(String relsCd) {
		List<Map<String,Object>> selectDetail = relsDao.selectScheduledStockDetail(relsCd);
		if(selectDetail != null) {
			return selectDetail;
		}else {
			throw new RuntimeException("해당 출하지시서가 존재하지 않습니다.");
		}
	}

	/**
	 * 입고가 예정된 발주서를 조회하는 코드이다 (진행중 인것만 조회함.)
	 */
	@Override
	public List<Map<String, Object>> retrieveInStocked() {
		
		List<Map<String, Object>> selectOrderList= orderDao.selectPurOrderList();
		
		List<Map<String, Object>> uniqueScheduledStack = new ArrayList<>();
	    log.info("scheduledStack : {}",selectOrderList);
	    //count를 잡기위한 map 등록
	    Map<String, Integer> itemCountMap = new HashMap<>();

	    //조회되는 데이터중 출하지시서 한개에 여러개의 품목의 수량을 알기위한 count 확인  
	    for (Map<String, Object> item : selectOrderList) {
	        String pordCd = (String) item.get("pordCd");
	        BigDecimal parsedPordQty = (BigDecimal) item.get("pordQty");
	        int pordQty = parsedPordQty.intValue();

	        if (itemCountMap.containsKey(pordCd)) {
	            int count = itemCountMap.get(pordCd);
	            int qty = itemCountMap.containsKey(pordCd+"Qty") ? itemCountMap.get(pordCd+"Qty") : 0; // rdrecQty 키가 없으면 0을 기본값으로 사용
	            log.info("이것의  qty값을 보자 {}",itemCountMap.get(pordCd+"Qty"));
	            log.info("일단 qty값을 보자 {}",qty);
	            int rdQty = qty + pordQty; //중복된 숫자만큼 값 증가

	            itemCountMap.put(pordCd, count + 1); // 중복일 경우 count를 1 증가
	            itemCountMap.put(pordCd+"Qty", rdQty); // rdrecQty 업데이트
	        } else {
	            itemCountMap.put(pordCd, 1); // 첫 항목은 1로 설정
	            item.put("itemCount", 1); // itemCount = 1 을 컬럼으로 추가
	            itemCountMap.put(pordCd+"Qty", pordQty); // id값을 포함하지 않으면 그대로 put
	            item.put("rdrecQty", pordQty);
	            uniqueScheduledStack.add(item); 
	        }
	    }

	    //item에서 잡아온 count를 보낼 map에 저장
	    for (Map<String, Object> uniqueItem : uniqueScheduledStack) {
	        String rdrecCd = (String) uniqueItem.get("pordCd");
	        //int rdQty = (int) uniqueItem.get("rdrecQty");
	        
	        uniqueItem.put("itemCount", itemCountMap.get(rdrecCd)); // 각 항목의 itemCount 설정
	        uniqueItem.put("itemQty", itemCountMap.get(rdrecCd+"Qty")); // 각 항목의 itemCount 설정
	    }

	    log.info("전체값 한번 볼까 넘겨도 되는지 안되는지 {} : ",uniqueScheduledStack);
	    return uniqueScheduledStack;
		
	}


	@Override
	public List<Map<String, Object>> retrieveScheduledInStockDetail(String pordCd) {
		List<Map<String, Object>> selectDetail = orderDao.purOrderDetail(pordCd);
	
		if(selectDetail != null) {
			return selectDetail;
		}else {
			throw new RuntimeException("해당 출하지시서가 존재하지 않습니다.");
		}
	}
	
	

}
