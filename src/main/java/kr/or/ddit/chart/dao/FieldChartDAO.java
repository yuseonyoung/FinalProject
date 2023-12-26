package kr.or.ddit.chart.dao;

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

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.chart.vo.FieldChartVO;

@Mapper
public interface FieldChartDAO {
	//2023년 분기별 데이터
	public FieldChartVO filedChart1();

	public FieldChartVO filedChart2();

	public FieldChartVO filedChart3();

	public FieldChartVO filedChart4();

	//2022년 분기별 데이터
	public FieldChartVO filedChart5();

	public FieldChartVO filedChart6();

	public FieldChartVO filedChart7();

	public FieldChartVO filedChart8();
}
