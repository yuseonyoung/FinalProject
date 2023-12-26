
package kr.or.ddit.sale.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.sale.dao.SaleDAO;
import kr.or.ddit.sale.vo.SaleItemVO;
import kr.or.ddit.sale.vo.SaleVO;
import lombok.extern.slf4j.Slf4j;

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

@Service
public class SaleServiceImpl implements SaleService{
	
	@Inject
	private SaleDAO dao;
	
	@Override
	public List<SaleVO> retrieveSaleList() {
		return dao.selectSaleList();
	}
	
	/**
	 * 견적서코드를 조건으로 품목아이템 목록을 가져오자
	 * @return List<QuoteItemVO>
	 */
	@Override
	public List<QuoteItemVO> getQteItemList(String qteCd){
		return dao.getQteItemList(qteCd);
	}
	

	
	
	
	
	
	@Override
	public SaleVO retrieveSale(String saleCd) {
		return dao.selectSale(saleCd);
	}

	@Override
	public ServiceResult createSale(SaleVO saleVO) {
		//1
		int sale = dao.insertSale(saleVO);
		
		//N
		int saleItem = 0;
		ServiceResult result = null;
		
		if(sale>0) {
			List<SaleItemVO> saleItem2 = saleVO.getSaleItem();
			
			for(SaleItemVO saleItemVO : saleItem2) {//ex)3회 반복
				saleItemVO.setSaleCd(saleVO.getSaleCd());//selectKet에 의해 채워짐
				//qteCd=Q189, itemCd=dsaf, qteUprc=2.0, qteQty=1.0, 
				saleItem += dao.insertSaleItem(saleItemVO);
			}
		
		}else {
			result = ServiceResult.FAIL;
		}
		
		if(saleItem>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifySale(SaleVO saleVO) {
		
		//1
		int sale = dao.updateSale(saleVO);
		//N
		int saleItem = 0;
		ServiceResult result = null;
		if(sale>0) {
			dao.deleteSaleItem(saleVO);
			
			List<SaleItemVO> saleItem2 = saleVO.getSaleItem();
			
			for(SaleItemVO saleItemVO : saleItem2) {//ex)3회 반복
				saleItemVO.setSaleCd(saleVO.getSaleCd());//selectKet에 의해 채워짐
				//qteCd=Q189, itemCd=dsaf, qteUprc=2.0, qteQty=1.0, 
				saleItem += dao.insertSaleItem(saleItemVO);
			}
			
		}else {
			result = ServiceResult.FAIL;
		}
		
		if(saleItem>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
