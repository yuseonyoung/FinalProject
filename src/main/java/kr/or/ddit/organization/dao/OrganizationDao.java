package kr.or.ddit.organization.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.organization.vo.OrganizationVO;

@Mapper
public interface OrganizationDao {

	//리스트
	public List<OrganizationVO> list();
	
}
