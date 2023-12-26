package kr.or.ddit.order.vo;

import java.util.List;

import org.springframework.lang.Nullable;

import lombok.Data;

@Data
public class PurOrdVO {
	private String pordCd; //발주코드
	private String pordDate; //발주일자
	private String pordStat; // 발주진행상태
	private String dueDate; // 납기일자
	@Nullable
	private String cqteCd; //견적서코드
	@Nullable
	private String pplanCd; // 발주계획서코드
	@Nullable
	private String empCd; //발주서 담당자
	
	//신범종이 추가 
	@Nullable
	private String nQty;
	
	
	// 발주서 품목
	private List<PurOrdItemVO> purOrdItem;
	

}
