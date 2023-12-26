package kr.or.ddit.rels.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;

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
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Data
public class RelsItemVO implements Serializable{
	
	@NotNull
	private String rdrecCd;
	@NotNull
	private String itemCd;
	@NotNull
	private Double rdrecUprc;
	@NotNull
	private Double rdrecQty;
	
	private String outQty;
	
	private ItemVO item;   //has many
}
