package kr.or.ddit.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.security.userdetails.EmpVOwrapper;

/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                   수정자               수정내용
 * --------    			 --------    ----------------------
 * 2023. 11. 10.   		  이수정       		 최초작성
 * 2023. 11. 13.   		  이수정       		 updatePw추가
 * 2023. 11. 14.   		  이수정       		 selectEmpList추가
 * 2023. 11. 14.   		  이수정       		 updatetEmp추가
 * 2023. 11. 27.   		  우정범       		 detailUserAuth, detail추가
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */


@Mapper
public interface EmpDAO extends UserDetailsService {
	@Override
	default UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		EmpVO emp = selectEmp(username);
		if (emp == null)
			throw new UsernameNotFoundException(username + "해당 사용자 없음.");
		return new EmpVOwrapper(emp);
	}

	/**
	 * 로그인한 계정의 emp정보 조회
	 * 
	 * @param empCd
	 * @return emp
	 */
	public EmpVO selectEmp(@Param("empCd") String empCd);

	/**
	 * 모든 사원 정보 조회
	 * 
	 * @return
	 */
	public List<EmpVO> selectEmpList();

	public int selectTotalRecord(PaginationInfo<EmpVO> paging);

	public List<EmpVO> selectEmployeeList(PaginationInfo<EmpVO> paging);

	/**
	 * 
	 * 담당자 조회시 사용할 공통코드
	 * 
	 * @return
	 */
	public List<EmpVO> commEmpList();

	/**
	 * 계정 등록
	 * 
	 * @param emp
	 * @return 등록성공 ( >= 1)
	 */
	public int insertEmp(EmpVO emp);

	/**
	 * 계정 수정
	 * 
	 * @param emp
	 * @return수정성공 ( >= 1)
	 */
	public int updateEmp(EmpVO emp);

	/**
	 * 비밀번호 찾기 시 새로운 비밀번호 부여
	 * 
	 * @param vo
	 * @return 수정성공 ( >= 1)
	 * @throws Exception
	 */
	public int updatePw(EmpVO vo) throws Exception;

	/**
	 * 비밀번호 찾기 시 아이디 체크
	 * 
	 * @param empCd
	 * @return 존재하지 않으면, null 반환
	 */
	public Object idCheck(String empCd);

	/**
	 * 신규 사원 등록(권한, 패스워드, 사용여부가 없는 사원들)
	 * 
	 * @return
	 */
	public List<EmpVO> newEmpList();

	/**
	 * 사용자의 상세 정보를 조회한다
	 * 
	 * @param userVO 조회하려는 사용자
	 * @return 사용자 상세 정보
	 */
	public EmpVO detail(EmpVO empVO);

	/**
	 * 사용자의 권한정보를 포함한 상세 정보를 조회한다
	 * 
	 * @param userVO 조회하려는 사용자
	 * @return 사용자 상세 정보
	 */
	public EmpVO detailUserAuth(EmpVO empVO);

	/**
	 * 사원 이름 조회
	 * 
	 * @param empCd
	 * @return
	 */
	public String getName(String empCd);

}
