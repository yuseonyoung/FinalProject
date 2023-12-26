package kr.or.ddit.storage.service;

import java.util.List;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.storage.vo.ItemWareVO;
import kr.or.ddit.storage.vo.WareSecVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 15.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 15.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

public interface SectorService {
	
	/**
	 * sector내의 특정 space와 item 조회
	 * 
	 * @return
	 */
	public List<WareSecVO> retrieveSelectSectorItem(WareSecVO wareSecVO);
	
	/**
	 * sector내의 space와 item 조회
	 * 
	 * @return
	 */
	public List<WareSecVO> retrieveSelectSectorItems(WareSecVO wareSecVO);

	/**
	 * 
	 *  여러 sector를 insert or update해주어야함 
	 * 
	 * @param wareSecList
	 * @return
	 */
	public ServiceResult createOrModifySector(List<WareSecVO> wareSecList);
	
	/**
	 * 
	 * 값이 있으면 qty에 값 더해서 update, 아니면 insert
	 * 
	 * @param itemWareVO
	 * @return
	 */
	public ServiceResult CreateMergeItemWare(List<ItemWareVO> itemWareList);
	
	/**
	 * 
	 * 섹터 삭제
	 * @param wareSecVO
	 * @return
	 */
	public ServiceResult removeWareSector(WareSecVO wareSecVO);
}
