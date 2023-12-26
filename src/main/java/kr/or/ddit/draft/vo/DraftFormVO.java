package kr.or.ddit.draft.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DraftFormVO {
	  
		private int dformNo;
		private Date dformWdate;
	    private String dformNm;
	    private String dformExpl;
	    private String dformYn;
	    private String dformCont;

}
