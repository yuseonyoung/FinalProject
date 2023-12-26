package kr.or.ddit.purOrderRequest.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;
import kr.or.ddit.purOrderRequest.vo.ReqItemVO;

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

public interface PurOrderRequestService {
	
	/**
	 * 발주요청 전체 조회
	 * @return List<PurOrderRequestVO>
	 */
	public List<Map<String, Object>> retrievePurOrderList();
	
	/**
	 * 발주요청 코드로 조회
	 * 
	 * @return
	 */
	public List<Map<String, Object>> retrievePurOrder(String preqCd);
	
	/**
	 * 발주요청 수정
	 * 
	 * @return ServiceResult
	 */
	public ServiceResult modifyPurOrdReq(PurOrderRequestVO purOrderReVO, List<ReqItemVO> reqItemList);
	
	/**
	 * 
	 * 발주요청 삭제
	 * 
	 * @return ServiceResult
	 */
	public ServiceResult removePurOrdReq(String preqCd);
	
	/**
	 * 
	 * 발주요청 등록
	 * 
	 * @return ServiceResult
	 */
	public ServiceResult createPurOrdReq(PurOrderRequestVO purOrderReVO, List<ReqItemVO> reqItemList);	
	
	/**
	 * 
	 * 발주요청 현황 조회
	 * 
	 * @return
	 */
	public List<Map<String, Object>> retrieveWherePurOrderList(Map<String, Object> purOrderParam);
}
