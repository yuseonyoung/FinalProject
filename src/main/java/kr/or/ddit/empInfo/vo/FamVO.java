package kr.or.ddit.empInfo.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
@Data
public class FamVO {
	
	//FAM
	private int famNo; //기본키(시퀀스)
	private String empCd; //접속자 아이디
	private String famNm; //가족이름
	private String famRel; //가족관계(공통코드)
	private String famRelNm; //가족관계(공통코드)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date famBirth; //가족생일
	private String famGend; //가족 성별(남M,여W)
	
	
}


