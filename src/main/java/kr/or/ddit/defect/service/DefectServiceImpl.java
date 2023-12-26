package kr.or.ddit.defect.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.defect.dao.DefectDAO;
import kr.or.ddit.defect.vo.DefectVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.dao.StorageInOutDAO;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 최광식
 * @since 2023. 11. 10.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 10.      최광식       최초작성
 * 2023. 11. 10.      최광식       paging추가
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */
@Service
public class DefectServiceImpl implements DefectService {

	@Inject
	private DefectDAO dao;

	@Inject
	private StorageInOutDAO storageInOutDAO;
	
	@Override
	public void retrieveDefecList(PaginationInfo<DefectVO> paging) {
		int totalRecord = dao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<DefectVO> dataList = dao.selectDefectList(paging);
		paging.setDataList(dataList);
	}

	@Override
	public DefectVO retrieveDefect(String procCd) {
		return dao.selectDefect(procCd);
	}

	@Override
	public ServiceResult createDefect(DefectVO defectVO) {
		int cnt = dao.insertDefect(defectVO);
		ServiceResult result = null;
		if (cnt > 0) {
			int cnt2 = storageInOutDAO.defectItemCorrectionInsert(defectVO);
			if(cnt2 > 0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifyDefect(DefectVO defectVO) {
		int cnt = dao.updateDefect(defectVO);
		ServiceResult result = null;
		if (cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
