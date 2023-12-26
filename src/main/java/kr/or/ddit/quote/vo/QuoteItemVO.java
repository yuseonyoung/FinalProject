package kr.or.ddit.quote.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;

import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 9.      김도현       최초작성
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Data
public class QuoteItemVO implements Serializable{
	
	@NotNull
	private String qteCd;
	@NotNull
	private String itemCd;	//품목코드
	private String itemNm; //품목명
	
	@NotNull
	private double qteUprc;	//단가
	@NotNull
	private double qteQty;	//수량
	
	
	private ItemVO item;  // has a (1:1)
}



