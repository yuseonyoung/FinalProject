package kr.or.ddit.sale.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.quote.vo.QuoteItemVO;
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

public interface SaleService {
	/**
	 * 판매 전체조회
	 * @return List<SaleVO>
	 */
	public List<SaleVO> retrieveSaleList();
	
	/**
	 * 판매 상세조회
	 * @param saleCd
	 * @return
	 */
	public SaleVO retrieveSale(String saleCd);
	
	/**
	 * 판매 입력
	 * @param saleVO
	 * @return
	 */
	public ServiceResult createSale(SaleVO saleVO);
	
	/**
	 * 판매 수정
	 * @param saleVO
	 * @return
	 */
	public ServiceResult modifySale(SaleVO saleVO);

	/**
	 * 견적서코드를 조건으로 품목아이템 목록을 가져오자
	 * @return List<QuoteItemVO>
	 */
	public List<QuoteItemVO> getQteItemList(String qteCd);
	
	
}
