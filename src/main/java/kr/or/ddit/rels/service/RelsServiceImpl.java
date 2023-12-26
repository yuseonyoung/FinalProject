package kr.or.ddit.rels.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.quote.vo.QuoteItemVO;
import kr.or.ddit.rels.dao.RelsDAO;
import kr.or.ddit.rels.vo.RelsItemVO;
import kr.or.ddit.rels.vo.RelsVO;
import kr.or.ddit.sale.vo.SaleItemVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      김도현      최초작성
 * 2023. 11. 21. 	  김도현		조회, 등록, 수정작성
 * 2023. 11. 24.      김도현		등록, 수정 Map으로 변경
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Service
public class RelsServiceImpl implements RelsService{

	@Inject
	private RelsDAO dao;
	
	@Override
	public List<RelsVO> retrieveRelsList() {
		return dao.selectRelsList();
	}

	/**
	 * 판매코드를 조건으로 품목아이템 목록을 가져오자
	 * @return List<SaleItemVO>
	 */
	
	@Override
	public List<SaleItemVO> getSaleItemList(String saleCd){
		return dao.getSaleItemList(saleCd);
	}
	
	
	@Override
	public RelsVO retrieveRels(String relsCd) {
		return dao.selectRels(relsCd);
	}

	@Override
	public ServiceResult createRels(RelsVO relsVO) {
		//1
		int rels = dao.insertRels(relsVO);
		
		//N
		int relsItem = 0;
		ServiceResult result = null;
		
		if(rels>0) {
			List<RelsItemVO> relsItem2 = relsVO.getRelsItem();
			
			for(RelsItemVO relsItemVO : relsItem2) {//ex)3회 반복
				relsItemVO.setRdrecCd(relsVO.getRdrecCd());//selectKet에 의해 채워짐
				//qteCd=Q189, itemCd=dsaf, qteUprc=2.0, qteQty=1.0, 
				relsItem += dao.insertRelsItem(relsItemVO);
			}
			
		}else {
			result = ServiceResult.FAIL;
		}
		if(relsItem>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifyRels(RelsVO relsVO) {
		//1
		int rels = dao.updateRels(relsVO);
		//N
		int relsItem = 0;
		ServiceResult result = null;
		if(rels>0) {
			dao.deleteRelsItem(relsVO);
			
			List<RelsItemVO> relsItem2 = relsVO.getRelsItem();
			
			for(RelsItemVO relsItemVO : relsItem2) {//ex)3회 반복
				relsItemVO.setRdrecCd(relsVO.getRdrecCd());//selectKet에 의해 채워짐
				//qteCd=Q189, itemCd=dsaf, qteUprc=2.0, qteQty=1.0, 
				relsItem += dao.insertRelsItem(relsItemVO);
			}
			
		}else {
			result = ServiceResult.FAIL;
		}
		if(relsItem>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
}


