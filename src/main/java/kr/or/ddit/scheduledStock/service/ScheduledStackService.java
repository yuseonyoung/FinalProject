package kr.or.ddit.scheduledStock.service;

import java.util.List;
import java.util.Map;

public interface ScheduledStackService {
	/**
	 * 
	 * 출고예정인 출하지시서를 조회하기위한 메소드
	 * 
	 * @return
	 */
	public List<Map<String, Object>> retrieveOutStocked();
	
	/**
	 *  출고예정인 출하지시서의 상세정보
	 * 
	 * @return
	 */
	public List<Map<String,Object>> retrieveScheduledOutStockDetail(String relsCd);
	
	/**
	 * 
	 * 입고예정인 발주서를 조회하기 위한 메소드
	 * 
	 */
	public List<Map<String, Object>> retrieveInStocked();
	
	/**
	 * 입고예정인 발주서의 상세정보
	 * 
	 * @param pordCd
	 * @return
	 */
	public  List<Map<String, Object>> retrieveScheduledInStockDetail(String pordCd);
	
	
	
}
