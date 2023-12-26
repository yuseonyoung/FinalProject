package kr.or.ddit.common.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.dao.CommCdDao;
import kr.or.ddit.common.vo.CommCdVO;
import kr.or.ddit.common.vo.GrpCdVO;

@Service
public class CommCdServiceImpl implements CommCdService {

	@Inject
	private CommCdDao commCdDao;
	
	@Override
	public List<GrpCdVO> groupCodeList() {
		return commCdDao.groupCodeList();
	}

	@Override
	public List<CommCdVO> commonCodeList() {
		return commCdDao.commonCodeList();
	}

	@Override
	public List<CommCdVO> commonCodeName() {
		return commCdDao.commonCodeName();
	}

	@Override
	public int codeAct(String commCd) {
		return commCdDao.codeAct(commCd);
	}

	@Override
	public String maxCommonCode(@Param("grCd") String grCd) {
		return commCdDao.maxCommonCode(grCd);
	}

	@Override
	public int createCommonCode(CommCdVO commCdVO) {
		return commCdDao.createCommonCode(commCdVO);
	}

}
