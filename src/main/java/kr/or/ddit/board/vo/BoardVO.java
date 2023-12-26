package kr.or.ddit.board.vo;

import java.util.Date;
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
public class BoardVO {
	private int rnum;
	private int rnum1;
	private String brdNo;
	private String brdTitle;
	private String brdCont;
	private String brdRdate;
	private int brdHit;
	private String brdTemp;
	private String brdNm;
	private String empNm;
	private String empAuth;
	//하나의 글에 첨부파일이 여려개
	private List<AtchBrdFileDetailVO> atchBrdFileDetailVOList;
	//<input class="form-control" id="uploadFile" name="uploadFile" type="file" multiple="" />
	private MultipartFile[] uploadFile;
	//댓글 
	private List<ReplVO> replVO;  //has many
	private int replNo;
	private String replCont;
	private Date replRdate;
	private Date replMdate;
	
	
	
}









































































