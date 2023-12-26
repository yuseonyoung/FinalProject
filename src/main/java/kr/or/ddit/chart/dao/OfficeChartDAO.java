package kr.or.ddit.chart.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.chart.vo.OfficeChartVO;

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

@Mapper
public interface OfficeChartDAO {

	//진행중, 완료, 반려, 진행전 데이터
	public OfficeChartVO officeChartIng();

	public OfficeChartVO officeChartDone();

	public OfficeChartVO officeChartBack();

	public OfficeChartVO officeChartBefore();

}
