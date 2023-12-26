package kr.or.ddit.empInfo.vo;


import lombok.Data;

@Data
public class EmployeesVacVO {

	private String empCd; //아이디
	private String empNm; //이름
	private String deptNm; //부서명
	private String deptNoNm; //부서명
	private int totalVacGrtDays; //부여연차
	private int totalVacDays; //사용한연차
	private int remainDays; //잔여연차
	private int workingYear; //근속연수
	private String hrStat; //재직상태
	private String hrStatNm; //재직상태
}
