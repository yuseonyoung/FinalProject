package kr.or.ddit.item.service;

import java.util.List;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.vo.StorageVO;

public interface ItemService {
	/**
	 * 항목 전체조회
	 * 
	 * @return
	 */
	public void retrieveItemList(PaginationInfo<ItemVO> paging);
	
	/**
	 * 
	 * 품목 등록
	 * 
	 * @param storageVO
	 * @return
	 */
	public ServiceResult createItem(ItemVO itemVO);
	
	/**
	 * 
	 * 창고 수정 , 미사용도 이것으로 처리
	 * 
	 * @param int
	 * @return
	 */
	public ServiceResult modifyItem(ItemVO itemVO);
	
	/**
	 * 
	 * 창고 미사용 처리
	 * 
	 * @param wareCode
	 * @return
	 */
	public ServiceResult modifyUnUseItem(String itemCode);
	
	/**
	 * 
	 * 코드 중복 체크
	 * 
	 * @param itemCode
	 * @return
	 */
	public ServiceResult duplicateItemCode(String itemCode);

	/**
	 * 
	 * 한 품목 데이터 조회
	 * @param itemCd
	 * @return
	 */
	public ItemVO retrieveItemDetail(String itemCd);
	
	
	/**
	 * 안전재고 파악 하는 정렬된 item 리스트
	 * 
	 * @param paging
	 * @return
	 */
	//public List<ItemVO> retrieveSafetyItemList(PaginationInfo<ItemVO> paging);
	
	public List<ItemVO> retrieveItemListDataTable(StorageVO storageVO);

	public ServiceResult modifyUseItem(String itemCode);

}
