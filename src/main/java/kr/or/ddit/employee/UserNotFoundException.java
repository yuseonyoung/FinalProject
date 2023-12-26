package kr.or.ddit.employee;

/**
 * 아이디 조회한 사용자가 존재하지 않는 경우
 *
 */
/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일             수정자               수정내용
 * --------        --------    ----------------------
 * 2023. 11. 10.     이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */
public class UserNotFoundException extends RuntimeException {

	// 다른용도로 래핑하는 용도로 사용하지 않겠다
	public UserNotFoundException(String empCd) {
		super(String.format("%s에 해당하는 사용자가 없음", empCd));
	}

}
