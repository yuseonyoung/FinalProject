package kr.or.ddit.empInfo.vo;

import lombok.Data;

@Data
public class PaymentEmployeeVO {
	

	/**
	 * 급여명세번호 (기본키 시퀀스)
	 */
	private int payNo;
	/**
	 * 회원아이디
	 */
	private String empCd;
	/**
	 * 이름
	 */
	private String empNm;

	/**
	 * 부서
	 */
	private String deptNoNm;
	/**
	 * 은행명
	 */
	private String hrBank;
	/**
	 * 계좌번호
	 */
	private String hrBankNo;
	/**
	 * 공제후 실 지급액
	 */
	private int pay;
	/**
	 * 지급항목합계(기본급,연장근로,식대)
	 */
	private int totalPay;
	/**
	 * 공제항목합계(세금,보험)
	 */
	private int totalTax;
	/**
	 * 급여 연도
	 */
	private int selectYear;
	/**
	 * 급여 월
	 */
	private int selectMonth;
	
	
	
	
	
	
	

}
