package kr.or.ddit.item.vo;

import lombok.Data;

@Data
public class ItemDetailVO {
	private String itemCd;
	private String itemNm;
	private String rmstDate;
	private String storCate;
	private String comNm;
	private String rmstNote;
	private String wareCd;
	private String storRsn;
	private int    rmstInQty;
	private int    rmstOutQty;
	private int    rmstSelfQty;
	private int    rmstInitQty;
	private int    jaego;
}
