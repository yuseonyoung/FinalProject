package kr.or.ddit.employee.vo;

import java.io.Serializable;
import java.time.LocalDate;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import javax.validation.groups.Default;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.dept.vo.DeptVO;
import kr.or.ddit.grouphint.InsertGroup;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author 이수정
 * @since 2023. 11. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일             수정자               수정내용
 * --------        --------    ----------------------
 * 2023. 11. 10.     이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */
@Getter
@Setter
@EqualsAndHashCode(of = "empCd")
@ToString
public class EmpVO implements Serializable {
	private String empCd;
	private String empPw;
	private String empNm;
	private String empTelNo;
	private String empMail;
	private String empCmail;
	private LocalDate empBirth;
	private String empZip;
	private String empAddr;
	private String empDaddr;
	private String empImg;
	private String empSign;
	private String msgStat;
	private String empGend;
	private String empUse;
	private String empAuth;
	private String deptNo;
	private DeptVO dept;
	private String deptNm;

	private int hrSal;
	private String hrBank;
	private String hrBankNo;
	private LocalDate hrSdate;
	private LocalDate hrEdate;
	private String hrStat;
	private String hrMilYn;
	private String hrMilYnNm;
	private String hrStatNm;

	private String empPpw;

	private String authCd;

	private String hrCharge;
	private String hrChargeNm;

	private String hrGrade;
	private String hrGradeNm;

	@JsonIgnore
	public String getUserRole() {
		switch (empAuth) {
		case "admin":
			return "ROLE_ADMIN";
		case "office":
			return "ROLE_OFFICE";
		case "field":
			return "ROLE_FIELD";
		default:
			return "ROLE_N";
		}
	}

}
