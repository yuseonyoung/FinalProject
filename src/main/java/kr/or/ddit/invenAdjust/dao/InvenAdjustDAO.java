package kr.or.ddit.invenAdjust.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.actInven.vo.ActInvenVO;
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
@Mapper
public interface InvenAdjustDAO {

	/**
	 * 재고 오차 있는 리스트 출력
	 * @param paging
	 * @return
	 */
	public List<ActInvenVO> selectInvenAdjustList(PaginationInfo<ActInvenVO> paging);

	/**
	 * 재고 조정 입력
	 * @param actInvenVO
	 * @return
	 */
	public int insertInvenAdjust(ActInvenVO actInvenVO);
	
	/**
	 * 재고품목 전체조회
	 * @param paging
	 * @return
	 */
	public List<ItemWareVO> selectItemInvenAll(PaginationInfo<ItemWareVO> paging);
	
	public int selectTotalRecord(PaginationInfo<ItemWareVO> paging);

	public ItemWareVO selectItemDetail(ItemWareVO itemWareVO);
}
