package kr.or.ddit.storage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.actInven.vo.ActInvenVO;
import kr.or.ddit.defect.vo.DefectVO;
import kr.or.ddit.invenAdjust.vo.InvenAdjustVO;
import kr.or.ddit.storage.vo.InventoryReceiptPaymentVO;

@Mapper
public interface StorageInOutDAO {
	
	/**
	 * 
	 * 출하 확정을 위한 insert 데이터
	 * 
	 * @param outMap
	 * @return
	 */
	public int storageOutInsert(Map<String,Object> outMap);
	
	/**
	 * 
	 * 입고 확정을 위한 insert 데이터
	 * 
	 * @param inValue
	 * @return
	 */
	public int storageInInsert(InventoryReceiptPaymentVO inData);
	
	/**
	 * 재고 조정 내용 insert
	 * @param invenAdjustVO
	 * @return
	 */
	public int itemCorrectionInsert(ActInvenVO actInvenVO);

	/**
	 * 불량재고 입출고
	 * @param defectVO
	 * @return
	 */
	public int defectItemCorrectionInsert(DefectVO defectVO);
	
}
