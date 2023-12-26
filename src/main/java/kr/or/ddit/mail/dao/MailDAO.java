package kr.or.ddit.mail.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.mail.vo.MailVO;
import kr.or.ddit.paging.vo.PaginationInfo;

/**
 * @author 이수정
 * @since 2023. 11. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 15.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */


@Mapper
public interface MailDAO {
	
	/**
	 * 받은 메일 목록 조회
	 * @param paging
	 * @return
	 */
	public List<MailVO> selectMailList(PaginationInfo<MailVO> paging);
	
	/**
	 * 안읽은 메일 목록 조회
	 * @param paging
	 * @return
	 */
	public List<MailVO> selectUMailList(PaginationInfo<MailVO> paging);
	
	/**
	 * 보낸 메일 목록 조회
	 * @param paging
	 * @return
	 */
	public List<MailVO> selectSMailList(PaginationInfo<MailVO> paging);
	
	/**
	 * 받은 메일 페이징 토탈 레코드
	 * @param paging
	 * @return
	 */
	public int selectTotalRecord(PaginationInfo<MailVO> paging);
	
	/**
	 * 안읽은 메일 페이징 토탈 레코드
	 * @param paging
	 * @return
	 */
	public int selectTotalURecord(PaginationInfo<MailVO> paging);
	
	/**
	 * 보낸 메일 페이징 토탈 레코드
	 * @param paging
	 * @return
	 */
	public int selectTotalSRecord(PaginationInfo<MailVO> paging);
	
	/**
	 * 메읽 읽음 처리
	 * @param mailVO
	 * @return
	 */
	public int readYN(MailVO mailVO);
	
	/**
	 * 메일 상세 조회
	 * @param mailNo
	 * @return
	 */
	public MailVO selectMail(int mailNo);
	
	/**
	 * 메일 보내기
	 * @param mailVO
	 * @return
	 */
	public int insertMail(MailVO mailVO);
	
	/**
	 * 메일 주소록
	 * @param deptNo
	 * @return
	 */
	public List<EmpVO> mailAddr(int deptNo);
	
	/**
	 * 받은 메일 삭제
	 * @param mailNo
	 * @return
	 */
	public int updateInbox (int mailNo);
	
	/**
	 * 보낸 메일 삭제
	 * @param mailNo
	 * @return
	 */
	public int updateSentMail (int mailNo);
	
	/**
	 * 안읽은 메일 삭제
	 * @param mailNo
	 * @return
	 */
	public int updateUnreadMail (int mailNo);
	
}
