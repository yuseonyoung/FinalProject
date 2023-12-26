package kr.or.ddit.quote.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.quote.dao.QuoteDAO;
import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.quote.vo.QuoteVO;
import lombok.extern.slf4j.Slf4j;


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
@Slf4j
@Service
public class QuoteServiceImpl implements QuoteService{

	@Inject
	private QuoteDAO dao;

	@Override
	public List<QuoteVO> retrieveQuoteList() {
		return dao.selectQuoteList();
	}

	@Override
	public QuoteVO retrieveQuote(String qteCd) {
		return dao.selectQuote(qteCd);
	}
	
	
	
	@Override
	public ServiceResult createQuote(QuoteVO quoteVO) {
		/*
		 QuoteVO(qteNum=0, qteCd=null, qteDate=2023-12-04, qteStat=T001, comCd=COM036, comNm=㈜트린프, empCd=E201001110501, empNm=조현준, btbQteCd=null, qteUprc=0, qteQty=0, itemCd=null, company=null, employee=null, 
		 	quoteItem=[QuoteItemVO(qteCd=null, itemCd=dsaf, qteUprc=2.0, qteQty=1.0, 
		 		item=ItemVO(itemCd=null, itemNm=fda, itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null)), 
		 	QuoteItemVO(qteCd=null, itemCd=TEST2, qteUprc=5.0, qteQty=3.0, 
		 		item=ItemVO(itemCd=null, itemNm=DDDDD, itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null)), 
		 	QuoteItemVO(qteCd=null, itemCd=D015VC001, qteUprc=9.0, qteQty=7.0, 
		 		item=ItemVO(itemCd=null, itemNm=무선청소기, itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null))])
		 */
		//1
		int qte = dao.insertQuote(quoteVO);
		//N
		int qteItem = 0;
		ServiceResult result = null;
		
		if(qte>0) {//QUOTE테이블 insert성공시
			List<QuoteItemVO> quoteItem = quoteVO.getQuoteItem();
			
			for(QuoteItemVO quoteItemVO : quoteItem) {//ex)3회 반복
				quoteItemVO.setQteCd(quoteVO.getQteCd());//selectKet에 의해 채워짐
				//qteCd=Q189, itemCd=dsaf, qteUprc=2.0, qteQty=1.0, 
				qteItem += dao.insertQuoteItem(quoteItemVO);
			}
		}else {
			result = ServiceResult.FAIL;
		}
		
		if(qteItem>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}
	

	@Override
	public ServiceResult modifyQuote(QuoteVO quoteVO) {
		/*
		 QuoteVO(qteNum=0, qteCd=Q237, qteDate=2023-12-04, qteStat=null, comCd=COM033, comNm=기아나, empCd=E202003150101, empNm=황수빈, btbQteCd=null, qteUprc=0, qteQty=0, itemCd=null, company=null, employee=null,quoteItem=[
		 	QuoteItemVO(qteCd=null, itemCd=D014AD002, qteUprc=21.0, qteQty=11.0, 
		 		item=ItemVO(itemCd=null, itemNm=비스나이프에어드레서(5벌), itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null)),
		 	QuoteItemVO(qteCd=null, itemCd=D014AD003, qteUprc=51.0, qteQty=31.0, 
		 		item=ItemVO(itemCd=null, itemNm=비스나이프에어드레서(7벌), itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null)), 
		 	QuoteItemVO(qteCd=null, itemCd=D015VC001, qteUprc=91.0, qteQty=71.0, 
		 		item=ItemVO(itemCd=null, itemNm=무선청소기, itemUnit=null, itemCate=null, itemSafeQty=0, itemYn=null, itemNote=null, itMaker=null, itWght=null, itColor=null, itMdate=null, itemInpr=0, itemOutpr=0, itemBoolean=false, itemQty=0, orderFrag=null, itCateNm=null, itemUprc=null, searchType=null, searchWord=null))])
		 */
		//1
		int qte = dao.updateQuote(quoteVO);
		//N
		int qteItem = 0;
		ServiceResult result = null;
		if(qte>0) {
			dao.deleteQuoteItem(quoteVO);
			
			List<QuoteItemVO> quoteItem = quoteVO.getQuoteItem();
			
			for(QuoteItemVO quoteItemVO : quoteItem) {//ex)3회 반복
				quoteItemVO.setQteCd(quoteVO.getQteCd());//selectKet에 의해 채워짐
				//qteCd=Q189, itemCd=dsaf, qteUprc=2.0, qteQty=1.0, 
				qteItem += dao.insertQuoteItem(quoteItemVO);
			}
		}else {
			result = ServiceResult.FAIL;
		}
		
		if(qteItem>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifyQteStat(QuoteVO quoteVO) {
		int cnt = dao.updateQteStat(quoteVO);
		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
	

