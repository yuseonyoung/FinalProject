package kr.or.ddit.company.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.company.dao.CompanyDAO;
import kr.or.ddit.company.vo.CompanyVO;

@Service
public class CompanyServiceImpl implements CompanyService{

	@Inject
	private CompanyDAO companyDAO;
	
	

}
