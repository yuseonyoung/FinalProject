package kr.or.ddit.quote.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.quote.vo.QuoteVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      김도현      최초작성
 * 2023. 11. 9.		 김도현	   조회작성 
 * 2023. 11. 13.     김도현      상세조회 작성
 * 2023. 11. 15.	 김도현	   등록작성
 * 2023. 11. 17.     김도현      수정작성
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

public interface QuoteService {

	/**
	 * 견적서 전체 리스트 조회
	 * @return List<QuoteVO>
	 */
	public List<QuoteVO> retrieveQuoteList();
	
	/**
	 * 견적서 상세조회
	 * @param qteCd
	 * @return
	 */
	public QuoteVO retrieveQuote(String qteCd);
	
	/**
	 * 견적서 입력
	 * @param quoteVO
	 * @return
	 */
	public ServiceResult createQuote(QuoteVO quoteVO);
	
	
	/**
	 * 견적서 수정
	 * @param quoteVO
	 * @return
	 */
	public ServiceResult modifyQuote(QuoteVO quoteVO);
	
	/**
	 * 견적서 상태 업데이트
	 * @param quoteVO
	 * @return
	 */
	public ServiceResult modifyQteStat(QuoteVO quoteVO);
	
}



