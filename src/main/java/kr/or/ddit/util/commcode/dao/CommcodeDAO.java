package kr.or.ddit.util.commcode.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.util.commcode.vo.CommcodeVO;

@Mapper
public interface CommcodeDAO {
	public List<CommcodeVO> itemGroupList();
	/**
	 * 창고그룹
	 * @return
	 */
	public List<CommcodeVO> wareGroupList();
	
	/**
	 * 불량품목리스트
	 * @return
	 */
	public List<CommcodeVO> defectGroupList();
	
	/**
	 * 불량처리방법 리스트
	 * @return
	 */
	public List<CommcodeVO> defectTypeGroupList();
	
	public List<Map<String, String>> selectCommCdList(String grCd);

	public List<Map<String, String>> selectDeptNoList();
	
	
}
