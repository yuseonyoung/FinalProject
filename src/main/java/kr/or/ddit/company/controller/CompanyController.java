package kr.or.ddit.company.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.company.dao.CompanyDAO;
import kr.or.ddit.company.vo.CompanyVO;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Inject
	private CompanyDAO companyDAO;

	@GetMapping("/list")
	public String comListJSON (Model model) {
		List<CompanyVO> companyList = companyDAO.commCompanyList();
		model.addAttribute("companyList", companyList);
		return "jsonView";
	}
}




