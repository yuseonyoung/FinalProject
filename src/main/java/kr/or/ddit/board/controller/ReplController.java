package kr.or.ddit.board.controller;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.service.ReplService;
import kr.or.ddit.board.vo.ReplVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/repl")
@Controller
public class ReplController {
	
	@Autowired
	ReplService replService;
	private int replNo;
	
	@ResponseBody
	@PostMapping("/replList")
	public List<ReplVO> replList(@RequestBody ReplVO replVO) {
		log.info("replVO : " + replVO);
		
		List<ReplVO> rdata = replService.replList(replVO);
		log.info("list->data : " + rdata);
				
		return rdata;
	}
	
	@ResponseBody
	@PostMapping("/replSelect")
	public ReplVO replSelect(@RequestBody ReplVO replVO) {
		log.info("replVO : " + replVO);
		
		return replService.replSelect(replVO);
	}
	
	@RequestMapping("/create")
	public String create() {
		log.info("replCreate");
		return "repl/create";
	}
	
	//댓글 입력
	@PostMapping("/createPost")
	@ResponseBody
	public ReplVO createPost(@RequestBody ReplVO replVO) {
		//createPost-> replVO :ReplVO(replNo=0, empCd=2013020001, replCont=메리 크리스마스, replRdate=null, replMdate=null, brdNo=BRD0000007)
		log.info("createPost-> replVO : " + replVO);
		
		int result = replService.createPost(replVO);
		log.info("createPost->result : " + result);
		
		return replVO;
	}
	
	
	//댓글 입력
	@ResponseBody
	@PostMapping("/updatePost")
	public ReplVO updatePost(@RequestBody ReplVO replVO) {
		//ReplVO(replNo=1, empCd=null, replCont=제니!!블랙핑크!!fsda, replRdate=null, replMdate=null, brdNo=null)
		log.info("createPost-> replVO : " + replVO);
		
		int result = replService.updatePost(replVO);
		log.info("updatePost->result : " + result);
		
		return replVO;
	}
	//댓글 삭제
	@ResponseBody
	@PostMapping("/deletePost")
	public String deletePost(@RequestBody ReplVO replVO) {
		//ReplVO(replNo=1, empCd=null, replCont=제니!!블랙핑크!!fsda, replRdate=null, replMdate=null, brdNo=null)
		log.info("deletePost-> replVO : " + replVO);
		
		int result = replService.deletePost(replVO);
		log.info("deletePost->result : " + result);
		
		String sbRslt = "NG";
		if(result == 1) {
			sbRslt = "OK";
		}
		
		return sbRslt;
	}
	
	
}





