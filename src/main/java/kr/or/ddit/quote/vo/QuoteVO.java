package kr.or.ddit.quote.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.grouphint.UpdateGroup;
import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * 
 * </pre>
 * @author 김도현
 * @since 2023. 11. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 9.      김도현       최초작성
 * 2023. 11. 10.	 김도현		ItemVO, CompanyVO (has a 관계) 추가작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Data
public class QuoteVO implements Serializable{
	
	private int qteNum;
	@NotBlank(groups = {UpdateGroup.class})
	private String qteCd;   //견적서코드
	@NotBlank
	private String qteDate;   //견적서일자
	
	private String qteStat;   //견적서 상태
	
	private String comCd;   //회사 코드
	
	private String comNm;
	
	private String empCd;   //사원 코드
	
	private String empNm;   //사원 이름
	
	private String btbQteCd;  //외부업체 코드
	
	private int qteUprc;	//안씀
	
	private int qteQty;	//안씀
	
	private String itemCd;	//안씀
	
	private CompanyVO company;  // has a 관계 company 
	
	private EmpVO employee;   //has a 관계 employee
	
	private List<QuoteItemVO> quoteItem;  //has many
	
}
