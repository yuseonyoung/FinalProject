package kr.or.ddit.msg.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.msg.dao.MsgDao;
import kr.or.ddit.msg.vo.MsgVO;
import lombok.extern.slf4j.Slf4j;


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
@Slf4j
@Service
public class MsgServiceImpl implements MsgService {
	
	/**
	 * 쪽지 mapper
	 */
	@Inject
	private MsgDao msgDao;

	/**
	 * 기업 내 모든 사용자 리스트
	 * @return List<EmpVO>
	 */
	public List<EmpVO> coUserList(){
		return this.msgDao.coUserList();
	}
	
	/**
	 * 공지사항 전체 알람 등록하기
	 * @return int
	 */
	@Transactional
	public int insertAlarmNotice(MsgVO m) {
		m.setMsgStat("V006");
		
		int rlt = this.msgDao.insertSender(m);
		rlt += this.msgDao.insertReceiver(m);
		
		return rlt;
	}
	/**
	 * 모든 알람 메세지 읽음 처리
	 * @return int
	 */
	public int readAllUpdate(MsgVO m) {
		m.setMsgStat("V006");
		return this.msgDao.readAllUpdate(m);
	}
	
	/**
	 * 알람 메세지 불러오기
	 * @param MsgVO m
	 * @return List<MsgVO>
	 */
	public List<MsgVO> listAlarm(MsgVO m){
		List<MsgVO> mList = this.msgDao.listReceiver(m);
		List<MsgVO> mTemp = new ArrayList<MsgVO>();
		
		for(MsgVO mVO:mList) if(mVO.getMsgStat().equals("V006")||mVO.getMsgStat().equals("V007")) mTemp.add(mVO);
		
		return mTemp;
	}

	/**
	 * 쪽지 등록하기
	 * @param MsgVO msg
	 * @return int
	 */
	@Transactional
	public int insert(MsgVO msg) {
		log.info("msg>> "+msg);
		
		int result = 0;
		if(msg.getMsgStat()==null) msg.setMsgStat("V001");
		
		int r1 = this.msgDao.insertSender(msg);
		result += r1;
		
		int r2 = this.msgDao.insertReceiver(msg);
		result += r2;
		
		return result;
	}

	/**
	 * 중요 쪽지 설정
	 * @param MsgVO msg
	 * @return int
	 */
	public int importMsg(MsgVO msg) {
		if(msg.getMsgStat().equals("V001")||msg.getMsgStat().equals("V002")) msg.setMsgStat("V005");
		else if(msg.getMsgStat().equals("V005")) msg.setMsgStat("V002");
		return this.msgDao.updateReceiver(msg);
	}

	/**
	 * 받은 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> listReceiver(MsgVO msg) {
		List<MsgVO> listTemp = this.msgDao.listReceiver(msg);
		List<MsgVO> list = new ArrayList<MsgVO>();
		for(int i=0;i<listTemp.size();i++) {
			msg = listTemp.get(i);
			MsgDateFormat(msg);
			if(msg.getMsgStat().equals("V001")||msg.getMsgStat().equals("V002")||msg.getMsgStat().equals("V005")) list.add(listTemp.get(i));
		}
		return list;
	}
	
	/**
	 * 보낸 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> listSender(MsgVO msg) {
		List<MsgVO> listTemp = this.msgDao.listSender(msg);
		List<MsgVO> list = new ArrayList<MsgVO>();
		for(int i=0;i<listTemp.size();i++) {
			msg = listTemp.get(i);
			MsgDateFormat(msg);
			if(msg.getMsgStat().equals("V003")||msg.getMsgStat().equals("V004")||msg.getMsgStat().equals("V006")||msg.getMsgStat().equals("V007")) {
			}else {
				list.add(msg);
			}
		}
		return list;
	}

	/**
	 * 받은 쪽지 상세보기
	 * @param MsgVO msg
	 * @return MsgVO
	 */
	@Transactional
	public MsgVO detailReceiver(MsgVO msg) {
		//글을 읽을 때만 변경되게 설정
		if(msg.getMsgStat().equals("V001")) {
			msg.setMsgStat("V002");
			int result = this.msgDao.updateReceiver(msg);
			result += this.msgDao.updateSender(msg);
		}
		msg = this.msgDao.detailReceiver(msg);
		MsgDateFormat(msg);
		
		return msg;
	}

	/**
	 * 보낸 메일 상세보기
	 * @param MsgVO msg
	 * @return MsgVO
	 */
	public MsgVO detailSender(MsgVO msg) {
		msg = this.msgDao.detailReceiver(msg);
		MsgDateFormat(msg);
		return msg;
	}
	
	/**
	 * 중요 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> msgImport(MsgVO msg) {
		return this.msgDao.listReceiver(msg);
	}
	
	/**
	 * 휴지통 보내기
	 * @param MsgVO msg
	 * @return int
	 */
	public int trashSet(MsgVO msg) {
		msg.setMsgStat("V003");
		log.info("msg>> "+msg);
		return this.msgDao.updateReceiver(msg);
	}
	
	/**
	 * 휴지통에 있는 메일 삭제
	 * @param MsgVO msg
	 * @return int
	 */
	public int delete(MsgVO msg) {
		msg.setMsgStat("V004");
		return this.msgDao.updateReceiver(msg);
	}

	/**
	 * 휴지통에 있는 쪽지 복원하기
	 * @param MsgVO msg
	 * @return int
	 */
	public int restore(MsgVO msg) {
		msg.setMsgStat("V002");
		log.info("msg>> "+msg);
		return this.msgDao.updateReceiver(msg);
	}
	
	/**
	 * 휴지통 목록
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> trash(MsgVO msg) {
		msg.setMsgStat("V003");
		List<MsgVO> list= this.msgDao.listReceiver(msg);
		for(int i=0;i<list.size();i++) {
			msg = list.get(i);
			MsgDateFormat(msg);
		}
		return list;
	}
	
	/** 
	 * String type으로 받아온 날짜 format
	 * @param MsgVO msg
	 */
	private void MsgDateFormat(MsgVO msg) {
		String date = msg.getMsgDate();
		date = date.substring(0,16);
		msg.setMsgDate(date);
	}
}
