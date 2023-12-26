package kr.or.ddit.chart.vo;

import lombok.Data;

/**
 * @author 이수정
 * @since 2023. 12. 08.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 12. 08.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Data
public class OfficeChartVO {
	private String empCd;
	private String pplanCd;
	private String pordCd;
	private String pordDate;
	private String pordStat;
	private String dueDate;
	private String cqteCd;
	private Integer statCount;
}
