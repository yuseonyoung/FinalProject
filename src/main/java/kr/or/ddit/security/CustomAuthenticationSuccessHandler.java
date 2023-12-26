package kr.or.ddit.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import kr.or.ddit.empInfo.service.EmployeeService;
import kr.or.ddit.empInfo.vo.LogRecVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.security.userdetails.EmpVOwrapper;

/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------          --------    ----------------------
 * 2023. 11. 10.      이수정       최초작성
 * 2023. 12. 05.      우정범        로그관리 추가
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Component
public class CustomAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	public CustomAuthenticationSuccessHandler() {
		super();
		setAlwaysUseDefaultTargetUrl(true);
	}

	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Inject
	EmployeeService employeeService;

	/**
	 * 로그인 성공시 로그기록 및 인증된 사용자 정보를 리턴한다.
	 * 
	 * @param request
	 * @param response
	 * @param authentication
	 * @throws IOException
	 * @throws ServletException
	 */

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		// 로그기록
		String LogIp = request.getRemoteAddr();

		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
		EmpVO empVO = realUser.getRealUser();

		String empCd = empVO.getEmpCd();
		String message = "SUCCESS";

		log.info("LogIp : " + LogIp);

		int result;

		LogRecVO logRecVO = new LogRecVO();
		logRecVO.setEmpCd(empCd);
		logRecVO.setLogIp(LogIp);
		logRecVO.setLogStat(message);
		logRecVO.setLogNat("KR");
		logRecVO.setFailCnt(0);

		// 로그인 성공시 로그기록, 로그인 실패 횟수를 초기화
		employeeService.userLog(logRecVO);
		employeeService.logSuccessZero(empCd);

		// 권한 분리
		boolean isAdmin = authentication.getAuthorities().stream()
				.anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuthority()));

		boolean isOffice = authentication.getAuthorities().stream()
				.anyMatch(auth -> "ROLE_OFFICE".equals(auth.getAuthority()));

		boolean isField = authentication.getAuthorities().stream()
				.anyMatch(auth -> "ROLE_FIELD".equals(auth.getAuthority()));

		String target = null;

		if (isAdmin || isOffice || isField) {
			target = "/";
		} else {
			target = "/login";
			HttpSession session = request.getSession();
			session.setAttribute("message", "권한이 없습니다. 관리자에게 문의하세요.");

		}

		setDefaultTargetUrl(target);
		super.onAuthenticationSuccess(request, response, authentication);
	}
}
