package kr.or.ddit.sale.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.grouphint.UpdateGroup;
import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 24.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 24.      김도현       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Data
public class SaleItemVO implements Serializable{
	
	@NotNull
	private String saleCd;
	@NotNull
	private String itemCd;
	private String itemNm; //품목명
	@NotNull
	private Integer saleUprc;
	@NotNull
	private Integer saleQty;
	
	private ItemVO item;  // has a (1:1)
	
	
}
