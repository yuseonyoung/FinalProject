package kr.or.ddit.msg.service;

import java.util.List;

import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.msg.vo.MsgVO;


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
public interface MsgService {

	/**
	 * 쪽지 등록
	 * @param MsgVO msg
	 * @return int
	 */
	public int insert(MsgVO msg);
	/**
	 * 중요 쪽지 설정
	 * @param MsgVO msg
	 * @return int
	 */
	public int importMsg(MsgVO msg);
	/**
	 * 받은 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> listReceiver(MsgVO msg);
	/**
	 * 보낸 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> listSender(MsgVO msg);
	/**
	 * 받은 쪽지 상세보기
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public MsgVO detailReceiver(MsgVO msg);
	/**
	 * 보낸 쪽지 상세보기
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public MsgVO detailSender(MsgVO msg);
	/**
	 * 중요 쪽지함
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> msgImport(MsgVO msg);
	/**
	 * 쪽지 삭제
	 * @param MsgVO msg
	 * @return int
	 */
	public int delete(MsgVO msg);
	/**
	 * 휴지통 보내기
	 * @param MsgVO msg
	 * @return int
	 */
	public int trashSet(MsgVO msg);
	/**
	 * 복원하기
	 * @param MsgVO msg
	 * @return int
	 */
	public int restore(MsgVO msg);
	/**
	 * 휴지통 목록
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	List<MsgVO> trash(MsgVO msg);
	
	public int readAllUpdate(MsgVO m);
	
	public List<MsgVO> listAlarm(MsgVO m);
	
	public int insertAlarmNotice(MsgVO msg);
	
	public List<EmpVO> coUserList();
	
}
