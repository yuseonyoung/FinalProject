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
public class FieldChartVO {
	private String defProcCd;
	private String defCd;
	private String itemCd;
	private Integer defQty;
	private Integer sumDefQty;
	private String defProc;
	private String defProcDate;
	private String wareCd;
	private String defNote;
	private String empCd;
	private String secCd;

}
