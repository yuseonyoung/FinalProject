package kr.or.ddit.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.vo.CommCdVO;
import kr.or.ddit.common.vo.GrpCdVO;

@Mapper
public interface CommCdDao {

	public List<GrpCdVO> groupCodeList();

	public List<CommCdVO> commonCodeList();

	public List<CommCdVO> commonCodeName();
	
	public String maxCommonCode(@Param("grCd") String grCd);

	public int createCommonCode(CommCdVO commCdVO);

	public int codeAct(String commCd);
}
