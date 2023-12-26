package kr.or.ddit.msg.vo;

import java.io.Serializable;

import lombok.Data;

/**
 * @author 우정범
 * @since 2023. 11. 27.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 27.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Data
public class MsgVO implements Serializable {
	
//	//프로토콜 문법
//	String dd = "{id:희망,name:대덕}";
	/**
	 * 쪽지 보낸 사람
	 */
	private String sender;
	/**
	 * 쪽지 관리 번호
	 */
	private int msgNo;
	/**
	 * 쪽지를 받는 사람 사용자 아이디
	 */
	private String empCd;
	/**
	 * 상태코드
	 */
	private String msgStat;
	/**
	 * 상태
	 */
	private String msgStatNm;
	/**
	 * 상태 변경 일시
	 */
	private String msgStatDt;
	/**
	 * 쪽지 제목
	 */
	private String msgTitle;
	/**
	 * 쪽지 내용
	 */
	private String msgCont;
	/**
	 * 보낸 일시
	 */
	private String msgDate;
	/**
	 * 사용자 이름
	 */
	private String empNm;
	/**
	 * 사용자 직책&공지사항 관련 일반/중요
	 */
	private String hrGradeNm;
	/**
	 * 사용자 부서
	 */
	private String deptNm;
	/**
	 * 사용자 이미지
	 */
	private String empImg;
}
