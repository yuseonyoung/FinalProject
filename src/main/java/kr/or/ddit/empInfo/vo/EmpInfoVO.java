package kr.or.ddit.empInfo.vo;

import java.io.File;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.draft.vo.DraftVacVO;
import kr.or.ddit.util.GroubUtils;
import lombok.Data;

/**
 * @author 우정범
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Data
public class EmpInfoVO {
	
	//EMP
	private String empCd; //기본키
	private String empPw; //사원계정 비밀번호
	private String empNm; //사용자이름
	private String empTelNo; //핸드폰번호
	private String empMail; //메일주소
	private Date empBirth; //생년월일
	private String empZip; //우편번호
	private String empAddr; //주소
	private String empDaddr; //상세주소
	private String empImg; //사진
	private String empSign; //서명사진
	private String empGend; //성별(남M,여W)
	private String msgStat; //메신저 상태 
	private String empUse; //해당아이디사용여부(1:사용, 0:비사용)
	
	private int failCnt;
	
	
	//EMP_INFO
	private int deptNo; //부서(Dept)테이블의 기본키를 받아오는 외래키 
	private String hrGrade; //직급코드(공통코드)
	private String hrGradeNm; //직급코드(공통코드)
	private String hrCharge; //직무코드(공통코드)
	private String hrChargeNm; //직무코드(공통코드)
	private int hrSal; //연봉
	private String hrBank; //은행
	private long hrBankNo; //계좌번호
	private Date hrSdate; //입사일
	private Date hrEdate; //퇴사일
	private String hrStat; //재직상태
	private String hrStatNm; //재직상태
	private String hrMilYn; //병역이행여부
	private String hrMilYnNm; //병역이행여부
	
	private String deptNm; //부서명
	
	
	//인사이력
	private List<HrRecVO> hrRecVO;
	//가족정보
	private List<FamVO> famVO;
	////공통코드 중 가족 관계 
	private List<FamManageCodeVO> famManageCodeVO;
	
	private List<DraftVacVO> draftVacVOList;
	
	
	
	public String getMakeYMD(Date date) {
		return GroubUtils.yearToString(date);
	}
}



