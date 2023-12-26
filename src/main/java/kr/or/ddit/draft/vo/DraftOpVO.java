package kr.or.ddit.draft.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DraftOpVO {

	/**
	 * 기안에 작성된 의견 관리 번호
	 */
	private int opNo;
	
	private int drftNo;
	
	/**
	 * 의견을 작성한 사용자 아이디
	 */
	private String empCd;
	
	/**
	 * 의견 내용
	 */
	private String opCont;
	
	/**
	 * 의견 작성 일시
	 */
	private Date opWdate;
	
	/**
	 * 의견 삭제 여부
	 */
	private String opYn;
	
	/**
	 * 의견 삭제 일시
	 */
	private Date opDdate;
}
