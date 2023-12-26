package kr.or.ddit.empInfo.vo;

import lombok.Data;

@Data
public class FamManageCodeVO {
	
	//공통코드 중 가족 관계
	private String commCd; //매니지코드
	private String grCd; //공통코드분류
	private String commCdNm; //관계한글명
	private String commCdNm1; //관계한글명
	private String commYn; //사용여부

}
