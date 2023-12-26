package kr.or.ddit.storage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.storage.vo.InventoryReceiptPaymentVO;
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
@Mapper
public interface SectorDAO {
	/**
	 * 
	 * sector내의 특정 space와 item 조회
	 * 
	 * @return
	 */
	public List<WareSecVO> selectSectorItemList(WareSecVO wareSecVO);
	
	/**
	 * 
	 * sector내의 space와 item 조회
	 * 
	 * @return
	 */
	public List<WareSecVO> selectSectorItemsList(WareSecVO wareSecVO);
	
	/**
	 * 
	 *  여러 sector를 insert해주어야함 
	 * 
	 * @param wareSecList
	 * @return
	 */
	public int insertWareSector(WareSecVO wareSecVO);
	
	/**
	 * 
	 *  여러 sector를 update해주어야함 
	 * 
	 * @param wareSecList
	 * @return
	 */
	public int updateWareSector(WareSecVO wareSecVO);
	
	/**
	 * 
	 * 있으면 qty만 더해서 update, 아니면 insert
	 * 
	 * @param itemWareVO
	 * @return
	 */
	public int mergeItemWare(ItemWareVO itemWareVO);
	
	/**
	 * 
	 * 섹터 삭제
	 * @param wareSecVO
	 * @return
	 */
	public int removeWareSector(WareSecVO wareSecVO);
	
	/**
	 * 
	 * 창고이동 할 때 이동 전 아이템 삭제
	 * 
	 * @param itemWareVO
	 * @return
	 */
	public int removeItemWare(InventoryReceiptPaymentVO invenVO);
}
