package kr.or.ddit.empInfo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.empInfo.dao.EmployeeDao;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.empInfo.vo.EmpRegisterVO;
import kr.or.ddit.empInfo.vo.LogRecVO;

/**
 * @author 우정범
 * @since 2023. 11. 23.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 23.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Inject
	EmployeeDao employeeDao;

	@Override
	public List<EmpInfoVO> list() {
		return employeeDao.list();
	}

	@Override
	public EmpInfoVO detail(EmpInfoVO empInfoVO) {
		return employeeDao.detail(empInfoVO);
	}

	@Override
	public EmpInfoVO detailEmp(EmpInfoVO empInfoVO) {
		return employeeDao.detailEmp(empInfoVO);
	}

	@Override
	public int createEmp(EmpRegisterVO empRegisterVO) {
		empRegisterVO.setEmpPw(new BCryptPasswordEncoder().encode("java"));
		return employeeDao.createEmp(empRegisterVO);
	}

	@Override
	public int createEmpInfo(EmpRegisterVO empRegisterVO) {
		return employeeDao.createEmpInfo(empRegisterVO);
	}

	@Override
	@Transactional
	public int update(EmpInfoVO empInfoVO) {
		int cnt = 0;
		cnt += employeeDao.updateEmp(empInfoVO);
		cnt += employeeDao.updateEmpInfo(empInfoVO);
		return cnt;
	}

	@Override
	public String maxEmpCd(String search) {
		return employeeDao.maxEmpCd(search);
	}

	@Override
	public int checkEmail(String email) {
		return employeeDao.checkEmail(email);
	}

	@Override
	public int checkId(String empCd) {
		return employeeDao.checkId(empCd);
	}

	@Override
	public String checkEmlId(String empCd) {
		return employeeDao.checkEmlId(empCd);
	}
	
	/**
	 * 로그인에 관한 로그를 기록한다
	 * @param userLogVO
	 * @return
	 */
	@Override
	public int userLog(LogRecVO logRecVO) {
		return employeeDao.userLog(logRecVO);
	};

	/**
	 * 로그인 성공시 연속 로그인 실패 횟수를 0으로 한다
	 * @param empCd
	 * @return
	 */
	@Override
	public int logSuccessZero(String empCd) {
		return employeeDao.logSuccessZero(empCd);
	};

	/**
	 * 로그인 실패시 실패 횟수를 1증가 시킨다
	 * @param empCd
	 * @return
	 */
	@Override
	public int logFailCntUp(String empCd) {
		return employeeDao.logFailCntUp(empCd);
	};

	/**
	 * 로그인시마다 실패 횟수를 조회한다
	 * @param empCd
	 * @return
	 */
	public int checkCntUp(String empCd) {
		return employeeDao.checkCntUp(empCd);
	};

	/**
	 * 로그인을 시도하는 아이디의 계정 활성화 여부룰 확인한다
	 * @param empCd
	 * @return
	 */
	@Override
	public String checkIdEn(String empCd) {
		return employeeDao.checkIdEn(empCd);
	};
	
	/**
	 * 계정의 활성화 상태를 변경한다
	 * @param empCd
	 * @return
	 */
	@Override
	public int accountAct(String empCd) {
		return employeeDao.accountAct(empCd);
	}
	
	/**
	 * 로그 목록
	 * @return 로그 목록
	 */
	public List<LogRecVO> logList(){
		return employeeDao.logList();
	};

}
