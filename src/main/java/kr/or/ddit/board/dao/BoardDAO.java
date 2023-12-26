package kr.or.ddit.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardVO;

/**
 * <pre>
 * 
 * </pre>
 * @author 황수빈
 * @since 2023. 11. 20.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      황수빈       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Mapper
public interface BoardDAO {

	public int createPost(BoardVO boardVO);

	public String list(BoardVO boardVO);

	public int pageCreatePost(BoardVO boardVO);

	public BoardVO pageDetail(BoardVO boardVO);

	public BoardVO pageSelect(BoardVO boardVO);

	public List<BoardVO> boardList(Map<String, String> map);

	public int total(Map<String, String> map);

	public int pageUpdateHit(BoardVO boardVO);

	public int pageDetailUpdate(BoardVO boardVO);

	public int pageDetailUpdatePost(BoardVO boardVO);

	public int pageDetailDelete(BoardVO boardVO);
}
