
package kr.or.ddit.item.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.config.annotation.authentication.configurers.userdetails.DaoAuthenticationConfigurer;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.item.dao.ItemDAO;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.storage.vo.StorageVO;

@Service
public class ItemServiceImpl implements ItemService{
	@Inject
	private ItemDAO itemDAO;

	@Override
	public void retrieveItemList(PaginationInfo<ItemVO> paging) {
		int totalRecord = itemDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<ItemVO> dataList = itemDAO.selectItemList(paging);
		paging.setDataList(dataList);
	}

	@Override
	public ServiceResult createItem(ItemVO itemVO) {
	
		int cnt = itemDAO.insertItem(itemVO);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifyItem(ItemVO itemVO) {
		int cnt = itemDAO.updateItem(itemVO);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifyUnUseItem(String itemCode) {
		int cnt = itemDAO.unUseUpdateItem(itemCode);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	@Override
	public ServiceResult modifyUseItem(String itemCode) {
		int cnt = itemDAO.useUpdateItem(itemCode);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}


	@Override
	public ServiceResult duplicateItemCode(String itemCode) {
		int cnt = itemDAO.duplicateItemCode(itemCode);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.PKDUPLICATED;
		}else {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ItemVO retrieveItemDetail(String itemCd) {
		return itemDAO.selectItem(itemCd);
	}

//	@Override
//	public List<ItemVO> retrieveSafetyItemList(PaginationInfo<ItemVO> paging) {
//		int totalRecord = itemDAO.selectTotalRecord(paging);
//		paging.setTotalRecord(totalRecord);
//		List<ItemVO> dataList = itemDAO.selectSafetyItemList(paging);
//		paging.setDataList(dataList);
//	}
	public List<ItemVO> retrieveItemListDataTable(StorageVO storageVO){
		
		return itemDAO.selectItemListDataTable(storageVO);
	}
}
