package kr.or.ddit.draft.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DraftPrxVO {

	private int prxNo;
	private String empCd;
	private String prxId;
	private Date prxSdate;
	private Date prxEdate;
}
