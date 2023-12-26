package kr.or.ddit.empInfo.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

/**
 * @author 우정범
 * @since 2023. 12. 5.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 12. 5.      우정범       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Data
public class LogRecVO {

	private int logNo;
	private String logId;
	private String empCd;
	private String empNm;
	private String logStat;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date logDate;
	private String logIp;
	private String logNat;
	private int failCnt;
	private String logTime;
}
