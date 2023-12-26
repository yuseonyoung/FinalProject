package kr.or.ddit.sale.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.quote.vo.QuoteVO;
import kr.or.ddit.sale.vo.SaleItemVO;
import kr.or.ddit.sale.vo.SaleVO;

/**
 * @author 김도현
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      김도현       최초작성
 * 2023. 11. 18.	 김도현		조회작성
 * 2023. 11. 20.	 김도현		상세조회,등록,수정작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Mapper
public interface SaleDAO {
	
	/**
	 * 판매 전체조회
	 * @return
	 */
	public List<SaleVO> selectSaleList();
	
	/**
	 * 견적서코드를 조건으로 품목아이템 목록을 가져오자
	 * @return List<QuoteItemVO>
	 */
	public List<QuoteItemVO> getQteItemList(String qteCd);
	
	
	
	
	
	/**
	 * 판매 상세조회
	 * @param saleCd
	 * @return
	 */
	public SaleVO selectSale(String saleCd);
	
	/**
	 * 판매 입력
	 * @param saleVO
	 * @return
	 */
	public int insertSale(SaleVO saleVO);
	
	/**
	 * 판매 품목 입력
	 * @param saleItemVO
	 * @return
	 */
	
	public int insertSaleItem(SaleItemVO saleItemVO);
	
	/**
	 * 
	 * 판매 수정
	 * 
	 * @param saleVO
	 * @return
	 */
	public int updateSale(SaleVO saleVO);
	
	/**
	 * 판매 품목 수정
	 * @param saleItemVO
	 * @return
	 */
	public int updateSaleItem(SaleItemVO saleItemVO);
	
	public void deleteSaleItem(SaleVO saleVO);
}
