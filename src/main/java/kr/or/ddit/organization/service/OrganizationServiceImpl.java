package kr.or.ddit.organization.service;

import java.util.List;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.organization.dao.OrganizationDao;
import kr.or.ddit.organization.vo.OrganizationVO;

@Service
public class OrganizationServiceImpl implements OrganizationService {
	
	@Inject
	OrganizationDao organizationDao;
	
	@Override
	public List<OrganizationVO> list(){
		return this.organizationDao.list();
	}

}
