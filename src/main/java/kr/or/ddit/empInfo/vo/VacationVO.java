package kr.or.ddit.empInfo.vo;

import java.util.Date;

import lombok.Data;

@Data
public class VacationVO {
	//휴가 부여
	private int vacGrtNo; //시퀀스
	private String empCd; //사원번호
	private String vacGrtType; //부여받은 휴가 유형
	private String vacGrtTypeNm; //부여받은 휴가 유형 name
	private int vacGrtDays; //부여받은 휴가의 일수
	private Date vacGrtDate; //휴가 부여받은 일자
	private Integer totalVacGrtDays; //휴가 부여받은 총 일자
	private Date vacGrtVal; //휴가 만료기간
	private String vacGrtRsn; //휴가 사유
	private Integer usedDays; //총 휴가 사용일자
	private Integer totalVacDays;
	
	//휴가 사용
	private int vacDays; //휴가 사용일수
	private String vacTypeNm;
	private String vacType;

	private Date vacSdate; //휴가 시작 일시
	private Date vacEdate; //휴가 끝나는 일시
	private String vacRsn; // 휴가 사유
	
	private int joinYear; //입사년도
	
	private int selectedValue; //선택된 년도
	
}
