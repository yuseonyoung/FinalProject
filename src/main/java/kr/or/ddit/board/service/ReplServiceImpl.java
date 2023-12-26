package kr.or.ddit.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.dao.ReplDAO;
import kr.or.ddit.board.vo.ReplVO;

@Service
public class ReplServiceImpl implements ReplService{
	
	@Autowired
	private ReplDAO replDAO;
	
	@Override
	public ReplVO replSelect(ReplVO replVO) {
		return this.replDAO.replSelect(replVO);
	}

	@Override
	public List<ReplVO> replList(ReplVO replVO) {
		
		return this.replDAO.replList(replVO);
	}

	@Override
	public int createPost(ReplVO replVO) {
		
		return this.replDAO.createPost(replVO);
	}

	//댓글 수정
	@Override
	public int updatePost(ReplVO replVO) {
		return this.replDAO.updatePost(replVO);
	}

	@Override
	public int deletePost(ReplVO replVO) {
		
		return this.replDAO.deletePost(replVO);
	}
	
}
