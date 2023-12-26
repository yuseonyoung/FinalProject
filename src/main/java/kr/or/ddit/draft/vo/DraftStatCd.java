package kr.or.ddit.draft.vo;

/**
 * 기안 상태 공통 코드 Enum
 * @author 우정범
 *
 */
public enum DraftStatCd {
	COMPLETE("L001")
	, DURING("L002")
	, REJECT("L003")
	, TEMP("L004")
	, RETRIEVE("L005");
	
	private String dlineStatCd;
	
	DraftStatCd(String dlineStatCd) {
		this.dlineStatCd = dlineStatCd;
	}

	public String getDraftStatCd() {
		return dlineStatCd;
	}
	
}
