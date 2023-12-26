package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.ReplVO;

@Mapper
public interface ReplDAO {

	public ReplVO replSelect(ReplVO replVO);

	public List<ReplVO> replList(ReplVO replVO);

	public int createPost(ReplVO replVO);

	//댓글 수정
	public int updatePost(ReplVO replVO);
	
	public int deletePost(ReplVO replVO);
}
