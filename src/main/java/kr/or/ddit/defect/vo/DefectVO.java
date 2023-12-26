package kr.or.ddit.defect.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.vo.SearchVO;
import kr.or.ddit.storage.vo.StorageVO;
import lombok.Data;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 최광식
 * @since 2023. 11. 10.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 10.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */
@Data
public class DefectVO implements Serializable {

	private int defNum;
	private String defProcCd;	//일련번호
	@NotBlank
	private String defCd;		//불량코드
	@NotBlank
	private String itemCd;		//품목코드
	@NotNull
	@Min(value = 1)
	private int defQty;			//수량
	@NotBlank
	private String defProc;		//처리방법
	@NotBlank
	private String defProcdate;	//처리일자
	@NotBlank
	private String wareCd;		//발견창고
	
	private String defNote;		//적요

	@NotBlank
	//불량명 comm_cd_nm
	private String defNm;		//불량명
	
	// 품목명
	private ItemVO item;		//품목VO
	// 창고명
	private StorageVO storage;	//창고명
	
	@NotBlank
	private String empCd;		//담당자코드
	@NotBlank
	private String empNm;		//사원명
	
	private String secCd;		//섹터명
	
	private String storCd;
	
//	private SearchVO search;
	private String searchType;
	private String searchWord;
}
