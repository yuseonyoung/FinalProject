package kr.or.ddit.employee.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.paging.vo.PaginationInfo;

/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일          	  수정자               수정내용
 * --------     	--------    ----------------------
 * 2023. 11. 10.      이수정       최초작성
 * 2023. 11. 14.      이수정       sendEmail 추가
 * 2023. 11. 15.      이수정       retrieveEmpList, updateEmp 추가
 * 2023. 11. 27.   	  우정범       detailUserAuth, detail추가
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */
public interface EmpService {

	/**
	 * 로그인한 계정의 emp정보 조회
	 * 
	 * @param empCd
	 * @return
	 */
	public EmpVO retrieveEmp(String empCd);

	/**
	 * 모든 사원 정보 조회
	 * 
	 * @return
	 */
	public List<EmpVO> retrieveEmpList(PaginationInfo<EmpVO> paging);

	public List<EmpVO> retrieveEmpMList();

	/**
	 * 비밀번호 부여, 권한 부여, 사용여부 변경
	 * 
	 * @param emp
	 * @return OK,FAIL
	 * @throws Exception
	 */
	public ServiceResult createEmp(EmpVO emp) throws Exception;

	/**
	 * 비밀번호 찾기
	 * 
	 * @param vo
	 * @param div
	 * @throws Exception
	 */
	public void sendEmail(EmpVO vo) throws Exception;

	/**
	 * 비밀번호 찾기
	 * 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public String findPw(EmpVO vo) throws Exception;

	public ServiceResult updateEmp(EmpVO emp);

	/**
	 * 신규 사원등록(권한, 사용여부, 패스워드가 없는 사원)
	 * 
	 * @return 권한, 사용여부, 패스워드가 없는 사원 목록
	 */
	public List<EmpVO> newEmpList();

	/**
	 * 사용자의 상세 정보를 조회한다
	 * 
	 * @param empVO 조회하려는 사용자
	 * @return 사용자 상세 정보
	 */
	public EmpVO detail(EmpVO empVO);

	/**
	 * 사용자의 권한정보를 포함한 상세 정보를 조회한다
	 * 
	 * @param empVO 조회하려는 사용자
	 * @return 사용자 상세 정보
	 */
	public EmpVO detailUserAuth(EmpVO empVO);

}
