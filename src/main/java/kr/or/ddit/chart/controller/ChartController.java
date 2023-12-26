package kr.or.ddit.chart.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.chart.dao.FieldChartDAO;
import kr.or.ddit.chart.dao.OfficeChartDAO;
import kr.or.ddit.chart.dao.SaleChartDAO;
import kr.or.ddit.chart.vo.FieldChartVO;
import kr.or.ddit.chart.vo.OfficeChartVO;
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
 * 2023. 12. 08.      이수정       field, office 차트에 사용할 dao 주입
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Controller
@RequestMapping("/index.do")
public class ChartController {
	@Inject
	private SaleChartDAO chartDAO;

	@Inject
	private FieldChartDAO fieldDAO;

	@Inject
	private OfficeChartDAO officeDAO;

	@GetMapping
	public String salechart(Model model) {
		
		//saleChart 데이터
		SaleChartVO chart09 = chartDAO.saleChart09();
		SaleChartVO chart10 = chartDAO.saleChart10();
		SaleChartVO chart11 = chartDAO.saleChart11();
		SaleChartVO chart12 = chartDAO.saleChart12();

		model.addAttribute("chart09", chart09);
		model.addAttribute("chart10", chart10);
		model.addAttribute("chart11", chart11);
		model.addAttribute("chart12", chart12);

		//fieldChart 데이터
		FieldChartVO chart1 = fieldDAO.filedChart1();
		FieldChartVO chart2 = fieldDAO.filedChart2();
		FieldChartVO chart3 = fieldDAO.filedChart3();
		FieldChartVO chart4 = fieldDAO.filedChart4();
		FieldChartVO chart5 = fieldDAO.filedChart5();
		FieldChartVO chart6 = fieldDAO.filedChart6();
		FieldChartVO chart7 = fieldDAO.filedChart7();
		FieldChartVO chart8 = fieldDAO.filedChart8();

		model.addAttribute("chart1", chart1);
		model.addAttribute("chart2", chart2);
		model.addAttribute("chart3", chart3);
		model.addAttribute("chart4", chart4);
		model.addAttribute("chart5", chart5);
		model.addAttribute("chart6", chart6);
		model.addAttribute("chart7", chart7);
		model.addAttribute("chart8", chart8);

		//officeChart 데이터
		OfficeChartVO chartBefore = officeDAO.officeChartBefore();
		OfficeChartVO chartIng = officeDAO.officeChartIng();
		OfficeChartVO chartDone = officeDAO.officeChartDone();
		OfficeChartVO chartBack = officeDAO.officeChartBack();

		model.addAttribute("chartBefore", chartBefore);
		model.addAttribute("chartIng", chartIng);
		model.addAttribute("chartDone", chartDone);
		model.addAttribute("chartBack", chartBack);

		return "main/index";
	}

}
