package kr.or.ddit.empInfo.service;

import java.util.List;

import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.empInfo.vo.EmpRegisterVO;
import kr.or.ddit.empInfo.vo.LogRecVO;

public interface EmployeeService {

	/**
	 * 기업에 속하는 사용자 목록을 조회한다
	 * @return 사용자 목록
	 */
	public List<EmpInfoVO> list();

	/**
	 * 사용자의 상세 정보를 조회한다
	 * @param EmpInfoVO 조회하려는 사용자
	 * @return 사용자 상세 정보
	 */
	public EmpInfoVO detail(EmpInfoVO empInfoVO);

	/**
	 * 사용자의 권한정보를 포함한 상세 정보를 조회한다
	 * @param EmpInfoVO 조회하려는 사용자
	 * @return 사용자 상세 정보
	 */
	public EmpInfoVO detailEmp(EmpInfoVO empInfoVO);

	/**
	 * 신규 사용자의 계정 정보를 등록한다
	 * @param EmpInfoVO 등록하려는 사용자의 정보
	 * @return
	 */
	public int createEmp(EmpRegisterVO empRegisterVO);

	/**
	 * 신규 사용자의 인사정보를 증록한다
	 * @param EmpInfoVO 등록하려는 사용자의 정보
	 * @return
	 */
	public int createEmpInfo(EmpRegisterVO empRegisterVO);

	/**
	 * 사용자의 계정 정보를 수정한다
	 * @param userVO 수정 대상이 되는 사용자와 그 정보
	 * @return
	 */
	public int update(EmpInfoVO empInfoVO);


	/**
	 * 사용자계정 자동생성을 위해서 해당 조건의 마지막 계정을 조회한다
	 * @param search 신규 사용자의 입사연월
	 * @return
	 */
	public String maxEmpCd(String search);

	/**
	 * 신규 생성 또는 정보 수정시 이메일 중복 여부를 조회한다
	 * @param email 입력된 이메일 주소
	 * @return
	 */
	public int checkEmail(String email);

	/**
	 * 입력된 계정의 이메일 주소를 조회한다
	 * @param empCd
	 * @return 이메일 주소
	 */
	public String checkEmlId(String empCd);
	
	/**
	 * 로그인에 관한 로그를 기록한다
	 * @param LogRecVO
	 * @return
	 */
	public int userLog(LogRecVO logRecVO);

	/**
	 * 로그인 성공시 연속 로그인 실패 횟수를 0으로 한다
	 * @param empCd
	 * @return
	 */
	public int logSuccessZero(String empCd);

	/**
	 * 로그인 실패시 실패 횟수를 1증가 시킨다
	 * @param empCd
	 * @return
	 */
	public int logFailCntUp(String empCd);

	/**
	 * 로그인시마다 실패 횟수를 조회한다
	 * @param empCd
	 * @return
	 */
	public int checkCntUp(String empCd);

	/**
	 * 로그인을 시도하는 아이디의 존재 유무를 확인한다
	 * @param empCd
	 * @return
	 */
	public int checkId(String empCd);

	/**
	 * 로그인을 시도하는 아디의 계정 활성화 여부룰 확인한다
	 * @param empCd
	 * @return
	 */
	public String checkIdEn(String empCd);
	
	/**
	 * 계정의 활성화 상태를 변경한다
	 * @param empCd
	 * @return
	 */
	public int accountAct(String empCd);
	
	/**
	 * 로그 목록
	 * @return 로그 목록
	 */
	public List<LogRecVO> logList();
}
