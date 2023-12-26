package kr.or.ddit.security;

import java.io.IOException;
import java.net.URLEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import kr.or.ddit.empInfo.service.EmployeeService;
import kr.or.ddit.empInfo.vo.LogRecVO;

/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 29.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Component
public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	@Inject
	EmployeeService employeeService;

	private final Logger log = LoggerFactory.getLogger(this.getClass());
	private String errorMessage;

	// 생성자
	public CustomAuthenticationFailureHandler() {
		// 실패 URL 설정
		setDefaultFailureUrl("/login?error=" + errorMessage);
	}

	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		String empCd = request.getParameter("username");
		String logIp = request.getRemoteAddr();

		LogRecVO logRecVO = new LogRecVO();
		logRecVO.setEmpCd(empCd);
		logRecVO.setLogIp(logIp);
		logRecVO.setLogNat("KR");

		if (exception instanceof BadCredentialsException) {
			errorMessage = "아이디 또는 비밀번호가 맞지 않습니다. 다시 확인해 주세요.";
//				employeeService.logFailCntUp(empCd);
//				employeeService.userLog(logRecVO);
//				if(employeeService.checkCntUp(empCd) == 5){
//					employeeService.accountAct(empCd);
//					errorMessage = errorMessage + "<br> 계정이 잠겼습니다. 관리자에게 문의하십시오";
//				};
//				logRecVO.setLogStat("FAIL");
//				employeeService.userLog(logRecVO);
		} else if (exception instanceof InternalAuthenticationServiceException) {
			errorMessage = "권한이 없습니다. 관리자에게 문의하세요.";
		} else if (exception instanceof UsernameNotFoundException) {
			errorMessage = "계정이 존재하지 않습니다.";
//				logRecVO.setLogStat("NoID");
//				employeeService.userLog(logRecVO);
		} else if (exception instanceof AuthenticationCredentialsNotFoundException) {
			errorMessage = "인증 요청이 거부되었습니다. 관리자에게 문의하세요.";
//				logRecVO.setLogStat("LOCKED");
//				employeeService.userLog(logRecVO);
		} else {
			errorMessage = "알 수 없는 이유로 로그인에 실패하였습니다 관리자에게 문의하세요.";
		}
		errorMessage = URLEncoder.encode(errorMessage, "UTF-8");
		setDefaultFailureUrl("/login?error=true&exception=" + errorMessage);
		super.onAuthenticationFailure(request, response, exception);
	}
}
