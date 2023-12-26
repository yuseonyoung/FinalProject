
package kr.or.ddit.notice.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.notice.vo.NoticeVO;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 황수빈
 * @since 2023. 11. 20.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      황수빈       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */
public interface NoticeService {

	public int createPost(NoticeVO noticeVO);

	public NoticeVO detail(NoticeVO noticeVO);

	public List<NoticeVO> noticeList(Map<String, String> map);

	public NoticeVO pageDetail(NoticeVO noticeVO);

	public NoticeVO pageSelect(NoticeVO noticeVO);

	public int pageCreatePost(NoticeVO noticeVO);

	public int pageDetailUpdate(NoticeVO noticeVO);

	public int pageDetailDelete(NoticeVO noticeVO);

	public int pageUpdateHit(NoticeVO noticeVO);

	int total(Map<String, String> map);

	// 공지사항 전체 행의 수 public int total(Map<String, String> map);

}
