package kr.or.ddit.msg.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.msg.service.MsgService;
import kr.or.ddit.msg.vo.MsgVO;
import kr.or.ddit.security.userdetails.EmpVOwrapper;
import lombok.extern.slf4j.Slf4j;


/**
 * @author 우정범
 * @since 2023. 11. 27.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Slf4j
@RequestMapping("/msg")
@Controller
public class MsgController {
		
	/**
	 * 메세지 보내는 클래스 불러옴
	 */
	@Autowired
	private SimpMessagingTemplate simpleMessagingTemplate;
	
	@Inject
	private MsgService msgService;
	
	@ResponseBody
	@GetMapping("/readAll")
	public String readAll(MsgVO m) {
		this.msgService.readAllUpdate(m);
		return "success";
	}
	
	/**
	 * 종모양 전체 토스트 알람
	 * @param MsgVO m
	 * @return List<MsgVO>
	 */
	@ResponseBody
	@GetMapping("/alarm")
	public List<MsgVO> alarm(MsgVO m){
		return this.msgService.listAlarm(m);
	}
	
	/**
	 * 쪽지 발송시 DB에 저장, 성공여부 보냄
	 * @param MsgVO msg
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/save")
	public String save(MsgVO msg) {
		int result = this.msgService.insert(msg);
		return "success";
	}
	
	/**
	 * 쪽지보내는 페이지
	 * @param MsgVO msg
	 * @param Model model
	 * @return String
	 */
	@GetMapping("/compose")
	public String compose(MsgVO msg, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		EmpVOwrapper realUser = (EmpVOwrapper) auth.getPrincipal();
		String dispatch = realUser.getRealUser().getEmpCd();
		model.addAttribute("dispatch",dispatch);
		model.addAttribute("msg",msg);
		return "msg/compose";
	}
	
	/**
	 * 쪽지함 페이지
	 * @return String
	 */
	@GetMapping("/inbox")
	public String inbox() {
		return "msg/inbox";
	}
	
	/**
	 * 쪽지 발송, 쪽지 발송시 redirect:/msg/inbox로 보냄
	 * @return String
	 * @throws InterruptedException
	 */
	@PostMapping("/send")
	public String send() throws InterruptedException {
		return "redirect:/msg/inbox";
	}
	
	/**
	 * 사용자가 받는 쪽지 내용 페이지
	 * @param MsgVO msg
	 * @param Model model
	 * @return String
	 */
	@GetMapping("/detailReceiver")
	public String detailReceiver(MsgVO msg, Model model) {
		msg = this.msgService.detailReceiver(msg);
		model.addAttribute("msg",msg);
		return "msg/detail";
	}
	
	/**
	 * 사용자가 보낸 쪽지 내용 페이지
	 * @param MsgVO msg
	 * @param Model model
	 * @return String
	 */
	@GetMapping("/detailSender")
	public String detailSender(MsgVO msg, Model model) {
		msg = this.msgService.detailSender(msg);
		model.addAttribute("msg",msg);
		return "msg/detail";
	}
	
	/**
	 * 보낸 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	@ResponseBody
	@PostMapping("/sender")
	public List<MsgVO> sender(MsgVO msg){
		return this.msgService.listSender(msg);
	}
	
	/**
	 * 받은 쪽지함
	 * @param MsgVO msg
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/receiver")
	public List<MsgVO> receiver(MsgVO msg){
		return this.msgService.listReceiver(msg);
	}
	
	/**
	 * 중요 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	@ResponseBody
	@PostMapping("/importMsg")
	public List<MsgVO> MsgImport(MsgVO msg){
		msg.setMsgStat("V005");
		return this.msgService.listReceiver(msg);
	}
	
	/**
	 * 휴지통
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	@ResponseBody
	@PostMapping("/trash")
	public List<MsgVO> trash(MsgVO msg){
		msg.setMsgStat("V003");
		return this.msgService.trash(msg);
	}
	
	/**
	 * 중요 쪽지 설정
	 * @param MsgVO msg
	 * @return String
	 */
	@ResponseBody
	@GetMapping("/importSet")
	public String importSet(MsgVO msg) {
		int result = this.msgService.importMsg(msg);
		return "success";
	}
	
	/**
	 * 휴지통 설정
	 * @param MsgVO msg
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/trashSet")
	public String trashSet(MsgVO msg) {
		int result = this.msgService.trashSet(msg);
		return "success";
	}
	
	/**
	 * 삭제
	 * @param MsgVO msg
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/delete")
	public String delete(MsgVO msg) {
		int result = this.msgService.delete(msg);
		return "success";
	}
	
	/**
	 * 복원하기
	 * @param MsgVO msg
	 * @return String
	 */
	@ResponseBody
	@GetMapping("/restore")
	public String restore(MsgVO msg) {
		int result = this.msgService.restore(msg);
		return "success";
	}
	
}
