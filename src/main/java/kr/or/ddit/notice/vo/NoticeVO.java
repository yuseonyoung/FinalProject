package kr.or.ddit.notice.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

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

@Data
public class NoticeVO {

	private int rnum;
	private int rnum1;
	private String ntcNo;
	private String ntcTitle;
	private String ntcCont;
	private String ntcRdate;
	private int ntcHit;
	private String ntcNm;
	private String empNm;
	private String empAuth;
	private String empCd;
	
	private MultipartFile[] uploadFile;
	
	//공지사항 : 첨부파일 = 1 : N
	private List<AtchFileDetailVO> atchFileDetailVO;
	
}
