package kr.or.ddit.quote.dao;

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

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.quote.vo.QuoteVO;

@Mapper
public interface QuoteDAO {
	
	/**
	 * 견적서 전체조회
	 * 
	 * @return
	 */
	public List<QuoteVO> selectQuoteList();
	
	/**
	 * 견적서 상세조회
	 * @param qteCd
	 * @return
	 */
	public QuoteVO selectQuote(String qteCd);
	
	
	/**
	 * 견적서 입력
	 * @param quoteVO
	 * @return
	 */

	public int insertQuote(QuoteVO quoteVO);
	
	/**
	 * 견적서 품목 입력
	 * @param quoteItemVO
	 * @return
	 */
	
	public int insertQuoteItem(QuoteItemVO quoteItemVO);

	/**
	 * 견적서 수정
	 * @param quoteVO
	 * @return
	 */
	public int updateQuote(QuoteVO quoteVO);
	
	/**
	 * 견적서 품목 수정
	 * @param quoteItemVO
	 * @return
	 */
	public int updateQuoteItem(QuoteItemVO quoteItemVO);

	
	
	public void deleteQuoteItem(QuoteVO quoteVO);
	
	
	public int updateQteStat(QuoteVO quoteVO);
}


