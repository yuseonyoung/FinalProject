package kr.or.ddit.empInfo.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.empInfo.service.EmployeeService;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.empInfo.vo.EmpRegisterVO;
import kr.or.ddit.empInfo.vo.LogRecVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.security.userdetails.EmpVOwrapper;
import kr.or.ddit.util.GroubUtils;
import kr.or.ddit.util.commcode.service.CommonService;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 우정범
 * @since 2023. 11. 23.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 23.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Slf4j
@Controller
@RequestMapping("/emp")
public class EmployeeController {

	@Inject
	CommonService  commonService;

	@Inject
	EmployeeService employeeService;
	
	/**
	 * 직원의 등록 정보를 확인한다.
	 * @param mav 화면모델
	 * @param empCd 확인하고자 하는 직원 특정
	 * @return forward:/emp/detail
	 */
	@GetMapping("/detail/{empCd}")
	public ModelAndView accountDetail(ModelAndView mav, @PathVariable String empCd) {
		log.info("emp/accountList Get");
		mav.setViewName("emp/detail");

		EmpInfoVO empInfoVO = new EmpInfoVO();
		empInfoVO.setEmpCd(empCd);
		empInfoVO = employeeService.detailEmp(empInfoVO);
		mav.addObject("empInfoVO", empInfoVO);
		return mav;
	}

	/**
	 * 직원의 등록 정보를 수정하기 위한 창을 표시한다.
	 * @param mav 화면모델
	 * @param empCd 직원 특정
	 * @param  기업 특정
	 * @return forward:/emp/update
	 */
	@GetMapping("/update/{empCd}")
	public ModelAndView accountUpdate(ModelAndView mav, @PathVariable String empCd) {
		log.info("emp/accountList Get");
		mav.setViewName("emp/update");

		EmpInfoVO empInfoVO = new EmpInfoVO();
		empInfoVO.setEmpCd(empCd);
		empInfoVO = employeeService.detailEmp(empInfoVO);

		List<Map<String, String>> gradeList = commonService.selectCommCdList("H");
		List<Map<String, String>> chargeList = commonService.selectCommCdList("U");
		List<Map<String, String>> deptList = commonService.selectDeptNoList();
		List<Map<String, String>> milList = commonService.selectCommCdList("K");

		mav.addObject("empInfoVO", empInfoVO);
        mav.addObject("gradeList", gradeList);
        mav.addObject("chargeList", chargeList);
        mav.addObject("deptList", deptList);
        mav.addObject("milList", milList);

		return mav;
	}

	/**
	 * 직원의 등록 정보를 수정한다.
	 * @param empInfoVO 직원의 수정정보
	 * @return redirect:/emp/detail/{empCd}
	 */
	@PostMapping(value="/update", consumes="application/x-www-form-urlencoded")
	@Transactional
	public String accountUpdatePost(@ModelAttribute("empInfoVO") EmpInfoVO empInfoVO) {
		log.info("emp/update Post");
		
		int cnt = employeeService.update(empInfoVO);
		log.info("emp/update Post update :" + cnt);
		String empCd = empInfoVO.getEmpCd();
		String url = "redirect: detail/"+empCd;

		return url;
	};

	/**
	 * 직원의 목록과 그 정보를 표출한다.
	 * @param mav 화면모델
	 * @param principal 로그인된 회원 정보로 소속 기업을 확인
	 * @return forward:/emp/list
	 */
	@GetMapping("/selectList")
	public ModelAndView accountList(ModelAndView mav, Authentication principal) {
		log.info("emp/accountList Get");

		String empCd = principal.getName();

		List<EmpInfoVO> empSelectList = employeeService.list();

        mav.addObject("empSelectList", empSelectList);
        mav.setViewName("emp/selectList");

		return mav;
	}

	/**
	 * 직원의 생성 정보를 입력받는다.
	 * @param mav 화면모델
	 * @param principal 로그인된 회원 정보로 소속 기업을 확인
	 * @return forward:/emp/create
	 */
	@GetMapping("/create")
	public ModelAndView accountCreate(ModelAndView mav, Authentication principal) {
		log.info("emp/create Get");
		mav.setViewName("emp/create");

		String empCd = principal.getName();


		List<Map<String, String>> gradeList = commonService.selectCommCdList("H");
		List<Map<String, String>> chargeList = commonService.selectCommCdList("U");
		List<Map<String, String>> deptList = commonService.selectDeptNoList();
		List<Map<String, String>> milList = commonService.selectCommCdList("K");


        mav.addObject("gradeList", gradeList);
        mav.addObject("chargeList", chargeList);
        mav.addObject("deptList", deptList);
        mav.addObject("milList", milList);

		return mav;
	};

