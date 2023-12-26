package kr.or.ddit.draft.vo;

import lombok.Data;

@Data
public class DraftAtchVO {

	private int drftNo;
	
	/**
	 * 첨부파일 관리 번호
	 */
	private int datchNo;
	
	/**
	 * 파일명
	 */
	private String drftOrgNm;
	
	/**
	 * 첨부파일 중복방지를 위한 무작위 UUID가 붙은 파일명
	 */
	private String drftSaveNm;
	
	/**
	 * 파일이 저장될 경로
	 */
	private String drftPath;
	
	/**
	 * 첨푸파일의 확장자명
	 */
	private String drftType;
	
	/**
	 * 파일의 사이즈
	 */
	private long drftSize;
}
