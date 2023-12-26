package kr.or.ddit.util.commcode.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class CommcodeVO implements Serializable{
	private String commCd;
	private String grCd;
	private String commCdNm;
	private String commYn;
	private String commRdate;
	private String commAdmin;
}
