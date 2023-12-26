package kr.or.ddit.draft.vo;

import java.util.Date;

import lombok.Data;


@Data
public class DraftVacVO {
	/**
	 * 휴가부여 관리번호(시퀀스)
	 * 또는 휴가 사용 시 사용한 부여받은 휴가 번호
	 */
	private int vacGrtNo;
	/**
	 * 휴가를 부여 받은 사용자 아이디
	 */
	private String empCd;
	/**
	 * 부여받은 휴가의 유형 공통 코드 
	 * 혹은 사용할 유가의 유형 공통 코드
	 */
	private String vacGrtType;
	/**
	 * 휴가 유형의 유형 명(연차, 병가, 보상, 포상)
	 */
	private String vacGrtTypeNm;
	/**
	 * 부여받은 일자
	 */
	private Date vacGrtDate;
	/**
	 * 부여받은 휴가의 총 일 수
	 */
	private int vacGrtDays;
	/**
	 * 부여받은 휴가의 유효기간(만료일자)
	 */
	private Date vacGrtVal;

	/**
	 * 남은 휴가 일 수
	 */
	private double remainVacDays;

	/**
	 * 휴가를 사용한 총 일 수
	 */
	private int vacDays;

	/**
	 * 휴가를 사용한 사유
	 */
	private String vacRsn;

	/**
	 * 휴가사용이력 관리 번호
	 */
	private int vacNo;

	/**
	 * 한 기안에 휴가를 얼마나 사용했는지
	 */
	private double vacDay;

	/**
	 * 휴가 시작 일시
	 */
	private String vacSdate;

	/**
	 * 휴가 종료 일시
	 */
	private String vacEdate;
	
	
	private String vacType;
	
	/**
	 * 기안 번호
	 */
	private int drftNo;
	
	public void setVacNo(int vacNo) {
	    this.vacNo = vacNo;
	}

}
