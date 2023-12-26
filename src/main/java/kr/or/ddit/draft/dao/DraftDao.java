package kr.or.ddit.draft.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.draft.vo.DraftFormVO;
import kr.or.ddit.draft.vo.DraftOrderVO;
import kr.or.ddit.draft.vo.DraftVO;
import kr.or.ddit.draft.vo.DraftVacVO;
import kr.or.ddit.empInfo.vo.EmpInfoVO;

/**
 * @author 우정범
 * @since 2023. 11. 15.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 16.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Mapper
public interface DraftDao {

	/**
	 * 사용자 한명의 기안을 올리기 위한 정보를 조회하는 메소드
	 * @param 유저의 아이디
	 * @return 유저 정보
	 */
	public EmpInfoVO selectDraftEmpInfo(String empCd) throws Exception;
	
	/**
	 * 기안 테이블에 기안 정보를 등록
	 * @param draftVO  기안 정보
	 * @return 등록에 성공한 행 수
	 */
	public int insertDraft(DraftVO draftVO) throws Exception;

	/**
	 * 기안 의견 테이블에 기안 정보와 의견을 등록
	 * @param draftVO
	 * @return 등록에 성공한 행 수
	 */
	public int insertDraftOp(DraftVO draftVO) throws Exception;
	
	/**
	 * 휴가문서 기안 시 휴가 테이블에 해당 휴가 사용 이력 등록
	 * @param draftVO 연결된 기안번호와 휴가사용 이력
	 * @return 등록에 성공한 행 수
	 */
	int insertDraftVac(DraftVO draftVO) throws Exception;

	/**
	 * 기안 시 첨부파일 테이블에 첨부파일 등록
	 * @param draftVO 연결된 기안번호와 첨부파일 내용
	 * @return 등록에 성공한 행 수
	 */
	public int insertDraftAtch(DraftVO draftVO) throws Exception;
	
	/**
	 * 기안 시 결재선 테이블에 결재선 등록
	 * @param draftVO 결재자, 수신자, 회람자 등의 결재선 정보
	 * @return 등록에 성공한 행 수
	 */
	public int insertDraftLine(DraftVO draftVO) throws Exception;
	
	/**
	 * 임시/ 완료/ 진행중 등 나의 기안상태에 따른 기안문서 리스트 조회
	 * @param empCd 나 자신
	 * @param drftStat 기안 상태코드
	 * @return
	 */
	public List<DraftVO> selectMyDraftList(@Param("empCd")String empCd, @Param("drftStat")String drftStat);
	
	/**
	 * 기안문서 상세 조회
	 * @param drftNo 기안 문서 번호
	 * @return 기안문서
	 */
	public DraftVO selectDraft(@Param("drftNo")int drftNo);
	
	public int logicalDelDraft(DraftVO draftVO);
	
	public List<DraftVO> myDraftLineList(String empCd);
	
	public List<DraftVO> myDraftSusinList(String empCd);
	
	public List<DraftVO> myDraftRamList(String empCd);
	
	/**
	 * 결재자의 승인 또는 반려와 같은 상태를 업데이트
	 * @param draftVO 결재자ID, 기안번호, 변경할 결재자 상태
	 * @return 1 업데이트 성공, 0 업데이트 실패
	 */
	public int updateDlineStat(DraftVO draftVO) throws Exception;
	
	public int updateDraftStat(DraftVO draftVO) throws Exception;
	
	
	
	
	// 발주서 일련번호 선택
	public List<DraftOrderVO> selectPordCd(); 
	
	// 발주서 상세조회
	public List<DraftOrderVO> selectOrderPlayDetailList(String pordCd);
	
	// 발주서 상태변경
	public int updatePordStat(String pordCd);
	
	
	
	
	
	
	
	public List<DraftFormVO> selectDformList();
	
	public int insertDform(DraftFormVO draftFormVO);

	// 2023.11.17 선생님하고 추가한 기능
	public DraftFormVO selectDform(int dformNo);
}
