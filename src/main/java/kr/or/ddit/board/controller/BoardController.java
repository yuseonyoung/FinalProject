package kr.or.ddit.board.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.notice.vo.NoticeVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 황수빈
 * @since 2023. 11. 20.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      황수빈       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */
@RequestMapping("/board")
@Slf4j
@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@RequestMapping("/create")
	public String create() {
		log.info("brdCreate");
		//forwarding : jsp
		return "board/create";
	}

	/*
	요청URI : /board/createPost
	요청파라미터 : {brdTitle=제목,brdCont=내용}
	요청방식 : post
	
	principal : 로그인 한 사람의 정보
	*/
	@PostMapping("/createPost")
	public String createPost(Model model, BoardVO boardVO, Principal principal) {
		/*
		BoardVO(rnum=0, brdNo=null, brdTitle=asdf, brdCont=<p>sss</p>
		, brdRdate=null, brdHit=0, brdTemp=null, empNm=null, empAuth=null, atchBrdFileDetailVOList=null, uploadFile=[org.sprin
		, brdNm=null
		 */
		log.info("createPost->boardVO : " + boardVO);
		//로그인 아이디
		String brdNm = principal.getName();
		boardVO.setBrdNm(brdNm);//E201802180101
		
		log.info("체킁3: {}", boardVO);
		
		int result = boardService.createPost(boardVO);
		log.info("createPost->result : " + result);

		return "redirect:/board/list";
	}

	/*
	 * @GetMapping("/list") public String list() {
	 * 
	 * 요청URI : /board/list?keyword=개똥이 /board/list 요청파라미터 : keyword=개똥이 요청방식 : get
	 * 
	 * return "board/brdlist"; }
	 */
	@GetMapping("/list")
	public String list(Model model,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage + "");
//		map{"keyword":"개똥이"}
		log.info("list -> map : " + map);

		PaginationInfo<BoardVO> paging = new PaginationInfo<>(10, 5);

		List<BoardVO> data = boardService.boardList(map);
		log.info("list4->data : " + data);

		int total = this.boardService.total(map);
		log.info("list4->total : " + total);

		// 1) 전체 행 수
		paging.setTotalRecord(total);
		// 2) 현재 페이지
		paging.setCurrentPage(currentPage);
		// 3) 데이터
		paging.setDataList(data);
		// 4) 페이징 렌더링
		paging.setRenderer(new BootstrapPaginationRenderer());

		model.addAttribute("data", paging);

		return "board/list";
	}
	
	@ResponseBody
	@GetMapping("/listAjax")
	public List<BoardVO> listAjax(Model model,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage + "");
//		map{"keyword":"개똥이"}
		log.info("list -> map : " + map);

		List<BoardVO> data = boardService.boardList(map);
		log.info("list4->data : " + data);

		return data;
	}

	@ResponseBody
	@PostMapping("/pageCreatePost")
	public BoardVO pageCreatePost(@RequestBody BoardVO boardVO) {
		// NoticeVO(ntcNo=null, ntcTitle=asfd, ntcCont=<p>sdd</p>
		// , ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		log.info("boardVO : " + boardVO);

		int result = this.boardService.pageCreatePost(boardVO);
		// NoticeVO(ntcNo=NTC0000126, ntcTitle=asfd, ntcCont=<p>sdd</p>
		// , ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		log.info("pageCreatePost->result : " + result);

		return boardVO;
	}

	// 요청URI : /board/pageDetail?boardNo=BRD0000001
	// 상세보기
	@GetMapping("/pageDetail")
	public String pageDetail(Model model, BoardVO boardVO) {
		// noticeVO : NoticeVO(ntcNo=null, ntcTitle=asdf, ntcCont=<p>ttt</p>
		// , ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		log.info("pageDetail->boardVO" + boardVO);

		boardService.pageUpdateHit(boardVO); // 요기서 카운트 증가!
		
		boardVO = boardService.pageDetail(boardVO);
		log.info("boardVO : " + boardVO);
		//detail : boardVO
		model.addAttribute("detail", boardVO);

		return "board/pageDetail";

	}
	
	/*
	요청URI : /board/pageDetailAjax
	요청파라미터 : {"brdNo":"BRD0000007"}
	요청방식 : post
	*/
	@ResponseBody
	@PostMapping("/pageDetailAjax")
	public BoardVO pageDetailAjax(@RequestBody BoardVO boardVO) {
		// boardVO : {"brdNo":"BRD0000007"..
		log.info("pageDetailAjax0->boardVO : " + boardVO);
		
		boardService.pageUpdateHit(boardVO); // 1) 요기서 카운트 증가!
		
		//2) 글 상세
		boardVO = boardService.pageDetail(boardVO);
		log.info("pageDetailAjax1->boardVO : " + boardVO);
		
		return boardVO;
		
	}

	// 목록보기
	@GetMapping("/pageSelect")
	public String pageSelect(Model model, BoardVO boardVO) {

		log.info("pageSelect->noticevo : " + boardVO);

		return "board/pageSelect";
	}

	// 이건 수정이다 !!!!!
	
	
	//공지사항 수정을 위한 form
		//데이터가 변경x
		@GetMapping("/pageDetailUpdate")
		public String pageDetailUpdate(Model model,BoardVO boardVO) {
//			BoardVO(rnum=0, brdNo=BRD0000009, brdTitle=h, brdCont=<p>fhg</p>
//			, brdRdate=n
			log.info("detailUpdate->noticeVO : " + boardVO);
			model.addAttribute("detail",boardService.pageDetail(boardVO));
//			int cnt2 = this.noticeService.pageDetailUpdate(noticeVO);
			
			return "notice/detailUpdate";
			
		}
		
		//공지사항 수정 처리
		//데이터가 변경o
		/*NoticeVO(ntcNo=NTC0000127, ntcTitle=개똥이제목3, ntcCont=
		개똥이내용3
		, ntcRdate=null, ntcHit=0, ntcNm=E201802180101)
		*/
		@PostMapping("/pageDetailUpdatePost")
		public String pageDetailUpdatePost(Model model,BoardVO boardVO) {
//			BoardVO(rnum=0, brdNo=BRD0000009, brdTitle=h, brdCont=<p>fhg</p>
//			, brdRdate=n
			log.info("detailUpdate->noticeVO : " + boardVO);
			
			int cnt2 = this.boardService.pageDetailUpdate(boardVO);
			log.info("cnt2 : " + cnt2);
			
			return "redirect:/board/list";
			
		}
		
		//데이터가 변경x
		@PostMapping("/pageDetailDelete")
		public String pageDetailDelete(Model model,BoardVO boardVO) {
//			BoardVO(rnum=0, brdNo=BRD0000009, brdTitle=h, brdCont=<p>fhg</p>
//			, brdRdate=n
			log.info("pageDetailDelete->noticeVO : " + boardVO);
			int cnt = this.boardService.pageDetailDelete(boardVO);
			log.info("pageDetailDelete->cnt : " + cnt);
			
			return "redirect:/board/list";
			
		}
}
















