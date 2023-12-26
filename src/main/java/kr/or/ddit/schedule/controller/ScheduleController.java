package kr.or.ddit.schedule.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.schedule.service.ScheduleService;
import kr.or.ddit.schedule.vo.ScheduleVO;
import kr.or.ddit.security.userdetails.EmpVOwrapper;
import lombok.extern.slf4j.Slf4j;



/**
 * @author 우정범
 * @since 2023. 11. 18.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 18.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Controller
@Slf4j
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;


	@GetMapping("/list")
	public String scheduleList() {
		log.info("scheduleList");
		return "schedule/list";
	}


	/**
	 * 등록된 일정의 목록을 보여준다.
	 * @param checkedValues 회사,팀,개인으로 구분되는 체크박스의 체크된 항목
	 * @param authentication 로그인된 사용자의 소속회사,팀,개인을 식별하기 위한 인증 정보
	 * @return 체크된 항목(회사,팀,개인 중)에 해당하는 일정 목록
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/list")
	public List<Map<String, Object>> scheduleListPost(@RequestParam("checkedValues") List<String> checkedValues
			,Authentication authentication) throws Exception {
		log.info("scheduleListPost");

		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		HashMap<String, Object> hash = new HashMap<>();

		
		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
	    EmpVO empVO = realUser.getRealUser();
		
		String com = "AIM";
		String empCd = empVO.getEmpCd();
		String deptNo = empVO.getDeptNo();


		for(String schdYn : checkedValues) {
			log.info(schdYn);
			String textColor = "";
			String classNames = "";
			List<ScheduleVO> dataList = scheduleService.listAll(schdYn);
			
			if(schdYn.equals(com)) {
				textColor = "red";
				classNames = "bg-danger-subtle";
			}
			if(schdYn.equals(deptNo)) {
				textColor = "blue";
				classNames = "bg-primary-subtle";
			}
			if(schdYn.equals(empCd)) {
				textColor = "green";
				classNames = "bg-success-subtle";
			}
			log.info(dataList.toString());

			for(ScheduleVO scheduleVO : dataList) {
				hash.put("id", scheduleVO.getSchdNo());
				hash.put("title", scheduleVO.getSchdTitle());
				hash.put("content", scheduleVO.getSchdYn());
				hash.put("start", scheduleVO.getSchdSdate());
				hash.put("end", scheduleVO.getSchdEdate());
				hash.put("textColor", textColor);
				hash.put("classNames", classNames);
				jsonObj = new JSONObject(hash);
				jsonArr.add(jsonObj);
				log.info(hash.toString());
			}

		}

		log.info("jsonArrCheck:{}",jsonArr);
		return jsonArr;
	}




	/**
	 * 일정을 등록한다
	 * @param param 등록하려는 일정의 정보
	 * @param principal 일정 등록자를 식별하기 위한 인증 정보
	 * @return forward:schedule/list
	 * @throws Exception
	 */
	@PostMapping("/registSchdl")
	@Transactional
	@ResponseBody
	public String addEvent(@RequestBody List<Map<String, Object>> param, Principal principal) throws Exception {
		log.info(param.toString());
		

		String empCd = principal.getName();

		int result = 0;


		for(Map<String, Object> list : param) {

			String title = (String) list.get("title");
			String startDateString = (String)list.get("start"); // 시작 시간
			String endDateString = (String)list.get("end"); // 끝나는 시간
			String schdYn = (String)list.get("schdYn");
			String schdCont = (String)list.get("schdCont");

			log.info(startDateString); //String "2023-12-15 16:00"
			log.info(endDateString);   //2023-12-15 19:00

            ScheduleVO scheduleVO = new ScheduleVO();
            scheduleVO.setSchdSdate(startDateString);
            scheduleVO.setSchdEdate(endDateString);
            scheduleVO.setEmpCd(empCd);
            scheduleVO.setSchdTitle(title);
            scheduleVO.setSchdCont(schdCont);
            scheduleVO.setSchdYn(schdYn);

            log.info("ScheduleVO : scheduleVO " + scheduleVO);

            result =  this.scheduleService.registSchd(scheduleVO);

		}

		return "schedule/list";
	}

	/**
	 * 일정 삭제
	 * @param param 삭제하려는 일정 정보
	 * @return forward:schedule/list
	 * @throws Exception
	 */
	@DeleteMapping("/deleteSchdl")
	@ResponseBody
	public String deleteEvent(@RequestBody List<Map<String, Object>> param) throws Exception {

		int result = 0;

		for(Map<String, Object> list : param) {
			String schdNo = (String)list.get("id");
			result = this.scheduleService.deleteSchd(schdNo);
		}
		return "reservation/calendar";
	}


	/**
	 * 일정 시간 변경
	 * @param param 변경하고자 하는 일정 정보
	 * @return forward:schedule/list
	 * @throws Exception
	 */
	@PatchMapping("/updateSchdl")
	@ResponseBody
	public String modifyEvent(@RequestBody List<Map<String, Object>>param) throws Exception {
		log.info("logInfo" + "updateSchdl / modifyEvent");

		int result = 0;

		for(Map<String, Object> list : param) {

			ScheduleVO scheduleVO = new ScheduleVO();

			String start = (String)list.get("start"); // 시작 시간
			String end = (String)list.get("end"); // 끝나는 시간
			String schdlNoStr = (String)list.get("id"); //
			
			String[] partsSt = start.split("T");
			String datePartSt = partsSt[0];
			String timePartSt = partsSt[1].substring(0, 5);

			String[] partsEd = end.split("T");
			String datePartEd = partsEd[0];
			String timePartEd = partsEd[1].substring(0, 5);

			String startDateString = datePartSt + " " + timePartSt;
			String endDateString = datePartEd + " " + timePartEd;

			scheduleVO.setSchdNo(schdlNoStr);
			scheduleVO.setSchdSdate(startDateString);
			scheduleVO.setSchdEdate(endDateString);

			result = this.scheduleService.dragDropUpdate(scheduleVO);
		}


		return "schedule/list";
	}


	/**
	 * 일정 등록 - 풀캘린더의 select옵션을 이용한 간편 등록
	 * @param param 등록하려는 일정 정보
	 * @param principal 등록자를 식별하기 위한 인증 정보
	 * @return forward:schedule/list
	 * @throws Exception
	 */
	@PostMapping("/selectSchdl")
	@Transactional
	@ResponseBody
	public String addEventSelect(@RequestBody List<Map<String, Object>> param, Principal principal) throws Exception {
		log.info("selectSchdl / addEventSelect");

		String empCd = principal.getName();

		int result = 0;

		for(Map<String, Object> list : param) {

			String title = (String) list.get("title");
			String start9 = (String)list.get("start"); // 시작 시간
			String end9 = (String)list.get("end"); // 끝나는 시간

			LocalDateTime dateTimeSt = LocalDateTime.parse(start9, DateTimeFormatter.ISO_DATE_TIME);
			LocalDateTime dateTimeEd = LocalDateTime.parse(end9, DateTimeFormatter.ISO_DATE_TIME);

			LocalDateTime startDt = dateTimeSt.plus(9, ChronoUnit.HOURS);
			LocalDateTime endDt = dateTimeEd.plus(9, ChronoUnit.HOURS);

			String start = startDt.toString();
			String end = endDt.toString();

			String[] partsSt = start.split("T");
			String datePartSt = partsSt[0];
			String timePartSt = partsSt[1].substring(0, 5);

			String[] partsEd = end.split("T");
			String datePartEd = partsEd[0];
			String timePartEd = partsEd[1].substring(0, 5);

			String startDateString = datePartSt + " " + timePartSt;
			String endDateString = datePartEd + " " + timePartEd;

            ScheduleVO scheduleVO = new ScheduleVO();
            scheduleVO.setSchdSdate(startDateString);
            scheduleVO.setSchdEdate(endDateString);
            scheduleVO.setEmpCd(empCd);
            scheduleVO.setSchdTitle(title);
            scheduleVO.setSchdCont("");
            scheduleVO.setSchdYn(empCd);

            log.info("ScheduleVO : scheduleVO " + scheduleVO);

            result =  this.scheduleService.registSchd(scheduleVO);
		}

		return "schedule/list";
	}



	/**
	 * 등록된 일정의 목록 홈화면에 보여준다.
	 * @param checkedValues 회사,팀,개인으로 구분되는 체크박스의 체크된 항목
	 * @param authentication 로그인된 사용자의 소속회사,팀,개인을 식별하기 위한 인증 정보
	 * @return 체크된 항목(회사,부서,개인 중)에 해당하는 일정 목록
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/list2Home")
	public List<Map<String, Object>> scheduleList2Home(@RequestParam("checkedValues") List<String> checkedValues
			,Authentication authentication) throws Exception {
		log.info("scheduleListPost");

		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		HashMap<String, Object> hash = new HashMap<>();

		EmpVOwrapper realUser = (EmpVOwrapper) authentication.getPrincipal();
	    EmpVO empVO = realUser.getRealUser();
		
		String com = "AIM";
		String empCd = empVO.getEmpCd();
		String deptNo = empVO.getDeptNo();

		for(String schdYn : checkedValues) {
			log.info(schdYn);
			String textColor = "";
			String classNames = "";
			List<ScheduleVO> dataList = scheduleService.listAll(schdYn);

			
			if(schdYn.equals(com)) {
				textColor = "red";
				classNames = "bg-danger-subtle";
			}
			if(schdYn.equals(deptNo)) {
				textColor = "blue";
				classNames = "bg-primary-subtle";
			}
			if(schdYn.equals(empCd)) {
				textColor = "green";
				classNames = "bg-success-subtle";
			}

			for(ScheduleVO scheduleVO : dataList) {
				hash.put("id", scheduleVO.getSchdNo());
				hash.put("title", scheduleVO.getSchdTitle());
				hash.put("content", scheduleVO.getSchdCont());
				hash.put("start", scheduleVO.getSchdSdate());
				hash.put("end", scheduleVO.getSchdEdate());
				hash.put("textColor", textColor);
				hash.put("classNames", classNames);
				hash.put("allDay", true);
				jsonObj = new JSONObject(hash);
				jsonArr.add(jsonObj);
			}

		}


		log.info("jsonArrCheck:{}",jsonArr);
		return jsonArr;
	}



}
