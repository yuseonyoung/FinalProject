package kr.or.ddit.invenAdjust.service;

import javax.validation.Valid;

import kr.or.ddit.actInven.vo.ActInvenVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.invenAdjust.vo.InvenAdjustVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.vo.ItemWareVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 최광식
 * @since 2023. 11. 27.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

public interface InvenAdjustService {
	
	/**
	 * 재고 오차가 있는 리스트 조회
	 * @param paging
	 */
	public void retrieveInvenAdjustList(PaginationInfo<ActInvenVO> paging);

	/**
	 * 재고 조정
	 * @param actInvenVO
	 * @return
	 */
	public ServiceResult createIndenAdjust(ActInvenVO actInvenVO);

	/**
	 * 재고 전체 조회
	 * @param paging
	 */
	public void retrieveInvenItemAll(PaginationInfo<ItemWareVO> paging);

	/**
	 * 품목 상세조회
	 * @param itemCd
	 * @return
	 */
	public ItemWareVO retrieveItemDetail(ItemWareVO itemWareVO);

}
