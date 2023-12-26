
package kr.or.ddit.util.commcode.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.AtchBrdFileDetailVO;
import kr.or.ddit.notice.vo.AtchFileDetailVO;

@Mapper
public interface AtchFileDetailDao {

	// ATCH_FILE_DETAIL 테이블에 insert public int
	public int insertAtchFileDetail(AtchFileDetailVO atchFileDetailVO);
	
	//kr.or.ddit.util.commcode.dao.AtchFileDetailDao
	// ATCH_BRD_FILE_DETAIL 테이블에 insert public int
	public int insertAtchBrdFileDetail(AtchBrdFileDetailVO atchBrdFileDetailVO);

}
