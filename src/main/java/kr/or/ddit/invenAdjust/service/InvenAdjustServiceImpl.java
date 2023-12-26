package kr.or.ddit.invenAdjust.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.actInven.vo.ActInvenVO;
import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.invenAdjust.dao.InvenAdjustDAO;
import kr.or.ddit.invenAdjust.vo.InvenAdjustVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.dao.StorageDAO;
import kr.or.ddit.storage.dao.StorageInOutDAO;
import kr.or.ddit.storage.vo.ItemWareVO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 최광식
 * @since 2023. 11. 27.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 * 
 */
@Slf4j
@Service
public class InvenAdjustServiceImpl implements InvenAdjustService {

	@Inject
	private InvenAdjustDAO dao;
	
	@Inject
	private StorageInOutDAO storageInOutDAO;

	@Override
	public void retrieveInvenAdjustList(PaginationInfo<ActInvenVO> paging) {
		log.info("@@@Service.paging@@@ : {}", paging);
		List<ActInvenVO> dataList = dao.selectInvenAdjustList(paging);
		paging.setDataList(dataList);
		log.info("@@@Service.dataList@@@ : {}", dataList);

	}

	@Override
	public ServiceResult createIndenAdjust(ActInvenVO actInvenVO) {

		ServiceResult result = null;
		String storRsn = null;

		int cnt = dao.insertInvenAdjust(actInvenVO);
		if(actInvenVO.getErrorQty()>0) {
			storRsn = "C008";
		}else {
			actInvenVO.setErrorQty(actInvenVO.getErrorQty()*-1);
			storRsn = "C009";
		}
		
		actInvenVO.setStorRsn(storRsn);

		if (cnt > 0) {
			int cnt2 = storageInOutDAO.itemCorrectionInsert(actInvenVO);
			log.info("actInvenVO {} : ",actInvenVO);
			if(cnt2 >0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	

	@Override
	public void retrieveInvenItemAll(PaginationInfo<ItemWareVO> paging) {
		int totalRecord = dao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		log.info("@@@Service.paging@@@ : {}", paging);
		List<ItemWareVO> dataList = dao.selectItemInvenAll(paging);
		paging.setDataList(dataList);
		log.info("@@@Service.dataList@@@ : {}", dataList);
	}

	@Override
	public ItemWareVO retrieveItemDetail(ItemWareVO itemWareVO) {
		
		return dao.selectItemDetail(itemWareVO);
	}

}
