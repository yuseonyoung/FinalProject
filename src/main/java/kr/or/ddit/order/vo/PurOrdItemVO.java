package kr.or.ddit.order.vo;

import org.springframework.lang.Nullable;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;

@Data
public class PurOrdItemVO {
	private String itemCd; // 품목코드
	private String pordCd; // 발주코드
	private int pordQty; // 발주수량
	private int pordUprc; // 발주단가
	private int itemInQty; // 입고수량
	@Nullable
	private String comCd; //회사코드
	
	private ItemVO item; // has a (1:1)
	private CompanyVO company; //has a (1:1)

}
