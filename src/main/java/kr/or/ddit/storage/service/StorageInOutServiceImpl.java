package kr.or.ddit.storage.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.order.dao.OrderPlayDAO;
import kr.or.ddit.rels.dao.RelsDAO;
import kr.or.ddit.storage.dao.SectorDAO;
import kr.or.ddit.storage.dao.StorageInOutDAO;
import kr.or.ddit.storage.vo.InventoryReceiptPaymentVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class StorageInOutServiceImpl implements StorageInOutService {
	@Inject
	private RelsDAO relsDao;
	
	@Inject
	private StorageInOutDAO inOutDao;
	@Inject
	private OrderPlayDAO orderDao;
	@Inject
	private SectorDAO sectorDao;
	
	@Override
	public List<Map<String, Object>> retrieveShippingProcessForm() {
		List<Map<String, Object>> relsList = relsDao.shippingProcessForm();
		return relsList;
	}

	@Override
	public ServiceResult createStorageOut(List<Map<String, Object>> outMap) {
		
		int[] resultCnt = new int[outMap.size()];
		List<String> rdrecCdArray = new ArrayList<String>();
		List<Integer> updateResult = new ArrayList<Integer>();
		
		for(int i=0; i<outMap.size();i++) {
			int cnt = inOutDao.storageOutInsert(outMap.get(i));	
			resultCnt[i] = cnt;
			String values = (String)outMap.get(i).get("rdrecCd");
			rdrecCdArray.add(values);
		}
		
		ServiceResult result = null;
		//배열중 0이 하나라도 있으면 fail
		if(Arrays.stream(resultCnt).anyMatch(count -> count == 0)) {
			result = ServiceResult.FAIL;
		}else {
			//상태 업데이트를 위한 for문
			result = ServiceResult.OK;
			for(String rdrecCd : rdrecCdArray) {
				int count = relsDao.updateRelsStat(rdrecCd);
				updateResult.add(count);
			}
			if(updateResult.contains(0)) {
				result = ServiceResult.FAIL;
			}else {
				result = ServiceResult.OK;
			}
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> retrievePurOrderConfirmed() {
		List<Map<String, Object>> pocList = orderDao.purOrderConfirmed();
		return pocList;
	}

	@Override
	public ServiceResult createStorageIn(List<InventoryReceiptPaymentVO> inValue) {
		
		int[] resultCnt = new int[inValue.size()];
		List<String> pordCdArray = new ArrayList<String>();
		List<Integer> updateResult = new ArrayList<Integer>();
		
		for(int i=0; i<inValue.size();i++) {
			int cnt = inOutDao.storageInInsert(inValue.get(i));
			resultCnt[i] = cnt;
			String values = inValue.get(i).getPordCd();
			pordCdArray.add(values);
		}
		
		ServiceResult result = null;
		//배열중 0이 하나라도 있으면 fail
		if(Arrays.stream(resultCnt).anyMatch(count -> count == 0)) {
			result = ServiceResult.FAIL;
		}else {
			//상태 업데이트를 위한 for문
			result = ServiceResult.OK;
			for(String prodCd : pordCdArray) {
				int count = orderDao.purOderStatUpdate(prodCd);
				updateResult.add(count);
			}
			if(updateResult.contains(0)) {
				result = ServiceResult.FAIL;
			}else {
				result = ServiceResult.OK;
			}
		}
		log.info("@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!{}",result);
		return result;
	}
	
	public ServiceResult createStorageInOut(List<InventoryReceiptPaymentVO> inValue) {
		ServiceResult result = null;
		
		ArrayList<Integer> results = new ArrayList<Integer>();
		int count = 0;
		for(InventoryReceiptPaymentVO inVal : inValue) {
			int insertResult = 0;

			if(count%2==0) {
				inVal.setStorCate("B002");
				inVal.setStorRsn("C007");
				int inResult = inOutDao.storageInInsert(inVal);
				int deleteResult = sectorDao.removeItemWare(inVal);
				
				if(inResult > 0 && deleteResult > 0) {
					insertResult = 1;
				}
			} else {
				inVal.setStorCate("B001");
				inVal.setStorRsn("C007");
				insertResult = inOutDao.storageInInsert(inVal);
			}
			
			results.add(insertResult);
			count++;
		}
		
		if(results.contains(0)) {
			result = ServiceResult.FAIL;
		} else {
			result = ServiceResult.OK;
		}
		
		return result;
	}
}
