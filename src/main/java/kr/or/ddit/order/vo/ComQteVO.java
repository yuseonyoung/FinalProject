package kr.or.ddit.order.vo;

import java.util.List;

import kr.or.ddit.company.vo.CompanyVO;
import lombok.Data;

@Data
public class ComQteVO {
	private String cqteCd;
	private String qteTitle;
	private String qteCont;
	private String upreqCd;
	private String comCd;
	
	private CompanyVO company; //has a 관계 (1:1)
	
	private List<ComQteItemVO> cqiVO;

}
