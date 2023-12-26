package kr.or.ddit.storage.vo;


import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 15.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 15.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Data
@EqualsAndHashCode(of = {"itemCd","wareCd","secCd2"})
public class ItemWareVO implements Serializable{
	@NotBlank
	private String itemCd;
	@NotBlank
	private String itemNm;
	@NotBlank
	private String wareCd;
	@NotBlank
	private String secCd2;
	@NotNull
	private Integer wareQty;
	
	private ItemVO itemVO;
	
	private String wareNm;
	
	private String searchType;
	private String searchWord;

}
