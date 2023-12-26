package kr.or.ddit.common.controller;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.common.service.CommCdService;
import kr.or.ddit.common.vo.CommCdVO;
import kr.or.ddit.common.vo.GrpCdVO;
import kr.or.ddit.security.userdetails.EmpVOwrapper;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 우정범
 * @since 2023. 12. 6.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 12. 6.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Slf4j
@Controller
@RequestMapping("/commCd")
public class CommCdController {
	
	@Inject
	private CommCdService commCdService;
	
	@GetMapping("/groupCdList")
	public ModelAndView groupCodeList(ModelAndView mav) {
		log.info("groupCodeList");

		List<GrpCdVO> codeList = commCdService.groupCodeList();
        mav.addObject("codeList", codeList);
        mav.setViewName("code/groupCdList");

		return mav;
	}

	@GetMapping("/commonCodeList")
	public ModelAndView commCdList(ModelAndView mav, Authentication authentication) {
		log.info("commCdList");

		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();

		List<CommCdVO> codeList = commCdService.commonCodeList();
		List<CommCdVO> codeName = commCdService.commonCodeName();

		for(CommCdVO commCdVO : codeList) {
			String regymdt = commCdVO.getCommRdate();
			String subregymdt = regymdt.substring(0, 10);
			commCdVO.setCommRdate(subregymdt);
		}

		mav.addObject("codeList", codeList);
		mav.addObject("codeName", codeName);
		mav.setViewName("code/commonCodeList");

		return mav;
	}


	@PostMapping("/newCommCd")
	@ResponseBody
	public String maxEmpCd(@RequestParam("grCd") String grCd) {

		String maxEmpCd = commCdService.maxCommonCode(grCd);
		if(maxEmpCd != null) {
			int number = Integer.parseInt(maxEmpCd.substring(2)); // 문자열에서 숫자 부분 추출
			number++; // 1을 더함
			String result = maxEmpCd.substring(0, 2) + String.format("%02d", number);

			return result;
		}else {
			return "";
		}
	}

	@PostMapping("/createCommCd")
	@ResponseBody
	public List<CommCdVO> createCommonCode(@RequestParam("grCd") String grCd, @RequestParam("commCd") String commCd, @RequestParam("empCd") String empCd,
            				@RequestParam("commCdNm") String commCdNm) {
		CommCdVO commCdVO = new CommCdVO();
		commCdVO.setGrCd(grCd);
		commCdVO.setCommCd(commCd);
		commCdVO.setCommCdNm(commCdNm);
		commCdVO.setEmpCd(empCd);

		int cnt = commCdService.createCommonCode(commCdVO);

		List<CommCdVO> codeList = commCdService.commonCodeList();

		return codeList;
	}

	@PostMapping("/codeAct")
	@ResponseBody
	public String accountAct(@RequestParam("commCd") String commCd) {
	    int cnt = 0;

	    cnt = commCdService.codeAct(commCd);

	    return commCd;
	};

}
