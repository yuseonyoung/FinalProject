package kr.or.ddit.alarm.vo;

/**
 * @author 이수정
 * @since 2023. 12. 03.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 12. 03.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

import lombok.Data;

@Data
public class AlarmVO {
	private String alarmSender;
	private String alarmReceiver;
	private Integer alarmNo;
	private String alarmCont;
	private String alarmCdate;
	private String alarmRdate;
	private String empCd;
	private String senNm;
	private String recNm;
	private String alarmType;
	private String alarmUrl;
	private String alarmChk;
}
