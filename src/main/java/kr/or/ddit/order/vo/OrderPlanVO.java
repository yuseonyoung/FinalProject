package kr.or.ddit.order.vo;

import org.springframework.lang.Nullable;

import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;
import lombok.Data;

@Data
public class OrderPlanVO {
	
	private String pplanCd;
	private String pplanDate;
	private String pplanStat;
	private String empCd;
	private String preqCd;
	
	//신범종이 추가 
	@Nullable
	private String nQty;
	
	private PurOrderRequestVO purOrderRequeset; // has a (1:1)
	private EmpVO emp; //has s (1:1)
	

}
