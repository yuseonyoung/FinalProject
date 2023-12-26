package kr.or.ddit.purOrderRequest.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.order.vo.OrderPlanVO;
import kr.or.ddit.paging.vo.PaginationInfo;
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


@Mapper
public interface PurOrderRequestDAO {
	
	/**
	 * 발주요청 전체 조회
	 * 
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> selectPurOrderList();
	
	/**
	 * 발주요청 코드로 조회
	 * 
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> selectPurOrder(String preqCd);

	/**
	 * 발주요청 수정
	 * 
	 * @return int
	 */
	public int updatePurOrdReq(PurOrderRequestVO purOrderReVO);
	
	/**
	 * 
	 * 발주요청 품목 수정
	 * 
	 * @return int
	 */
	public int updateReqItem(ReqItemVO reqItemVO);
	
	/**
	 * 
	 * 발주요청 삭제
	 * 
	 * @return int
	 */
	public int deletePurOrdReq(String preqCd);
	
	/**
	 * 
	 * 발주요청 품목 삭제
	 * 
	 * @return int
	 */
	public int deleteReqItem(String preqCd);
	
	/**
	 * 
	 * 발주요청 등록
	 * 
	 * @return int
	 */
	public int insertPurOrdReq(PurOrderRequestVO purOrderReVO);	
	
	/**
	 * 
	 * 발주요청 품목 등록
	 * 
	 * @return int
	 */
	public int insertReqItem(ReqItemVO reqItemVO);
	
	/**
	 * 
	 * 발주요청 코드 조회
	 * 
	 * @return String
	 */
	public String selectPreqCd();
	
	/**
	 * 
	 * 발주요청 현황 조회
	 * 
	 * @return
	 */
	public List<Map<String, Object>> whereSelectPurOrderList(Map<String, Object> purOrderParam);
	
	public int selectTotalRecord(PaginationInfo<PurOrderRequestVO> paging);
    public List<PurOrderRequestVO> selectOrderPlanList2(PaginationInfo<PurOrderRequestVO> paging);
}
