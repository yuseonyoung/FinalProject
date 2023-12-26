package kr.or.ddit.order.vo;

import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;

@Data
public class OrderUnitPriceItemVO {
	private String uprcItCd; //단가요청품목
	private String upreqCd; //단가요청코드
	private String itemCd; //품목코드
	private Integer uprcItQty; //단가요청품목수량
	private String upreqDur; //거래기간
	
	
	
	private ItemVO item; // has a (1:1)

}
