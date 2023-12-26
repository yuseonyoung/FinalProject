package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.ReplVO;

public interface ReplService {

	public ReplVO replSelect(ReplVO replVO);

	public List<ReplVO> replList(ReplVO replVO);

	public int createPost(ReplVO replVO);

	//댓글 수정
	public int updatePost(ReplVO replVO);
	
	//댓글 삭제
	public int deletePost(ReplVO replVO);
	

	
}
