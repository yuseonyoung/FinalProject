package kr.or.ddit.order.vo;

import java.util.List;

import org.springframework.lang.Nullable;

import lombok.Data;

@Data
public class OrderUnitPriceVO {
	
	private String upreqCd; //단가요청코드 
	private String upreqDate; //단가요청일자
	private String upreqStat; // 단가요청진행상태
	private String upreqValDate; //유효기간
	
	private String empCd; //사원코드
	private String pplanCd; //발주계획서
	
	@Nullable
	private String itemNm;
	
	//신범종이 추가 
	@Nullable
	private String nQty;
	
	@Nullable
	private String empNm;
	
	private List<OrderUnitPriceItemVO> orderUnitPriceItem; //has many
	
	

}
