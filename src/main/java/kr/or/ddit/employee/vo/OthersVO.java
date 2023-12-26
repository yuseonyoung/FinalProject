package kr.or.ddit.employee.vo;

import lombok.Data;

/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자            수정내용
 * --------        --------    ----------------------
 * 2023. 11. 10.      이수정           최초작성
 * 2023. 11. 16.      이수정         commCdNm추가
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */
@Data
public class OthersVO {
	private String authCd;
	private String empCd;
	private String commCdNm;
}
