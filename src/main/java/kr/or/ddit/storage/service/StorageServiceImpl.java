package kr.or.ddit.storage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.storage.dao.StorageDAO;
import kr.or.ddit.storage.vo.ItemWareVO;
import kr.or.ddit.storage.vo.StorageVO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 9.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 9.      유선영      전체조회 시도
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
@Slf4j
@Service
public class StorageServiceImpl implements StorageService {
	
	@Inject
	private StorageDAO storageDAO;
	

	@Override
	public List<StorageVO> retrieveStorageList() {
		return storageDAO.selectStorageList();
	}

	@Override
	public ServiceResult createStorage(StorageVO storageVO) {
		int cnt = storageDAO.insertStorage(storageVO);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifyStorage(StorageVO storageVO) {
		int cnt = storageDAO.updateStorage(storageVO);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult modifyUnUseStorage(String wareCode) {
		int cnt = storageDAO.unUseUpdateStorage(wareCode);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public List<StorageVO> retrieveStorageSectorList(String wareCd) {
		// TODO Auto-generated method stub
		return storageDAO.selectStorageSectorList(wareCd);
	}
	
	@Override
	public List<HashMap<String, Object>> retrieveStorageSecList(){
		
		List<HashMap<String, Object>> collectStor = new ArrayList<>();
		List<HashMap<String, Object>> storDao = storageDAO.selectStorageSecList();
		for(int i=0; i< storDao.size(); i++) {
			if(i>0) {
				if(!storDao.get(i).get("wareCd").equals(storDao.get(i-1).get("wareCd"))) {				
					collectStor.add(storDao.get(i));
				}
			}else {
				collectStor.add(storDao.get(i));
			}
				
		}
		//List<HashMap<String, Object>> collectStor = storageDAO.selectStorageSecList();
		return collectStor;
	}

	@Override
	public StorageVO retrieveStorageDetail(String wareCd) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult modifyUseStorage(String wareCode) {
		int cnt = storageDAO.useUpdateStorage(wareCode);
		ServiceResult result = null;
		if(cnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
}
