package kr.or.ddit.empInfo.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HrRecVO {

	//HR_REC 인사이력
		private int hrRecNo; //(시퀀스)
		private String deptNo; //부서
		private String deptNoRec; //부서
		private String hrGrade; //직급 이력	
		private String hrGradeNmRec; //직급 이력	
		private String hrCharge; //직책 이력
		private String hrChargeNmRec; //직책 이력
		private Date hrRecSdate; //시작일
		private Date hrRecEdate;//종료일
		private String hrRecNote; //변경사유
		
	
}
