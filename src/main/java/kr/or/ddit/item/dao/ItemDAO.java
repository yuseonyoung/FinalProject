package kr.or.ddit.item.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.vo.StorageVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 11.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 11.      유선영      조회
 * 2023. 11. 16.      최광식      selectItem 추가
 * 
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Mapper
public interface ItemDAO {
	
	/**
	 * totalRecord 조회
	 * @param paging
	 * @return
	 */
	public int selectTotalRecord(PaginationInfo<ItemVO> paging);
	
	/**
	 * 품목 전체조회
	 * 
	 * @return
	 */
	public List<ItemVO> selectItemList(PaginationInfo<ItemVO> paging);
	
	/**
	 * 
	 * 품목 등록
	 * 
	 * @param storageVO
	 * @return
	 */
	public int insertItem(ItemVO itemVO);
	
	/**
	 * 
	 * 품목 조회시 사용할 공통코드
	 * 
	 * @return
	 */
	public List<ItemVO> itemGroupList();
	
	/**
	 * 
	 * 창고 수정 , 미사용도 이것으로 처리
	 * 
	 * @param int
	 * @return
	 */
	public int updateItem(ItemVO itemVO);
	
	/**
	 * 
	 * 품목 미사용 처리
	 * 
	 * @param wareCode
	 * @return
	 */
	public int unUseUpdateItem(String itemCode);
	
	
	/**
	 * 
	 * 창고 미사용 처리
	 * 
	 * @param wareCode
	 * @return
	 */
	public int useUpdateItem(String itemCode);
	/**
	 * 
	 * 코드 중복 체크
	 * 
	 * @param itemCode
	 * @return
	 */
	public int duplicateItemCode(String itemCode);
	
	/**
	 * 
	 * 한 품목 정보 조회
	 * @param itemCd
	 * @return
	 */
	public ItemVO selectItem(String itemCd);
	
	/**
	 * 안전재고 파악 하는 정렬된 item 리스트
	 * 
	 * @param paging
	 * @return
	 */
	//public List<ItemVO> selectSafetyItemList(PaginationInfo<ItemVO> paging);
	
	public List<ItemVO> selectItemListDataTable(StorageVO storageVO);
}
