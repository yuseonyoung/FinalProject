package kr.or.ddit.item.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.grouphint.UpdateGroup;
import kr.or.ddit.order.vo.ItemUprcVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(of = "itemCd")
@Data
public class ItemVO implements Serializable{
	@NotBlank
	private String itemCd;		// 품목코드
	@NotBlank
	private String itemNm;		// 품목명
	@NotBlank
	private String itemUnit;	// 품목단위
	@NotBlank
	private String itemCate;	// 품목그룹
	private int itemSafeQty;	// 안전재고수령
	private String itemYn;		// 사용중단여부
	private String itemNote;	// 품목적요
	private String itMaker;     // 제조사
	private String itWght;      // 무게
	private String itColor;     // 색상
	private int itemInpr;       // 입고단가
	private int itemOutpr;      // 출고단가
	private boolean itemBoolean;
	private int itemQty;        //아이템수량
	private String orderFrag;   //정렬조건    
	private String itCateNm;	//분류명
	
	//신범종이 추가
	private List<ItemUprcVO> itemUprc; // has many(1:N)
	
	//중호쌤 추가(재고수불부현황)
	private List<ItemDetailVO> itemDetailVOList;
	
	public void setItemYn(String itemYn) {
		this.itemYn = itemYn;
		
		if(itemYn.equals("Y")) {
			this.itemBoolean = true;
		} else {
			this.itemBoolean = false;
		}
	}
	
	private String searchType;
	private String searchWord;
}
