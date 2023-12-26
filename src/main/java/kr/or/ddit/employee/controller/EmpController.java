package kr.or.ddit.employee.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.vo.EmpVO;

@Controller
@RequestMapping("/empList")
public class EmpController {
	
	@Inject
	private EmpDAO empDAO;
	
	@GetMapping("/list")
	public String empListJSON (Model model) {
		List<EmpVO> empList = empDAO.commEmpList();
		model.addAttribute("empList", empList);
		return "jsonView";
	}

}
