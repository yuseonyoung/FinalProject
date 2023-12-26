package kr.or.ddit.msg.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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

@Mapper
public interface MsgDao {

	/**
	 * 기업 내 모든 사용자
	 * @param msg 
	 * @return List<UserVO>
	 */
	public List<EmpVO> coUserList();
	/**
	 * 모든 알람 읽음처리
	 * @param List<MsgVO> msg
	 * @return int
	 */
	public int readAllUpdate(MsgVO m);
	/**
	 * 보낸 사람 쪽지 저장
	 * @param MsgVO msg
	 * @return int
	 */
	public int insertSender(MsgVO msg);
	/**
	 * 받는 사람 쪽지 저장
	 * @param MsgVO msg
	 * @return int
	 */
	public int insertReceiver(MsgVO msg);
	
	/**
	 * 보낸 쪽지
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> listSender(MsgVO msg);
	/**
	 * 받는 쪽지
	 * @param MsgVO msg
	 * @return List<MsgVO>
	 */
	public List<MsgVO> listReceiver(MsgVO msg);
	/**
	 * 보낸 쪽지 상세보기
	 * @param MsgVO msg
	 * @return MsgVO
	 */
	public MsgVO detailSender(MsgVO msg);
	/**
	 * 받는 쪽지 상세보기
	 * @param MsgVO msg
	 * @return MsgVO
	 */
	public MsgVO detailReceiver(MsgVO msg);
	
	/**
	 * 받는 쪽지 업데이트
	 * @param MsgVO msg
	 * @return int
	 */
	public int updateReceiver(MsgVO msg);
	/**
	 * 보낸 쪽지 업데이트
	 * @param MsgVO msg
	 * @return int
	 */
	public int updateSender(MsgVO msg);
}
