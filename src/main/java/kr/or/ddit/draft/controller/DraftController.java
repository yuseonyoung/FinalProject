package kr.or.ddit.draft.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import kr.or.ddit.draft.service.DraftService;
import kr.or.ddit.draft.vo.DraftFormVO;
import kr.or.ddit.draft.vo.DraftOrderVO;
import kr.or.ddit.draft.vo.DraftStatCd;
import kr.or.ddit.draft.vo.DraftVO;
import kr.or.ddit.draft.vo.DraftVacVO;
import kr.or.ddit.empInfo.service.EmpInfoService;
import kr.or.ddit.empInfo.vo.EmpInfoVO;
import kr.or.ddit.util.commcode.service.CommonService;
import lombok.extern.slf4j.Slf4j;


/**
 * @author 우정범
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Controller
@Slf4j
@RequestMapping("/draft")
public class DraftController {
	
    @Inject 
    private DraftService draftService;
    
    @Inject 
    private CommonService commonService;
    
    @Inject
    private EmpInfoService empInfoService;
    
    
    ObjectMapper objectMapper = new ObjectMapper();

	/**
	 * 기안 문서 양식 페이지 이동
	 * @return 기안 문서 양식을 모아둔 페이지
	 */
	@GetMapping("/form")
	public String selectDformList(Model model) {
		
		List<DraftFormVO> draftFormList = draftService.retrieveDformList();
//		
		model.addAttribute("draftFormList", draftFormList);

		return "draft/draft_form";   
	}
	
	@PostMapping("/form/generate")
	public String insertDform(Model model, @RequestBody DraftFormVO draftFormVO) {
		
		int insertDform = draftService.createDform(draftFormVO);
		
		model.addAttribute("insertDform", insertDform);
		
		return "jsonView";
		
	}
	

	/**
	 * 자유 기안 문서
	 * @param model 기본인적사항 등을 페이지에 넘기기 위함
	 * @param principal 로그인한 유저의 ID
	 * @return 자유 기안문서
	 * @throws Exception
	 */
	@GetMapping("/empty")
	public String draftEmptyForm(
			DraftFormVO draftFormVO,
			Model model, Authentication principal) throws Exception {
		DraftFormVO draftForm = draftService.retrieveDform(draftFormVO.getDformNo());
		model.addAttribute("draftForm", draftForm);
		
		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("VU");
		model.addAttribute("selectCommCdList", selectCommCdList);
		
		return "draft/form/emptyForm";
	}	
	
	@GetMapping("/order")
	public String draftOrderForm(
			DraftFormVO draftFormVO,
			Model model, Authentication principal, String pordCd) throws Exception {
		
		List<DraftOrderVO> selectPordCd = draftService.selectPordCd();
		model.addAttribute("selectPordCd", selectPordCd);
		
		
		EmpInfoVO empInfoVO = draftService.retrieveDraftEmpInfo(principal.getName());
		model.addAttribute("empInfoVO", empInfoVO);
		
		/*
		 * DraftFormVO draftForm = draftService.retrieveDform(draftFormVO.getDformNo());
		 * model.addAttribute("draftForm", draftForm);
		 */
		
		return "draft/form/orderForm";
	}

	@GetMapping("/order/{pordCd}")
	@ResponseBody
	public List<DraftOrderVO> orderDetail(@PathVariable String pordCd) {

		List<DraftOrderVO> draftOrderList = draftService.selectOrderPlayDetailList(pordCd);
		
		// draftService.modifyPordStat(pordCd);
		
		return draftOrderList;
	}
	
	/**
	 * 휴가 기안 문서
	 * @param model 사용자의 휴가, 기본인적사항 등을 페이지에 넘기기 위함
	 * @param principal 로그인한 유저의 ID
	 * @return 휴가 기안문서
	 * @throws Exception
	 */
	@GetMapping("/vac")
	public String draftVacForm(Model model, Authentication principal) throws Exception {
		
		EmpInfoVO empInfoVO = draftService.retrieveDraftEmpInfo(principal.getName());
		model.addAttribute("empInfoVO", empInfoVO);
		
		List<DraftVacVO> draftVacVOList = empInfoVO.getDraftVacVOList();
		model.addAttribute("draftVacVOList", draftVacVOList);

		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("X");
		model.addAttribute("selectCommCdList", selectCommCdList);
		
		return "draft/form/vacForm";
	}
	
	/**
	 * 기안 문서 작성 후 기안하기를 통해 기안 정보를 저장
	 * @param principal 로그인한 기안자의 정보
	 * @param draftVO 기안, 휴가, 결재선 등의 데이터
	 * @return 
	 * @throws Exception
	 */
	@PostMapping("/form/post")
	public String createDraft(Authentication principal, @ModelAttribute DraftVO draftVO) throws Exception{
		
		draftVO.setEmpCd(principal.getName());
		log.debug("draftVO 확인하기: " + draftVO);

		draftService.createDraft(draftVO);
		
		return "redirect:/draft/doc?category=during";
	}
	
	/**
	 * 임시 저장 기안 문서 리스트 페이지
	 * @param model 임시저장한 기안 문서의 목록을 전달
	 * @param principal 유저의 아이디
	 * @return 임시 기안 문서 페이지
	 * @throws Exception
	 */
	@GetMapping("/doc/temp")
	public String showMyImsiDraftList(Model model, Authentication principal) throws Exception { 
		
		// 유저아이디
		String empCd = principal.getName();
		
		// 유저 정보
		EmpInfoVO draftEmpInfoVO = draftService.retrieveDraftEmpInfo(empCd);
		
		// 기안 상태 열거형에서 공통 코드 가져오기
		String drftStat = DraftStatCd.valueOf("temp".toUpperCase()).getDraftStatCd();
		
		//선탁한 기안 상태에 해당하는 기안 문서 리스트 가져오기
		List<DraftVO> selectDraftList = draftService.retrieveMyDraftList(empCd, drftStat);
		
		for (DraftVO draftVO : selectDraftList) {
			draftVO.setDrDtForm2();
		}
		
		model.addAttribute("selectDraftList", selectDraftList);
		model.addAttribute("draftEmpInfoVO", draftEmpInfoVO);
		
		return "draft/myimsidraftList";
	}
	
	/**
	 * 설정된 카테고리에 해당되는 기안문서 리스트를 보여줌
	 * @param category 기안형태에 따른 리스트
	 * @param model 문서리스트와 공통 코드를 jsp에 넘기기 위함
	 * @param principal 어떤 사용자인지 특정하기 위함(empCd)
	 * @return 카테고리에 맞는 기안문서 리스트
	 * @throws Exception
	 */
	@GetMapping("/doc")
	public String showMyDraftList(@RequestParam String category, Model model, Authentication principal) throws Exception { 
		
		// 유저아이디
		String empCd = principal.getName();
		
		// 유저 정보
		EmpInfoVO draftEmpInfoVO = draftService.retrieveDraftEmpInfo(empCd);
		
		// 모든 상태의 기안 문서 가져오기로 변경
		String drftStat = "";
		
		//선탁한 기안 상태에 해당하는 기안 문서 리스트 가져오기
		List<DraftVO> selectDraftList = draftService.retrieveMyDraftList(empCd, drftStat);
		
		for (DraftVO draftVO : selectDraftList) {
			draftVO.setDrDtForm2();
		}
		
		model.addAttribute("selectDraftList", selectDraftList);
		model.addAttribute("draftEmpInfoVO", draftEmpInfoVO);
		
		return "draft/mydraftList";
	}
	
	/**
	 * 내 기안문서 상세 보기
	 * @param category 기안 문서의 종류(임시저장, 완료, 기안진행중 등)
	 * @param drNo 상세보기할 기안 문서의 번호
	 * @return
	 * @throws Exception 
	 */
	@GetMapping("/doc/{drftNo}")
	public String showMyDraft(@PathVariable int drftNo, Model model, Authentication principal) throws Exception { 
		String empCd = principal.getName();
		
		DraftVO selectDraft = draftService.retrieveDraft(drftNo);
		
		List<DraftVO> myDraftLineList = draftService.retrieveMyDraftLineList(empCd);

		EmpInfoVO empInfoVO = new EmpInfoVO();
		empInfoVO.setEmpCd(selectDraft.getEmpCd());
		empInfoVO = this.empInfoService.empDetail(empInfoVO);
		
		model.addAttribute("myDraftLineList", myDraftLineList);
		
		model.addAttribute("selectDraft", selectDraft);
		// 기안자의 이미지/ 사인 받아오기
		model.addAttribute("empInfoVO", empInfoVO);
		model.addAttribute("draEmpCd", empCd);
		
		return "draft/mydraft";
	}
	
	
	/**
	 * 사용자의 휴가 정보를 받아오기 위한 AJAX
	 * @param principal 로그인한 유저 아이디
	 * @return 부여받은 휴가 정보를 JSON 형태로로 변환하여 넘겨줌
	 * @throws Exception
	 */
	@PostMapping("/vac/info")
	@ResponseBody
	public String vacInfo(Authentication principal) throws Exception { 
		String userId = principal.getName();
		
		EmpInfoVO empInfoVO = draftService.retrieveDraftEmpInfo(principal.getName());
		List<DraftVacVO> draftVacVOList = empInfoVO.getDraftVacVOList();
		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("X");
		
		Gson gson = new Gson();
		String json = gson.toJson(draftVacVOList);
		return json;
	}
	
	
	/**
	 * 사용자가 사용할 수 있는 휴가의 종류(공통코드관리) 리스트를 받아오는 AJAX
	 * @return 공통코드로 정의해둔 휴가사용방식의 리스트를 JSON 형태로 전달
	 * @throws Exception
	 */
	@PostMapping("/vac/info/CommCd")
	@ResponseBody
	public String vacInfoCommCd() throws Exception { 
		
		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("X");
		Gson gson = new Gson();
		String json = gson.toJson(selectCommCdList);
		return json;
	}
	
	
	
	/**
	 * 결재할 문서 리스트
	 * @param model 결재 문서의 정보, 결재한 사람의 유저 정보
	 * @param principal 로그인 한 사용자의 ID 
	 * @return 결재자로 선택된 문서 리스트 페이지
	 * @throws Exception
	 */
	@GetMapping("/doc/atrz")
	public String MydraftAtrzList(Model model, Authentication principal) throws Exception { 
		String empCd = principal.getName();
		
		// 유저 정보
		List<DraftVO> myDraftLineList = draftService.retrieveMyDraftLineList(empCd);
		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("N");
		
		for (DraftVO draftVO : myDraftLineList) {
			draftVO.setDrDtForm2();
		}
		
		Gson gson = new Gson();
		String json = gson.toJson(myDraftLineList);
		
		String json2 = gson.toJson(selectCommCdList);
		
		model.addAttribute("myDraftLineList", myDraftLineList);
		model.addAttribute("selectCommCdList", json2);
		model.addAttribute("json", json);
		
		return "draft/myAtrzList";
	}
	
	
	/**
	 * 수신 문서 리스트
	 * @param model 결재 문서의 정보, 결재한 사람의 유저 정보
	 * @param principal 로그인 한 사용자의 ID 
	 * @return 결재자로 선택된 문서 리스트 페이지
	 * @throws Exception
	 */
	@GetMapping("/susin")
	public String MydraftSusinList(Model model, Authentication principal) throws Exception { 
		String empCd = principal.getName();
		
		// 유저 정보
		List<DraftVO> myDraftSusinList = draftService.retrieveMyDraftSusinList(empCd);
		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("N");
		
		for (DraftVO draftVO : myDraftSusinList) {
			draftVO.setDrDtForm2();
		}
		
		Gson gson = new Gson();
		String json = gson.toJson(myDraftSusinList);
		
		String json2 = gson.toJson(selectCommCdList);
		
		model.addAttribute("myDraftSusinList", myDraftSusinList);
		model.addAttribute("selectCommCdList", json2);
		model.addAttribute("json", json);
		
		return "draft/mySusinList";
	}
	
	
	/**
	 * 회람 문서 리스트
	 * @param model 결재 문서의 정보, 결재한 사람의 유저 정보
	 * @param principal 로그인 한 사용자의 ID 
	 * @return 결재자로 선택된 문서 리스트 페이지
	 * @throws Exception
	 */
	@GetMapping("/ram")
	public String MydraftRamList(Model model, Authentication principal) throws Exception { 
		String empCd = principal.getName();
		
		// 유저 정보
		List<DraftVO> myDraftRamList = draftService.retrieveMyDraftRamList(empCd);
		List<Map<String, String>> selectCommCdList = commonService.selectCommCdList("N");
		
		for (DraftVO draftVO : myDraftRamList) {
			draftVO.setDrDtForm2();
		}
		
		Gson gson = new Gson();
		String json = gson.toJson(myDraftRamList);
		
		String json2 = gson.toJson(selectCommCdList);
		
		model.addAttribute("myDraftRamList", myDraftRamList);
		model.addAttribute("selectCommCdList", json2);
		model.addAttribute("json", json);
		
		return "draft/myRamList";
	}
	
	
	
	/**
	 * 결재/반려 처리
	 * @param draftVO 결재 코드, 의견, 최종결재일 경우 휴가 처리 등을 위한 자료
	 * @return 결재 목록으로 리다이렉트
	 * @throws Exception
	 */
	@PostMapping("/doc/atrz/post")
	public String draftApprovePost(@ModelAttribute DraftVO draftVO, HttpSession session) throws Exception {
		log.info("dd:{}",draftVO);
		draftService.modifyDlineStat(draftVO);
		log.info("꺼내기:"+ session.getAttribute("pordCd"));
		return "redirect:/draft/doc/atrz";
	}
	
	//draftService.modifyPordStat();

}
