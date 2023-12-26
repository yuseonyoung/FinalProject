package kr.or.ddit.storage.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.storage.vo.InventoryReceiptPaymentVO;

public interface StorageInOutService {
	
	/**
	 * 출하 확정을 위한 Form List 데이터 출력
	 * 
	 * @return
	 */
	public List<Map<String,Object>> retrieveShippingProcessForm();

	/**
	 * 
	 * 출하 확정을 위한 insert 데이터
	 * 
	 * @param outMap
	 * @return
	 */
	public ServiceResult createStorageOut(List<Map<String,Object>> outMap);
	
	/**
	 * 입고 확정을 위한 Form List 데이터출력
	 * 
	 * @return
	 */
	public List<Map<String,Object>> retrievePurOrderConfirmed();
	
	/**
	 * 
	 * 입고 확정을 위한 insert 데이터
	 * 
	 * @param inValue
	 * @return
	 */
	public ServiceResult createStorageIn(List<InventoryReceiptPaymentVO> inValue);
	
	/**
	 * 
	 * 창고 이동을 위한 insert
	 * 
	 * @param inValue
	 * @return
	 */
	public ServiceResult createStorageInOut(List<InventoryReceiptPaymentVO> inValue);
}
