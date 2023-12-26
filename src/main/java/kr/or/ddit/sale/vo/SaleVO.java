package kr.or.ddit.sale.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.grouphint.UpdateGroup;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.quote.vo.QuoteItemVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author 김도현
 * @since 2023. 11. 8.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 8.      김도현       최초작성
 * 2023. 11. 21.	 김도현		판매단가,판매수량 추가
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 


@Data
public class SaleVO implements Serializable{
	
	private int saleNum;
	@NotBlank(groups = {UpdateGroup.class})
	private String saleCd;   //판매코드
	@NotBlank
	private String saleDate;	//판매일자
	
	private String saleStat;	//판매상태
	
	private String comCd;	//회사 코드
	
	private String comNm;   //회사 이름
	
	private String empCd;	//사원 코드
	
	private String empNm;	//사원 이름
	
	//private String saleUprc; //판매단가
	
	//private String saleQty;  //판매수량
	
	//private String itemCd;
	
	//private SaleItemVO saleItem;	
	
	private List<SaleItemVO> saleItem;	//has a 관계 item
	
	private CompanyVO company;	// has a 관계 company
	
	private EmpVO employee;   //has a 관계 employee
	
	
}
