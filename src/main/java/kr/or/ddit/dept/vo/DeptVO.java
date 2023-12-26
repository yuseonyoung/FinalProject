package kr.or.ddit.dept.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author 우정범
 * @since 2023. 11. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 9.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

@Data
@EqualsAndHashCode(of = "deptNo")
public class DeptVO {
	
	private int deptNo;
	private int supDeptNo;
	private String empCd;
	private String deptNm;
	private String deptYn;
	private String deptRegDate;
	private String deptDelDate;
}
