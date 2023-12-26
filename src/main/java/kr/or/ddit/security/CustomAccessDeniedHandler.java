package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;


public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	/* 로그 설정 */
	private final Logger log = LoggerFactory.getLogger(this.getClass());

	/**
	 * 접근거부발생시 처리
	 * @param request
	 * @param response
	 * @param accessDeniedException
	 * @throws IOException
	 * @throws ServletException
	 */
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		// TODO Auto-generated method stub
		log.error("handle");
		log.error("accessDeniedException : " + accessDeniedException);

		response.sendRedirect("/accessError");
	}

}
