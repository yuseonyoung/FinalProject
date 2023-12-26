package kr.or.ddit.mail.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.employee.dao.EmpDAO;
import kr.or.ddit.employee.service.EmpService;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.mail.service.MailService;
import kr.or.ddit.mail.vo.AttatchVO;
import kr.or.ddit.mail.vo.MailVO;
import kr.or.ddit.paging.BootstrapPaginationRenderer;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.paging.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 이수정
 * @since 2023. 11. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 15.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

@Slf4j
@Controller
@RequestMapping("/mail")
public class MailController {
	
	@Inject
	private MailService service;
	@Inject
	private EmpService empService;
	
	@Inject
	private EmpDAO empDAO;
	
	@GetMapping("/list")
	public String mailListRetrieve() throws Exception {
		return "mail/mailList";
	}
	

	/**
	 * 받은메일 목록 조회
	 * 
	 * @param principal
	 * @param searchVO
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/list2")
	public String mailListRetrieve(Authentication principal, @ModelAttribute("simpleCondition") SearchVO searchVO,
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord, Model model)
			throws Exception {

		String empCd = principal.getName();
		PaginationInfo<MailVO> paging = new PaginationInfo<>(5, 3);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(searchVO);
		paging.setCurrentPage(currentPage);
		paging.setEmpCd(empCd);
		List<MailVO> mailVO = service.retrieveMailList(paging);
		paging.setDataList(mailVO);
		paging.setRenderer(new BootstrapPaginationRenderer());
		model.addAttribute("paging", paging);
		model.addAttribute("simpleCondition", paging.getSimpleCondition());
		log.info("받은메일searchType : {}",searchType);
		log.info("받은메일SimpleCondition : {}", paging.getSimpleCondition());
		return "jsonView";
	}

	//지워야함
	@GetMapping("/test")
	public String mailtest() {
		return "mail/test";
	}

	
	
	@GetMapping("/ulist")
	public String mailUListRetrieve() throws Exception {
		return "mail/mailUList";
	}
	
	/**
	 * 안읽은 메일 조회
	 * 
	 * @param principal
	 * @param searchVO
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/ulist2")
	public String mailUListRetrieve
			(
			Authentication principal,
			@ModelAttribute("simpleCondition") SearchVO searchVO,
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord, 
			Model model
			)
			throws Exception {

		String empCd = principal.getName();
		// searchVO.setSearchType(searchType);
		// searchVO.setSearchWord(searchWord);
		PaginationInfo<MailVO> paging = new PaginationInfo<>(5, 3);
		// paging.setSimpleCondition(simpleCondition); // 키워드 검색 조건
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(searchVO);
		paging.setCurrentPage(currentPage);
		paging.setEmpCd(empCd);
		List<MailVO> mailVO = service.retrieveUMailList(paging);
		paging.setDataList(mailVO);
		paging.setRenderer(new BootstrapPaginationRenderer());
		model.addAttribute("paging", paging);
		model.addAttribute("simpleCondition", paging.getSimpleCondition());
		log.info("안읽은 메일 searchType : {}",searchType);
		log.info("안읽은 메일 SimpleCondition : {}", paging.getSimpleCondition());
		return "jsonView";
	}

	
	@GetMapping("/slist")
	public String mailSListRetrieve() throws Exception {
		return "mail/mailSList";
	}

	/**
	 * 보낸 메일 조회
	 * 
	 * @param principal
	 * @param searchVO
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/slist2")
	public String mailSendListRetrieve(Authentication principal, @ModelAttribute("simpleCondition") SearchVO searchVO,
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
			@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord, Model model)
			throws Exception {

		String empCd = principal.getName();
		PaginationInfo<MailVO> paging = new PaginationInfo<>(5, 3);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(searchVO);
		paging.setCurrentPage(currentPage);
		paging.setEmpCd(empCd);
		List<MailVO> mailVO = service.retrieveSMailList(paging);
		paging.setDataList(mailVO);
		paging.setRenderer(new BootstrapPaginationRenderer());
		model.addAttribute("paging", paging);
		model.addAttribute("simpleCondition", paging.getSimpleCondition());
		return "jsonView";
	}


	@GetMapping("/{mailNo}")
	public String mailRetrieve(@PathVariable int mailNo) throws Exception {
		return "mail/mailView";
	}

	/**
	 * 메일 상세 조회
	 * 
	 * @param principal
	 * @param mailNo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/view/{mailNo}")
	public String mailRetrieve(Authentication principal, @PathVariable int mailNo, Model model) throws Exception {
		String empCd = principal.getName();
		MailVO mailVO = service.retrieveMail(mailNo, empCd);
		List<AttatchVO> att = mailVO.getAttatchList();
		log.info("첨부파일 리스트 : {}", att);
		model.addAttribute("mailVO", mailVO);

		return "jsonView";
	}

	/**
	 * 보내는 사람 사번, 이름 저장
	 * 
	 * @param authentication
	 * @return
	 */
	@ModelAttribute("sendMail")
	public MailVO mail(Authentication authentication) {
		MailVO mail = new MailVO();
		EmpVO emp = new EmpVO();
		mail.setMailSen(authentication.getName());
		emp = empService.retrieveEmp(authentication.getName());
		String SenNm = emp.getEmpNm();
		mail.setSenNm(SenNm);
		return mail;
	}

