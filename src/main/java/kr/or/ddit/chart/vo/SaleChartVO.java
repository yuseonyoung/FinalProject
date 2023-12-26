package kr.or.ddit.chart.vo;

import java.math.BigDecimal;

import lombok.Data;

/**
 * @author 이수정
 * @since 2023. 12. 06.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 12. 06.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Data
public class SaleChartVO {
	private Integer saleUprc;
	private Integer saleQty;
	private Integer totalSale;
	private BigDecimal saleSum;
	private String itemCd;
	private String saleCd;
	private String saleDate;
	private String saleStat;
	private String comCd;

}
