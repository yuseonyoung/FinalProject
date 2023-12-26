package kr.or.ddit.storage.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
@EqualsAndHashCode(of = "secCd")
@Data
public class SectorVO {
	@NotBlank	
	private String secCd;
	

	private List<ItemWareVO> itemWareList;
}
