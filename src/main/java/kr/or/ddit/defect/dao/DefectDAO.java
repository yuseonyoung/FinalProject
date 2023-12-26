package kr.or.ddit.defect.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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
@Mapper
public interface DefectDAO{
	
	/**
	 * 페이징 처리 기반의 불량품목 전체 조회
	 * @return
	 */
	public List<DefectVO> selectDefectList(PaginationInfo<DefectVO> paging);
	
	/**
	 * 불량품목 상세조회
	 * @param prodCd
	 * @return
	 */
	public DefectVO selectDefect(String procCd);

	/**
	 * 불량품목 입력
	 * @param defectVO
	 * @return
	 */
	public int insertDefect(DefectVO defectVO);

	/**
	 * 불량품목 수정
	 * @param defectVO
	 * @return
	 */
	public int updateDefect(DefectVO defectVO);

	/**
	 * totalRecord 조회
	 * @param paging
	 * @return
	 */
	public int selectTotalRecord(PaginationInfo<DefectVO> paging);

}
