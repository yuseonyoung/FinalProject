package kr.or.ddit.board.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplVO {
	private int replNo;
	private String empCd;
	private String replCont;
	// 일단 추가
	private String empNm;
	private String empImg;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date replRdate;
	private Date replMdate;
	private String brdNo;
}
