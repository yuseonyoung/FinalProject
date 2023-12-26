package kr.or.ddit.order.vo;

import org.springframework.lang.Nullable;

import lombok.Data;

@Data
public class egaemajaVO {
	private Integer reqItemQty;
	private Integer inUprc;
	private String expired;
	private String empNm;
	private String comCd;
	private String comNm;
	private String itemCd;
	private String itemNm;
	private String pplanDate;
	private String pplanCd;
	@Nullable
	private String empCd;
	@Nullable
	private String abcd;


}
