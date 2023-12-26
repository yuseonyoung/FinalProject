package kr.or.ddit.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.OthersVO;

/**
 * @author 이수정
 * @since 2023. 11. 16.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet 
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일               수정자               수정내용
 * --------         --------    ----------------------
 * 2023. 11. 16.      이수정       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

@Mapper
public interface OthersDAO {
	
	/**
	 * 권한 조회
	 * @return
	 */
	public List<OthersVO> selectAuthList();
	
	/**
	 * 사용 여부 조회
	 * 
	 * @return
	 */
	public List<OthersVO> selectUseList();
	
}
