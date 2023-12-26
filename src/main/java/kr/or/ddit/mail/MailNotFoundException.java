package kr.or.ddit.mail;

import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

/**
 * @author 이수정
 * @since 2023. 11. 20.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 20.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

public class MailNotFoundException extends ResponseStatusException {

	public MailNotFoundException(HttpStatus status, String reason, Throwable cause) {
		super(status, reason, cause);
	}

	public MailNotFoundException(HttpStatus status, String reason) {
		super(status, reason);
	}

	public MailNotFoundException(HttpStatus status) {
		super(status);
	}

	public MailNotFoundException(int rawStatusCode, String reason, Throwable cause) {
		super(rawStatusCode, reason, cause);
	}

}
