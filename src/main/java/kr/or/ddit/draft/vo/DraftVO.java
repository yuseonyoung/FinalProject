package kr.or.ddit.draft.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.GroubUtils;
import lombok.Data;

@Data
public class DraftVO {
	
	/**
	 * 기안 번호
	 */
	private int drftNo;
	
	/**
	 * 기안을 작성한 사용자 아이디
	 */
	private String empCd;
	
	private String empNm;
	private String hrGrade;
	private String deptNm;
	private String hrGradeNm;
	
	/**
	 * 기안 문서의 제목
	 */
	private String drftTitle;
	
	/**
	 * 기안 최종 처리 일시
	 */
	private Date drftFndate;
	
	/**
	 * 기안의 현재 상태(진행중/ 완료/ 임시저장) 
	 */
	private String drftStat;
	
	
	private String dlineStatCd;
	

	/**
	 * 기안 문서가 작성된 HTML 코드
	 */
	private String drftSave;
	
	/**
	 * 기안 문서 작성 일자
	 */
	private Date drftWdate;
	
	/**
	 * 기안 문서 작성 일자(yyyy-MM-dd 형식)
	 */
	private String drDtFm1;
	
	/**
	 * 기안 문서 작성 일자(yyyy-MM-dd HH24:mm:ss 형식)
	 */
	private String drDtFm2;
	
	/**
	 * 기안 문서 삭제 여부
	 */
	private String drftYn;
	
	/**
	 * 기안 문서 삭제 일자
	 */
	private Date drftDdate;
	
	/**
	 * 기안 문서내 기안 의견 번호
	 */
	private int opNo;
	
	private int idx;
	
	private int opNoCal;

    public int getOpNoCalculation() {
        return opNo + idx; 
    }

    public void opNoCal(int opNoCal) {
        this.opNoCal = opNoCal;
    }
	
	/**
	 * 기안 문서내 첨부파일 번호
	 */
	private int datchNo;
	
	private String drftStatTemp;
	
	/**
	 * 휴가 기안의 휴가 내용
	 */
	private DraftVacVO draftVacVO;
	
	
	private int vacNo;
	
	
	
	
	/**
	 * 발주서의 발주 내용
	 */
	private DraftOrderVO draftOrderVO;
	
	private String pordCd;

	
	/**
	 * 기안 문서에 등록된 첨부파일 배열
	 */
	private MultipartFile[] attachFiles;
	
	/**
	 * 기안의 첨부파일 리스트
	 */
	private List<DraftAtchVO> drftAtchVOList;
	/**
	 * 기안의 의견 리스트
	 */
	private List<DraftOpVO> drftOpVOList;
	/**
	 * 기안의 결재권자 리스트
	 */
	private List<DraftLineVO> drftLineVOList;
	/**
	 * 기안의 발주 리스트
	 */
	private List<DraftOrderVO> drftOrderVOList;
	
	
	/**
	 * 기안 문서 작성일을 yyyy:MM:dd 의 포맷으로 바꿔서 출력
	 * @return yyyy-MM-dd
	 */
	public String getShowDrDtForm1() {
		return GroubUtils.yearToString(drftWdate);
	}
	
	/**
	 * 기안 문서의 drDtFm1을 yyyy:MM:dd 형태로 저장한다
	 */
	public void setDrDtForm1() {
		this.drDtFm2 = GroubUtils.yearToString(drftWdate);
	}
	
	/**
	 * 기안 문서 작성일을 yyyy-MM-dd HH:mm:ss 의 포맷으로 바꿔서 출력
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public String getShowDrDtForm2() {
		return GroubUtils.yearToString2(drftWdate);
	}
	
	/**
	 * 기안 문서의 drDtFm2을 yyyy-MM-dd HH:mm:ss 형태로 저장한다
	 */
	public void setDrDtForm2() {
		this.drDtFm2 = GroubUtils.yearToString2(drftWdate);
	}
	
	public String getMakeYMD(Date date) {
		return GroubUtils.yearToString(date);
	}
	public String getMakeYMDHMS(Date date) {
		return GroubUtils.yearToString2(date);
	}
}

