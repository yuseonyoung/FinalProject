package kr.or.ddit.storage.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = {"wareCd", "secCd"})
@Data
public class WareSecVO {
	@NotBlank
	private String wareCd;
	@NotBlank
	private String secCd;
	@NotNull
	private double wsecX1;
	@NotNull
	private double wsecY1;
	@NotNull
	private int wsecZ;
	
	@NotNull
	private double wsecX2;
	@NotNull
	private double wsecY2;
	
	private List<ItemWareVO> itemWareList;
}
