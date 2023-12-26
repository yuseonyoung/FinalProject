package kr.or.ddit.purOrderRequest.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = {"preqCd","itemCd"})
@Data
public class ReqItemVO {
	private String preqCd;
	@NotBlank
	private String itemCd;
	@NotNull
	private Integer reqItemQty;
	private String reqNote;
	private String newItemCd;
	private ItemVO item; //has a (1:1)
}
