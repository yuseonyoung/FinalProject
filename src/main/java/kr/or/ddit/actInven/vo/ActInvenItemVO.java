package kr.or.ddit.actInven.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.storage.vo.ItemWareVO;
import lombok.Data;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 최광식
 * @since 2023. 11. 20.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */
@Data
public class ActInvenItemVO implements Serializable {

	@NotBlank
	private String realCd;
	@NotNull
	@Min(value = 0)
	private int rinvQty;
	@NotBlank
	private String itemCd;
	@NotNull
	private int itemNum;
	@NotBlank
	private ItemVO item;
	
	//재고수량 꺼내올 VO
	private ItemWareVO itemWare;
	
	private String itemDate;

}
