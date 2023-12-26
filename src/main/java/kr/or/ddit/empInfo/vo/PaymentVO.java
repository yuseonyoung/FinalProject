package kr.or.ddit.empInfo.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PaymentVO {

	//급여 연월 , 공제후 지급액, 지급항목함계 ,  공제 항목합계 , 지급일 (메인화면)
	
	/**
	 * 급여명세번호 (기본키 시퀀스)
	 */
	private int payNo;
	/**
	 * 회원아이디
	 */
	private String empCd;
	/**
	 * 급여 연월
	 */
	private String workDate;
	/**
	 * 지급일
	 */
	private String payDate;
	/**
	 * 기본급
	 */
	private int sal;
	/**
	 * 기본급
	 */
	private int roundSal;
	/**
	 * 연장근로수당
	 */
	private int overWork;
	/**
	 * 식대
	 */
	private int food;
	/**
	 * 국민연금
	 */
	private int npn;
	/**
	 * 고용보험
	 */
	private int empIns;
	/**
	 * 소득세
	 */
	private int inTax;
	/**
	 * 지방소득세
	 */
	private int linTax;
	/**
	 * 공제후 실 지급액
	 */
	private int pay;
	/**
	 * 건강보험
	 */
	private int hlthIns;
	/**
	 * 장기요양보험
	 */
	private int ltc;
	/**
	 * 지급항목합계(기본급,연장근로,식대)
	 */
	private int totalPay;
	/**
	 * 공제항목합계(세금,보험)
	 */
	private int totalTax;
	/**
	 * 급여지급 연도
	 */
	private int selectYear;
	/**
	 * 입사일
	 */
	private int joinYear;
	/**
	 * 부서
	 */
	private String deptNoNm;
	/**
	 * 직급
	 */
	private String hrGradeNm;
	/**
	 * 이름
	 */
	private String empNm;
	/**
	 * 생년월일
	 */
	private Date empBirth;
	/**
	 * 은행명
	 */
	private String hrBank;
	/**
	 * 계좌번호
	 */
	private String hrBankNo;


	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
