package kr.or.ddit.draft.vo;

import java.util.List;

import org.springframework.lang.Nullable;

import kr.or.ddit.order.vo.PurOrdItemVO;
import lombok.Data;

/**
 * @author 우정범
 * @since 2023. 12. 4.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 12. 4.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Data
public class DraftOrderVO {
	
	private String pordCd; //발주코드
	private String pordDate; //발주일자
	private String pordStat; // 발주진행상태
	private String dueDate; // 납기일자
	@Nullable
	private String cqteCd; //견적서코드
	@Nullable
	private String pplanCd; // 발주계획서코드
	@Nullable
	private String empCd; //발주서 담당자
	
	@Nullable
	private String nQty;
	
	private String itemNm;
    private String itemUnit;
    private String itemCd;
    private String pordQty;
    private String empNm;
    private String comNm;
    private String comNo;
    private String comCeo;
    private String comTel;
    private String comAddr;
    private String comDaddr;
    private String comFax;
    private String comMn;
	
	
	// 발주서 품목
	private List<PurOrdItemVO> purOrdItem;

}
