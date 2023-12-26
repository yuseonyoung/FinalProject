package kr.or.ddit.rels.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.quote.vo.QuoteVO;
import kr.or.ddit.rels.vo.RelsVO;
import kr.or.ddit.sale.vo.SaleItemVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      김도현      최초작성
 * 2023. 11. 21. 	  김도현		조회, 등록, 수정작성
 * 2023. 11. 24.      김도현	    등록, 수정 Map으로 변경
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

public interface RelsService {
	/**
	 * 출하지시서 전체 리스트 조회
	 * @return List<RelsVO>
	 */
	public List<RelsVO> retrieveRelsList();
	
	/**
	 * 출하지시서 상세조회
	 * @param relsCd
	 * @return
	 */
	public RelsVO retrieveRels(String relsCd);
	
	/**
	 * 출하지시서 입력
	 * @param relsVO
	 * @return
	 */
	public ServiceResult createRels(RelsVO relsVO);
	
	/**
	 * 출하지시서 수정
	 * @param relsVO
	 * @return
	 */
	public ServiceResult modifyRels(RelsVO relsVO);
	
	
	/**
	 * 판매코드를 조건으로 품목아이템 목록을 가져오자
	 * @return List<SaleItemVO>
	 */
	public List<SaleItemVO> getSaleItemList(String saleCd);
}
