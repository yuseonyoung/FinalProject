package kr.or.ddit.defect.service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.defect.vo.DefectVO;
import kr.or.ddit.paging.vo.PaginationInfo;

/**
 * <pre>
 * 
 * </pre>
 * @author 최광식
 * @since 2023. 11. 10.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 10.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
public interface DefectService {
	
	/**
	 * 
	 * 불량품목 전체 리스트 조회
	 * @return List<DefectVO>
	 */
	public void retrieveDefecList(PaginationInfo<DefectVO> paging);
	
	/**
	 * 한 불량품목 조회
	 * @param procCd
	 * @return
	 */
	public DefectVO retrieveDefect(String procCd);

	/**
	 * 불량품목 입력
	 * @param defectVO
	 * @return
	 */
	public ServiceResult createDefect(DefectVO defectVO);

	/**
	 * 하나의 불량품목 수정
	 * @param defectVO
	 * @return
	 */
	public ServiceResult modifyDefect(DefectVO defectVO);
	
}
