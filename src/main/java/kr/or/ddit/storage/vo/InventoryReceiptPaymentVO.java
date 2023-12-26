package kr.or.ddit.storage.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.item.vo.ItemVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "storCd")
public class InventoryReceiptPaymentVO implements Serializable{
	private String storCd;

	@NotBlank
	private String itemCd;
	@NotNull
	@Min(1)
	private int rmstQty;
	@NotBlank
	private String rmstDate;
	private String rmstNote;
	private String storCate;
	private String storRsn;
	@NotBlank
	private String wareCd;
	@NotBlank
	private String secCd2;
	//검색 마지막일자
	private String rmstLdate;
	//검색 시작일자
	private String rmstSdate;
	
	private String pordCd;
	private String saleCd;
	private List<ItemVO> itemList;
	
	

}
