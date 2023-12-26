package kr.or.ddit.organization.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.organization.service.OrganizationService;
import kr.or.ddit.organization.service.OrganizationServiceImpl;
import kr.or.ddit.organization.vo.OrganizationVO;

/**
 * @author 우정범
 * @since 2023. 11. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 9.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Controller
@RequestMapping("/organization")
public class OrganizationController {
	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Inject
	OrganizationService organizationService;

	@GetMapping("/list")
	public String list(Model model, Authentication authentication) throws JsonProcessingException {
		log.info("NTHNTHlist");
		List<OrganizationVO> data = this.organizationService.list();
		log.info("list=>data : " + data);

		List<Map<String, Object>> nodes = new ArrayList<>();
		for (OrganizationVO vo : data) {
			Map<String, Object> node = new HashMap<>();
			node.put("child", vo.getEmpNm()); // 자식: 부서원
			node.put("parent", vo.getDeptNm()); // 부모: 부서이름
			nodes.add(node);
		}

		ObjectMapper objectMapper = new ObjectMapper();
		String tree = objectMapper.writeValueAsString(nodes); // json 형태로 변환
		model.addAttribute("tree", tree);
		log.info("tree check : " + tree);

		return "organization/list";

	}

	// tree에 사원 정보 가져오기
	@ResponseBody
	@PostMapping("/jsonList")
	public String jsonList(Authentication authentication) throws JsonProcessingException {
		log.info("NTHNTHjsonList");
		List<OrganizationVO> data = this.organizationService.list();
		log.info("list=>data : " + data);

		List<Map<String, Object>> nodes = new ArrayList<>();
		for (OrganizationVO vo : data) {
			Map<String, Object> node = new HashMap<>();
			log.debug(vo.toString());
			node.put("child", vo.getEmpNm()); // tree 자식: 부서원
			node.put("parent", vo.getDeptNm()); // tree 부모: 부서이름
			node.put("id", vo.getEmpCd());
			node.put("name", vo.getEmpNm());
			node.put("tel", vo.getEmpTelNo());
			node.put("email", vo.getEmpMail());
			node.put("cmail", vo.getEmpCmail());
			node.put("img", vo.getEmpImg());
			node.put("dept", vo.getDeptNm());
			node.put("grade", vo.getHrGradeNm());   //직급
//			log.debug(node.toString());
			nodes.add(node);
			
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		log.info("테스트" + objectMapper.writeValueAsString(nodes));
		
		return objectMapper.writeValueAsString(nodes); // json 형태로 변환
	}
	

}







