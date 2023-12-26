package kr.or.ddit.draft.vo;

import java.util.Date;

import kr.or.ddit.util.GroubUtils;
import lombok.Data;

@Data
public class DraftLineVO {

	/**
	 * 결재의 순번을 구분
	 */
	private int drftNo;
	
	private int dlineSq;
	/**
	 * 결재권자의 아이디
	 */
	private String empCd;
	
	/**
	 * 결재권자의 이름
	 */
	private String empNm;
	
	/**
	 * 결재권자의 부서명
	 */
	private String deptNm;
	
	/**
	 * 결재권자의 직급명
	 */
	private String hrGrade;
	private String hrGradeNm;
	
	/**
	 * 결재권자의 사진
	 */
	private String empImg;
	
	/**
	 * 결재권자의 사인 이미지
	 */
	private String empSign;
	
	/**
	 * 결재권자의 사인 이미지, 결재 끝 순서
	 */
	private int maxDlineSq;
	
	/**
	 * 결재자/ 수신자/ 회람자/ 대결자 등의 역할을 의미
	 */
	private String dlineCd;
	
	/**
	 * 승인 / 반려와 같은 결재 상태 코드
	 */
	private String dlineStatCd;
	
	
	/**
	 * 결재 상태 코드 명
	 */
	private String dlineStatNm;
	
	/**
	 * 결재, 반려 등을 시행한 일시
	 */
	private Date dlineDt;
	
	/**
	 * 결재, 반려 등을 시행한 일시(yyyy-MM-dd)
	 */
	private String dlineDtFm;
	
	/**
	 * 결재, 반려 등을 시행한 일시(yyyy-MM-dd) 바꿔준다
	 */
	public String getDlineDtForm() {
		if (this.dlineDt != null) {
			return GroubUtils.yearToString(this.dlineDt);
		}
		return null;
	}
	
	/**
	 * 결재, 반려 등을 시행한 일시(yyyy-MM-dd) 바꿔준다
	 */
	public void setDlineDtForm() {
		this.dlineDtFm = GroubUtils.yearToString(dlineDt);
	}
}
