package kr.or.ddit.alarm.service;

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

import java.util.List;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.common.enumpkg.ServiceResult;

public interface AlarmService {
	
	/** 전체 알람 목록
	 * @param empCd
	 * @return
	 */
	public List<AlarmVO> retrieveMailAlarmList(String empCd);
	
	
	
}
