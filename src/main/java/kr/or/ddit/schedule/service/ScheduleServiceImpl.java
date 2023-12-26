package kr.or.ddit.schedule.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.schedule.dao.ScheduleDao;
import kr.or.ddit.schedule.vo.ScheduleVO;


@Service
public class ScheduleServiceImpl implements ScheduleService{
	
	@Inject
	ScheduleDao scheduleDao;

	/**
	 * 전체 일정 조회
	 * @param empCd
	 * @return 일정 목록
	 */
	@Override
	public List<ScheduleVO> listAll(String schdYn) {
		return scheduleDao.listAll(schdYn);
	}


	/**
	 * 일정 등록
	 * @param scheduleVO 등록될 일정 정보
	 */
	@Override
	public int registSchd(ScheduleVO scheduleVO) {
		return scheduleDao.registSchd(scheduleVO);
	};

	/**
	 * 일정 시간 변경
	 * @param scheduleVO 변경될 일정 정보
	 */
	@Override
	public int dragDropUpdate(ScheduleVO scheduleVO) {;
		return scheduleDao.dragDropUpdate(scheduleVO);
	}

	/**
	 * 일정 삭제
	 * @param schdlNo 삭제될 일정 번호
	 */
	public int deleteSchd(String schdNo) {
		return scheduleDao.deleteSchd(schdNo);
	};
}
