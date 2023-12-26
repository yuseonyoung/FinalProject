package kr.or.ddit.actInven.service;

import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Service;

import kr.or.ddit.actInven.dao.ActInvenDAO;
import kr.or.ddit.actInven.vo.ActInvenItemVO;
import kr.or.ddit.actInven.vo.ActInvenVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.paging.vo.PaginationInfo;

/**
 * <pre>
 * 
 * </pre>
 * @author 최광식
 * @since 2023. 11. 20.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Service
public class ActInvenServiceImpl implements ActInvenService{

	@Inject
	private ActInvenDAO dao;

	@Override
	public void retrieveActInvenList(PaginationInfo<ActInvenVO> paging) {
		int totalRecord = dao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<ActInvenVO> dataList = dao.selecetActInvenList(paging);
		paging.setDataList(dataList);
	}

	@Override
	public ActInvenVO retrieveActInven(String realCd) {
		return dao.selectActInvenView(realCd);
	}

	@Override
	public ServiceResult modifyActInven(@Valid ActInvenVO actInvenVO) {
		
		int cnt = dao.updateActInven(actInvenVO);
		ServiceResult result = null;
			
		if(cnt>0) {
			List<ActInvenItemVO> actIvenItems = actInvenVO.getActIvenItem();
			if(actIvenItems!=null) {
				int itemCnt = 0;
			    for (ActInvenItemVO item : actIvenItems) {
			    	itemCnt = dao.updateActInvenItem(item);
			    }
			    if(itemCnt>0) {
			    	result = ServiceResult.OK;
			    }else {
			    	result = ServiceResult.FAIL;
			    }
			}
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult insertActInven(@Valid ActInvenVO actInvenVO) {

		ServiceResult result = null;
		
		int cnt = dao.insertActInven(actInvenVO);
		
		if(cnt>0) {
			List<ActInvenItemVO> actInvenItems = actInvenVO.getActIvenItem();
			
			if(actInvenItems!=null) {
				int itemCnt = 0;
				for(ActInvenItemVO item : actInvenItems) {
					item.setItemDate(actInvenVO.getRinvDate());
					item.setRealCd(actInvenVO.getRealCd());
					System.out.println("actInvenItems@@@@@@@@@@@"+actInvenItems);
					itemCnt = dao.insertActInvenItem(item);
				}
				if(itemCnt>0) {
					result = ServiceResult.OK;
				}else {
					result = ServiceResult.FAIL;
				}
			}else {
				result = ServiceResult.FAIL;
			}
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
}