	@GetMapping("/send")
	public String mailSend( ) {
		return "mail/mailSend";
	}

	/**
	 * 메일 보내기
	 * 
	 * @param authentication
	 * @param mailVO
	 * @return
	 */
	@PostMapping("/send")
	@ResponseBody
	public MailVO mailSend(Authentication authentication, 
			MailVO mailVO
			) {
		String mailSen = authentication.getName();
		log.info("메일 보내기 mailVO : {}",mailVO);
		
		mailVO.setMailSen(mailSen);
		
		String senNm = empDAO.getName(mailSen);
		String recNm = empDAO.getName(mailVO.getMailRec());
		MailVO retMailVO = new MailVO();
		retMailVO.setMailRec(mailVO.getMailRec());
		retMailVO.setMailSen(mailSen);
		retMailVO.setRecNm(recNm);
		retMailVO.setSenNm(senNm);
		
		service.createMail(mailVO);
		
		return retMailVO;
	}

	@Value("{appInfo.mailImagesUrl")
	private String mailImagesUrl;

	@Value("{appInfo.mailImagesUrl")
	private Resource mailImages;

	
	/**
	 * 파일 업로드
	 * 
	 * @param upload
	 * @param model
	 * @param req
	 * @return
	 * @throws IOException
	 */
	public String imageUpload(MultipartFile upload, Model model, HttpServletRequest req) throws IOException {
		if (!upload.isEmpty()) {
			String saveName = UUID.randomUUID().toString();
			File saveFolder = mailImages.getFile();
			File saveFile = new File(saveFolder, saveName);
			upload.transferTo(saveFile); // upload 완료

			String url = req.getContextPath() + mailImagesUrl + "/" + saveName;
			model.addAttribute("uploaded", 1);
			model.addAttribute("fileName", upload.getOriginalFilename());
			model.addAttribute("url", url);
		} else {
			model.addAttribute("uploaded", 0);
			model.addAttribute("error", Collections.singletonMap("xmessage", "업로드된 파일 없음."));
		}
		return "jsonView";
	}
	/*
	 * @PostMapping("imsi")
	 * 
	 * @ResponseBody public Map<String, Object> imageUpload(MultipartFile upload,
	 * HttpServletRequest req) throws IOException {
	 * 
	 * Map<String, Object> retMap = new HashMap<String, Object>();
	 * 
	 * if (!upload.isEmpty()) { String saveName = UUID.randomUUID().toString(); File
	 * saveFolder = mailImages.getFile(); File saveFile = new File(saveFolder,
	 * saveName); upload.transferTo(saveFile); // upload 완료
	 * 
	 * String url = req.getContextPath() + mailImagesUrl + "/" + saveName;
	 * retMap.put("uploaded", 1); retMap.put("fileName",
	 * upload.getOriginalFilename()); retMap.put("url", url); } else {
	 * retMap.put("uploaded", 0); retMap.put("error",
	 * Collections.singletonMap("message", "업로드된 파일 없음.")); } return retMap; }
	 * 
	 */
	
	@Value("#{appInfo.mailFiles}")
	private Resource mailFiles;

	/**
	 * 파일 다운로드
	 * 
	 * @param mailAtchNo
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/{mailNo}/mailFile/{mailAtchNo}")
	public ResponseEntity<Resource> download(@PathVariable int mailAtchNo) throws IOException {
		AttatchVO atch = service.retrieveAttatch(mailAtchNo);
		if (atch == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}

		Resource mailFile = mailFiles.createRelative(atch.getMailSvNm());
		if (!mailFile.exists()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 파일이 없음.");
		}

		ContentDisposition disposition = ContentDisposition.attachment()
				.filename(atch.getMailOrgNm(), Charset.defaultCharset()).build();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentDisposition(disposition);
		headers.setContentLength(atch.getMailAtchSize());
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return ResponseEntity.ok().headers(headers).body(mailFile);

	}

	/**
	 * 메일 주소록
	 * 
	 * @param deptNo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/addr")
	public String mailAddr(@RequestParam("what") int deptNo, Model model) throws Exception {
		log.info("메일 주소록 부서 번호 : {}", deptNo);
		List<EmpVO> empVO = service.mailAddr(deptNo);
		model.addAttribute("empVO", empVO);
		return "jsonView";
	}
	

	/**
	 * 받은 메일 삭제
	 * 
	 * @param mailNos
	 * @param model
	 * @return
	 */
	@DeleteMapping("/delete")
	public String deleteInbox(@RequestBody int[] mailNos, Model model) {
		service.removeInbox(mailNos);
		model.addAttribute("success", true);
		return "jsonView";
	}

	/**
	 * 보낸 메일 삭제
	 * 
	 * @param mailNos
	 * @param model
	 * @return
	 */
	@DeleteMapping("/sdelete")
	public String deleteSentMail(@RequestBody int[] mailNos, Model model) {
		service.removeSentMail(mailNos);
		model.addAttribute("success", true);
		return "jsonView";
	}
	
	/**
	 * 안읽은 메일 삭제
	 * 
	 * @param mailNos
	 * @param model
	 * @return
	 */
	@DeleteMapping("/udelete")
	public String deleteUnreadMail(@RequestBody int[] mailNos, Model model) {
		service.removeUnreadMail(mailNos);
		model.addAttribute("success", true);
		return "jsonView";
	}

}