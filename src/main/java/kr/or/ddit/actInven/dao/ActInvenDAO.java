package kr.or.ddit.actInven.dao;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.actInven.vo.ActInvenItemVO;
import kr.or.ddit.actInven.vo.ActInvenVO;
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
@Mapper
public interface ActInvenDAO {
	
	/**
	 * 실사재고 입력 목록 전체 조회
	 * @return
	 */
	public List<ActInvenVO> selecetActInvenList(PaginationInfo<ActInvenVO> paging);

	/**
	 * 실사재고 상세조회
	 * @param realCd
	 * @return
	 */
	public ActInvenVO selectActInvenView(String realCd);

	/**
	 * 실사재고 정보 수정(일자/담당자/창고/섹터)
	 * @param actInvenVO
	 * @return
	 */
	public int updateActInven(@Valid ActInvenVO actInvenVO);

	/**
	 * 실사재고 품목 정보 수정
	 * @param item
	 * @return 
	 */
	public int updateActInvenItem(ActInvenItemVO item);

	/**
	 * 실사재고 정보 입력(일자/담당자/창고/섹터)
	 * @param actInvenVO
	 * @return
	 */
	public int insertActInven(@Valid ActInvenVO actInvenVO);

	/**
	 * 실사재고 품목 정보 입력
	 * @param item
	 * @return
	 */
	public int insertActInvenItem(ActInvenItemVO item);

	/**
	 * totalRecord 조회
	 * @param paging
	 * @return
	 */
	public int selectTotalRecord(PaginationInfo<ActInvenVO> paging);

}
