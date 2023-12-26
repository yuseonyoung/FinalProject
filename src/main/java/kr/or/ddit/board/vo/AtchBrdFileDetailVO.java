package kr.or.ddit.board.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

//AtchBrdFileDetail : ATCH_FILE_DETAIL테이블
@Data
public class AtchBrdFileDetailVO {
	@NotEmpty
	private String atchFileId;	//첨부파일ID
	@NotNull
	private int fileSn;	//파일순번
	private String fileStreCours;	//파일저장경로(물리경로)
	private String streFileNm;	//저장파일명(웹경로)
	private String orignlFileNm;	//원본파일명(사용자의 처음 파일명)
	private String fileExtsn;	//파일확장자
	private String fileCn;	//파일내용
	private long fileSize;	//파일크기
}

