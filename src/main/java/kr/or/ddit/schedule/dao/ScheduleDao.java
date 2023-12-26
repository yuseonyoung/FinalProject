package kr.or.ddit.schedule.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.schedule.vo.ScheduleVO;

/**
 * @author 우정범
 * @since 2023. 11. 18.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 18.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Mapper
public interface ScheduleDao {

	/**
	 * 전체 일정 조회
	 * @param empCd
	 * @return 일정 목록
	 */
	public List<ScheduleVO> listAll(String schdYn);

	/**
	 * 일정 등록
	 * @param scheduleVO 등록될 일정 정보
	 */
	public int registSchd(ScheduleVO scheduleVO);

	/**
	 * 일정 시간 변경
	 * @param scheduleVO 변경될 일정 정보
	 */
	public int dragDropUpdate(ScheduleVO scheduleVO);

	/**
	 * 일정 삭제
	 * @param schdNo 삭제될 일정 번호
	 */
	public int deleteSchd(String schdNo);


}
