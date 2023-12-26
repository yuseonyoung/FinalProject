package kr.or.ddit.chart.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.chart.vo.SaleChartVO;

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

@Mapper
public interface SaleChartDAO {
	
	//월별 매출현황 데이터
	public SaleChartVO saleChart09();

	public SaleChartVO saleChart10();

	public SaleChartVO saleChart11();

	public SaleChartVO saleChart12();
}
