package kr.or.ddit.actInven.service;

import javax.validation.Valid;

import kr.or.ddit.actInven.vo.ActInvenVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.paging.vo.PaginationInfo;

/**
 * <pre>
 * 
 * </pre>
 * @author 최광식
 * @since 2023. 11. 20.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
public interface ActInvenService {
	
	/**
	 * 실사재고 전체 리스트 조회
	 * @return
	 */
	public void retrieveActInvenList(PaginationInfo<ActInvenVO> paging);

	/**
	 * 실사재고 상세조회
	 * @param realCd
	 * @return
	 */
	public ActInvenVO retrieveActInven(String realCd);

	/**
	 * 실사재고 정보 수정
	 * @param actInvenVO
	 * @return
	 */
	public ServiceResult modifyActInven(@Valid ActInvenVO actInvenVO);

	/**
	 * 실사재고 품목 입력
	 * @param actInvenVO
	 * @return
	 */
	public ServiceResult insertActInven(@Valid ActInvenVO actInvenVO);
}
