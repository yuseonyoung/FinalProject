package kr.or.ddit.mail.service;

import java.util.List;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.mail.vo.AttatchVO;
import kr.or.ddit.mail.vo.MailVO;
import kr.or.ddit.paging.vo.PaginationInfo;

/**
 * @author 이수정
 * @since 2023. 11. 15.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 15.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

/**
 * @author 이수정
 * @since 2023. 12. 10.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2023. 12. 10.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */
public interface MailService {
	
	/**
	 * 받은 메일 목록 조회
	 * @param paging
	 * @return
	 */
	public List<MailVO> retrieveMailList(PaginationInfo<MailVO> paging);

	/**
	 * 안읽은 메일 목록 조회
	 * @param paging
	 * @return
	 */
	public List<MailVO> retrieveUMailList(PaginationInfo<MailVO> paging);

	/**
	 * 보낸 메일 목록 조회
	 * @param paging
	 * @return
	 */
	public List<MailVO> retrieveSMailList(PaginationInfo<MailVO> paging);

	/**
	 * 메일 상세 조회
	 * @param mailNo
	 * @param empCd
	 * @return
	 */
	public MailVO retrieveMail(int mailNo, String empCd);

	/**
	 * 메일 보내기
	 * @param mailVO
	 * @return
	 */
	public ServiceResult createMail(MailVO mailVO);

	/**
	 * 첨부파일 조회
	 * @param mailAtchNo
	 * @return
	 */
	public AttatchVO retrieveAttatch(int mailAtchNo);

	/**
	 * 메일 주소록
	 * @param deptNo
	 * @return
	 */
	public List<EmpVO> mailAddr(int deptNo);

	/**
	 * 받은 메일 삭제
	 * @param mailNos
	 * @return
	 */
	public ServiceResult removeInbox(int[] mailNos);

	/**
	 * 보낸 메일 삭제
	 * @param mailNos
	 * @return
	 */
	public ServiceResult removeSentMail(int[] mailNos);

	/**
	 * 안읽은 메일 삭제
	 * @param mailNos
	 * @return
	 */
	public ServiceResult removeUnreadMail(int[] mailNos);
}
