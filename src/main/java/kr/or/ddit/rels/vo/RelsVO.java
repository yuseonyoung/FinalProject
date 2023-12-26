package kr.or.ddit.rels.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.grouphint.UpdateGroup;
import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;

/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 21.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 21.      김도현       최초작성
 * 2023. 11. 22.      김도현		 출하납기일자 및 출하상태 추가
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Data
public class RelsVO implements Serializable{
	private int rdrecNum;
	@NotBlank(groups = {UpdateGroup.class})
	private String rdrecCd;   //출하지시서 코드
	@NotBlank
	private String rdrecDate;   //출하지시서 일자
	
	private String comCd;   //회사 코드
	
	private String comNm;   //회사 이름
	
	private String empCd;   //사원 코드
	
	private String empNm;   //사원 이름
	
	//private String rdrecUprc;   //출하지시서 단가
	
	//private String rdrecQty;	//출하지시서 수량
	
	private String outQty;	// 출하 수량
	
	//private String itemCd;	// 품목 코드
	
	private String saleCd;  // 판매 코드
	
	private String rdrecStat;  //출하지시서 상태
	
	private String rdrecOutDate;  //출하 납기일자
	
	//private QuoteItemVO quoteItem;
	
	//private ItemVO item;   //has a 관계 item
	
	private CompanyVO company;  // has a 관계 company 추가 예정
	
	private EmpVO employee;   //has a 관계 employee
	
	private List<RelsItemVO> relsItem;  //has many

}
