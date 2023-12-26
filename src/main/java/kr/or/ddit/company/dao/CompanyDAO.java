package kr.or.ddit.company.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.company.vo.CompanyVO;


@Mapper
public interface CompanyDAO {
	
	/**
	 * 
	 * 거래처 조회시 사용할 공통코드
	 * 
	 * @return
	 */
	public List<CompanyVO> commCompanyList();
	
	
	
}
