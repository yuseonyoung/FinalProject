package kr.or.ddit.schedule.vo;

import lombok.Data;


/**
 * @author 우정범
 * @since 2023. 11. 18.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 18.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Data
public class ScheduleVO {

	private String schdNo;
	private String empCd;
	private String deptNo;
	private String schdTitle;
	private String schdCont;
	private String schdSdate;
	private String schdEdate;
	private String schdRdate;
	private String schdYn;
	private String delYn;
	private String delDt;

}
