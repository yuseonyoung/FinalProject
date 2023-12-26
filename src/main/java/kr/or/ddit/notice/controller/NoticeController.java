package kr.or.ddit.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.notice.vo.NoticeExVO;
import kr.or.ddit.notice.vo.NoticeVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * 
 * </pre>
 * @author 황수빈
 * @since 2023. 11. 20.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      황수빈       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@RequestMapping("/notice")
@Slf4j
@Controller
public class NoticeController {
	
	@Autowired
	private  NoticeService noticeService;

	@GetMapping("/pageCreate")
	public String create() {
		System.out.println("create");
		return "notice/pageCreate";
	}
	
	@PostMapping("/createPost")
public String createPost(Model models,NoticeVO noticeVO,MultipartFile uploadFile) {

		return "redirect:/notice/list?ntcNo=1";
}
	
	/*
	 * @GetMapping("/list") public String list() {
	 * 
	 * 요청URI : /notice/list?keyword=개똥이
	 * 			/notice/list
		요청파라미터 : keyword=개똥이
		요청방식 : get
	 * 
	 * return "notice/list"; }
	 */
	
	@GetMapping("/list")
	public String list4(Model model, 
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage
			) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage+"");
//		map{"keyword":"개똥이"}
		log.info("list4->map : " + map);
		
		
		PaginationInfo<NoticeVO> paging = new PaginationInfo<>(10, 5);
		
		List<NoticeVO> data = noticeService.noticeList(map);
		log.info("list4->data : " + data);
		
		int total = this.noticeService.total(map);
		log.info("list4->total : " + total);
		
		//1) 전체 행 수
		paging.setTotalRecord(total);
		//2) 현재 페이지
		paging.setCurrentPage(currentPage);
		//3) 데이터
		paging.setDataList(data);
		//4) 페이징 렌더링
		paging.setRenderer(new BootstrapPaginationRenderer());		
		
		model.addAttribute("data",paging);
		
		return "notice/list";
	}
	
	@ResponseBody
	 @PostMapping("/list5")
	 public NoticeVO list5(@RequestBody NoticeVO noticeVO) {
	    //LprodVO(lprodId=1, lprodGu=P101, lprodNm=컴퓨터제품)
	    log.info("list5->noticeVO : " + noticeVO);
	    
	    noticeVO = this.noticeService.detail(noticeVO);
	    //lprodVO[lprodId=1,lprodGu=P502,lprodNm=컴퓨터제품]
	    
	    return noticeVO;
	 }
	
	/*요청URI : /notice/pageCreatePost
	  요청파라미터 : {"ntcNm": "E201802180101","ntcTitle": "adf", "ntcCont": "<p>ss</p>\n","uploadFile":"파일객체들"}
	  요청방식 : post
	*/
	@ResponseBody
	@PostMapping("/pageCreatePost")
	public String pageCreatePost(NoticeVO noticeVO) {
		//NoticeVO(ntcNo=null, ntcTitle=제목222, ntcCont=<p>내용22222</p>
		//, ntcRdate=null, ntcHit=0, ntcNm=E201802180101, empNm=null, empAuth=null
		//, uploadFile=[org.springframework.web.multipa..)
		log.info("noticeVO : " + noticeVO);
		
		int result = this.noticeService.pageCreatePost(noticeVO);
		//NoticeVO(ntcNo=NTC0000126, ntcTitle=asfd, ntcCont=<p>sdd</p>
		//, ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		log.info("pageCreatePost->result : " + result);
		
		return noticeVO.getNtcNo();
	}
	
	//요청URI : /notice/pageDetail?ntcNo=NTC0000127
	//상세보기
	@GetMapping("/pageDetail")
	public String pageDetail(Model model,NoticeVO noticeVO) {
		//noticeVO : NoticeVO(ntcNo=null, ntcTitle=asdf, ntcCont=<p>ttt</p>
		//, ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		log.info("pageDetail->noticeVO" + noticeVO);
		
		noticeService.pageUpdateHit(noticeVO); // 요기서 카운트 증가!
		
		model.addAttribute("detail",noticeService.pageDetail(noticeVO));
		
		return "notice/pageDetail";
		
		
		
	}
	
	//목록보기
	@GetMapping("/pageSelect")
	public String pageSelect(Model model,NoticeVO noticeVO) {
		
		log.info("pageSelect->noticevo : " + noticeVO);
		
		return "notice/pageSelect";
	}
	
	//공지사항 수정을 위한 form
	//데이터가 변경x
	@GetMapping("/pageDetailUpdate")
	public String pageDetailUpdate(Model model,NoticeVO noticeVO) {
		//NoticeVO(ntcNo=NTC0000132, ntcTitle=null, ntcCont=null, ntcRdate=null, ntcHit=0, ntcNm=null)
		log.info("detailUpdate->noticeVO : " + noticeVO);
		model.addAttribute("detail",noticeService.pageDetail(noticeVO));
//		int cnt2 = this.noticeService.pageDetailUpdate(noticeVO);
		
		return "notice/detailUpdate";
		
	}
	
	//공지사항 수정 처리
	//데이터가 변경o
	/*NoticeVO(ntcNo=NTC0000127, ntcTitle=개똥이제목3, ntcCont=
	개똥이내용3
	, ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
	*/
	@PostMapping("/pageDetailUpdatePost")
	public String pageDetailUpdatePost(Model model,NoticeVO noticeVO) {
		
		log.info("detailUpdate->noticeVO : " + noticeVO);
		
		int cnt2 = this.noticeService.pageDetailUpdate(noticeVO);
		log.info("cnt2 : " + cnt2);
		
		return "redirect:/notice/pageDetail?ntcNo=" + noticeVO.getNtcNo();
		
	}
	
	@ResponseBody
//	@DeleteMapping("/pageDetailDelete")
	@GetMapping("/pageDetailDelete")
	public String pageDetailDelete(Model model, NoticeVO noticeVO) {
//	public String pageDetailDelete(@RequestBody String ntcNo) {
		
		log.info("pageDetailDelete->noticeVO : " + noticeVO);
//		log.info("pageDetailDelete->ntcNo : " + ntcNo);
//		NoticeVO noticeVO = new NoticeVO();
//		noticeVO.setNtcNo(ntcNo);
		int cnt = this.noticeService.pageDetailDelete(noticeVO);
//		return "notice/pageDetailDelete";

		return String.valueOf(cnt);
	}

	
}


























