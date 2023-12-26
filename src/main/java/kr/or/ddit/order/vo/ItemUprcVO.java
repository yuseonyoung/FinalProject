package kr.or.ddit.order.vo;

import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;

@Data
public class ItemUprcVO {
	private String itemCd;
	private String cqteCd;
	private String uprcConf;
	private Integer inUprc;
	private String uprcEdate;
	
	private ComQteVO comQte; //has a 관계 (1:1)
	
	private ItemVO item; // has a 관계(1:1)
	
}
