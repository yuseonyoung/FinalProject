package kr.or.ddit.order.vo;

import java.util.List;

import lombok.Data;

@Data
public class SelectUnitPriceVO {

	private String upreqCd;         //단가요청코드       
	private String comCd;           //회사코드 
	private String comNm;			//회사명       
	private String empCd;           //사원코드
	private String empNm;           //사원명            
	private String dueDate;         //납기일자
	
	private List<SelectUnitPriceItemVO> dataList;
	

}
