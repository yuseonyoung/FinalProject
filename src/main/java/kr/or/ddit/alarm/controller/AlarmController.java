package kr.or.ddit.alarm.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.service.AlarmService;
import kr.or.ddit.alarm.vo.AlarmVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 이수정
 * @since 2023. 12. 03.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 12. 03.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Slf4j
@Controller
public class AlarmController {

	@Inject
	private AlarmService service;

	@Inject
	private AlarmDAO dao;
	
	
	/**
	 * 알람을 보내기 위한 메서드
	 * 
	 * @param model
	 * @param authentication
	 * @return alarmVO
	 * 
	 */
	@RequestMapping("/alarm/mail")
	public String mailAlarmList(Model model, Authentication authentication) {
		String empCd = authentication.getName();
		List<AlarmVO> alarmVO = service.retrieveMailAlarmList(empCd);
		log.info("알람empCd : ", empCd);
		log.info("알람alarmVO{}", alarmVO);
		model.addAttribute("alarmVO", alarmVO);
		return "jsonView";
	}

	
	/**
	 * 알람 읽음 체크를 하는 메서드
	 * 
	 * @param model
	 * @return String
	 */
	@PutMapping("/alarm/chk")
	@ResponseBody
	public String mailAlarmChk(Model model) {
		dao.updateAlarmChk();
		return "success";
	}

}
