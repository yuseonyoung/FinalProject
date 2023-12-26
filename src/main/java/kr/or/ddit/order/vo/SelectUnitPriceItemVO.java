package kr.or.ddit.order.vo;

import lombok.Data;

@Data
public class SelectUnitPriceItemVO {
	private String itemCd;          //품목코드 
	private String itemNm;       	//품목명           
	private Integer cqteItQty;      //품목수량
	private Integer cqteItUprc;		//품목단가
	private String upreqValDate;    //단가책정종료일자(단가요청진행상태)

}
