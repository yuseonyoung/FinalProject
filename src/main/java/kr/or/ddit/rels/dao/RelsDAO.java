package kr.or.ddit.rels.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.rels.vo.RelsItemVO;
import kr.or.ddit.rels.vo.RelsVO;
import kr.or.ddit.sale.vo.SaleItemVO;
import kr.or.ddit.sale.vo.SaleVO;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 김도현
 * @since 2023. 11. 21.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      김도현      최초작성
 * 2023. 11. 21.	  김도현		조회, 등록, 수정작성
 * 2023. 11. 22.	  유선영		출하 예정 조회
 * 2023. 11. 24.	  김도현		등록과 수정 Map으로 변경
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */

@Mapper
public interface RelsDAO {

	/**
	 * 출하지시서서 전체조회
	 * 
	 * @return
	 */
	public List<RelsVO> selectRelsList();

	/**
	 * 판매코드를 조건으로 품목아이템 목록을 가져오자
	 * @return List<SaleItemVO>
	 */
	public List<SaleItemVO> getSaleItemList(String saleCd);
	
	/**
	 * 출하지시서 상세조회
	 * 
	 * @param relsCd
	 * @return
	 */
	public RelsVO selectRels(String relsCd);

	/**
	 * 출하지시서 입력
	 * 
	 * @param relsVO
	 * @return
	 */
	public int insertRels(RelsVO relsVO);
	
	/**
	 * 출하지시서 품목 입력
	 * @param relsItemVO
	 * @return
	 */
	
	public int insertRelsItem(RelsItemVO relsItemVO);
	
	/**
	 * 출하지시서 수정
	 * 
	 * @param relsVO
	 * @return
	 */
	public int updateRels(RelsVO relsVO);

	/**
	 * 출하지시서 품목 수정
	 * @param relsItemVO
	 * @return
	 */
	public int updateRelsItem(RelsItemVO relsItemVO);
	
	public void deleteRelsItem(RelsVO relsVO);
	
	/**
	 * 출하예정서 조회
	 * 
	 * @return
	 */
	public List<Map<String, Object>> selectScheduledStock();

	/**
	 * 출하지시서 상세조회
	 * 
	 * @return
	 */
	public List<Map<String, Object>> selectScheduledStockDetail(String relsCd);

	/**
	 * 출하 확정을 위한 Form List
	 * 
	 * @return
	 */
	public List<Map<String, Object>> shippingProcessForm();
	
	/**
	 * 
	 * 출고진행을 통한 출하지시서 상태변경 
	 * 
	 * @param statList
	 * @return
	 */
	public int updateRelsStat(String rdrecCd);

}
