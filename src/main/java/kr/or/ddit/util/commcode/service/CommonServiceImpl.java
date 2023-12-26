package kr.or.ddit.util.commcode.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.util.commcode.dao.CommcodeDAO;

@Service
public class CommonServiceImpl implements CommonService {

	@Inject
	CommcodeDAO commcodeDao;

	@Override
	public List<Map<String, String>> selectCommCdList(String grCd) {
		return commcodeDao.selectCommCdList(grCd);
	}

	@Override
	public List<Map<String, String>> selectDeptNoList() {
		return commcodeDao.selectDeptNoList();
	}

}
