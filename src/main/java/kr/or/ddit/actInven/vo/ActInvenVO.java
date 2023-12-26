package kr.or.ddit.actInven.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.invenAdjust.vo.InvenAdjustVO;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.storage.vo.ItemWareVO;
import kr.or.ddit.storage.vo.StorageVO;
import lombok.Data;

/**
 * <pre>
 * 
 * </pre>
 * 
 * @author 최광식
 * @since 2023. 11. 20.
 * @version 1.0
 * 
 *          <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 20.      최광식       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 *          </pre>
 */

@Data
public class ActInvenVO implements Serializable {

	private String realCd;			//일련번호
	@NotBlank
	private String rinvDate;		//일자
	@NotBlank
	private String empCd;			//담당자코드
	@NotBlank
	private String wareCd;			//창고코드
	@NotBlank
	private String secCd;			//섹터코드
	
	//창고명 꺼내올 VO
	private StorageVO storage;
	
	//품목명 꺼내올 VO
	private ItemVO item;
	
	private String itemCd;
	
	//담당자명 꺼내올 VO
	private EmpVO emp;
	
	private int totalWareQty;
	
	private int realCdCount;
	
	private String errAdjNote;
	
	//오차수량
	private int errorQty;
	
	private InvenAdjustVO invenAdjust;
	
	private String errAdjCd;
	
	private String storCd;	
	
	private String storRsn;
	
	//1:n
	private List<ActInvenItemVO> actIvenItem;
	
	private String searchType;
	private String searchWord;

}