	/**
	 * 직원의 생성 정보를 입력받는다.
	 * @param mav 화면모델
	 * @param principal 로그인된 회원 정보로 소속 기업을 확인
	 * @return forward:/emp/create
	 */
	@GetMapping("/create2")
	public ModelAndView accountCreate2(ModelAndView mav, Authentication principal) {
		log.info("emp/create Get");
		mav.setViewName("emp/create2");

		List<Map<String, String>> gradeList = commonService.selectCommCdList("H");
		List<Map<String, String>> chargeList = commonService.selectCommCdList("U");
		List<Map<String, String>> deptList = commonService.selectDeptNoList();
		List<Map<String, String>> milList = commonService.selectCommCdList("K");


		mav.addObject("gradeList", gradeList);
		mav.addObject("chargeList", chargeList);
		mav.addObject("deptList", deptList);
		mav.addObject("milList", milList);

		return mav;
	};

	/**
	 * 직원의 생성정보를 바탕으로 신규 계정을 생성하고 권한을 부여한다.
	 * @param empInfoVO 직원의 생성정보
	 * @return redirect:/emp/detail/{empCd}
	 */
	@Transactional
	@PostMapping(value="/create",consumes="application/x-www-form-urlencoded")
	public String accountCreatePost(@ModelAttribute("empRegisterVO") EmpRegisterVO empRegisterVO) {
		log.info("emp/create Post");

		String empCd = empRegisterVO.getEmpCd();

		employeeService.createEmp(empRegisterVO);
		employeeService.createEmpInfo(empRegisterVO);
		
		
		String url = "redirect: detail/"+empCd;

		return url;
	};

	/**
	 * 입사연월에 따라 empCd를 자동 생성하여 준다.
	 * @param search 검색조건
	 * @param yearMonth 입사연월
	 * @return 조건에 근거하여 생성될 empCd 값
	 */
	@PostMapping("/maxEmpCd")
	@ResponseBody
	public String maxEmpCd(@RequestParam("search") String search, @RequestParam("yearMonth") String yearMonth) {
		log.info("emp/maxEmpCd Post Ajax");

		String maxEmpCd = employeeService.maxEmpCd(search);
		String newEmpCd = "";

		if (maxEmpCd == null) {
		    newEmpCd = yearMonth + "0001";
		    log.info("newEmpCd: " + newEmpCd);
		} else {
		    String numberPart = maxEmpCd.substring(maxEmpCd.length() - 4); // 마지막 4자리 숫자 부분을 가져옴
		    int number = Integer.parseInt(numberPart);
		    number++;
		    
		    // 숫자 부분을 증가시킨 후, 다시 문자열로 변환하여 newEmpCd에 할당
		    newEmpCd = maxEmpCd.substring(0, maxEmpCd.length() - 4) + String.format("%04d", number);
		    log.info("newEmpCd: " + newEmpCd);
		}

		return newEmpCd;
	}

	/**
	 * 직원 이메일 정보 입력시 기존 이메일과의 중복 여부를 검사한다.
	 * @param email 입력받은 이메일 정보
	 * @return 사용가능 결과 메시지
	 */
	@PostMapping("/checkEmail")
	@ResponseBody
	public String maxEmpCd(@RequestParam("email") String email) {
	    int cnt = 0;
	    String message = null;

	    cnt = employeeService.checkEmail(email);

	    if(cnt==0) {//사용할 수 있다.
	        message = "success";
	    }else {//사용할 수 없다.
	        message ="fail";
	    }
	    return message;
	}
	
	@GetMapping("/logList")
	public String logList(Model model, Authentication authentication) {

		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();

		List<LogRecVO> logList = employeeService.logList();
		for(LogRecVO logRegVO : logList) {
			String logTime = GroubUtils.yearToString2(logRegVO.getLogDate());
			logRegVO.setLogTime(logTime);
		}

		model.addAttribute("logList", logList);

		return "log/logList";
	}


}
