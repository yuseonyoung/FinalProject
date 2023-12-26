package kr.or.ddit.mail.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.mail.vo.AttatchVO;

/**
 * @author 이수정
 * @since 2023. 11. 20.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일              수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 20.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *      </pre>
 */

@Mapper
public interface AttatchDAO {
	
	/**
	 * 첨부파일 등록
	 * 
	 * @param attatch
	 * @return
	 */
	public int insertAttatch(AttatchVO attatch);

	/**
	 * 첨부파일 조회
	 * 
	 * @param attNo
	 * @return
	 */
	public AttatchVO selectAttatch(int attNo);

	
}
