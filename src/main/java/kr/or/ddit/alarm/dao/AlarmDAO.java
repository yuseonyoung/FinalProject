package kr.or.ddit.alarm.dao;

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

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.alarm.vo.AlarmVO;

@Mapper
public interface AlarmDAO {
	
	/**
	 * 알람 전체 목록
	 * 
	 * @param empCd
	 * @return List<AlarmVO>
	 */
	public List<AlarmVO> selectMailAlarmList(String empCd);
	
	/**
	 * @param alarmVO
	 * @return 등록 성공( >= 1)
	 */
	public int insertMailAlarm(AlarmVO alarmVO);
	
	/**
	 * @param alarmVO
	 * @return 수정 성공( >= 1)
	 */
	public int updateAlarmChk();
}
