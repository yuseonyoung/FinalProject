package kr.or.ddit.invenAdjust.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.actInven.vo.ActInvenVO;
import lombok.Data;

/**
 * <pre>
 * 재고 보정
 * </pre>
 * 
 * @author 최광식
 * @since 2023. 11. 29.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 29.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */
@Data
public class InvenAdjustVO implements Serializable {

	@NotBlank
	private String errAdjCd;			//재고조정 코드
	private String errYn;				//오차여부
	private int errAdjQty;				//오차수량
	private String errAdjNote;			//적요
	private String realCd;				//실사코드
	@NotBlank
	private String itemCd;				//품목코드

	
	private ActInvenVO actInven;		//모든 데이터 가져올 vo

}
