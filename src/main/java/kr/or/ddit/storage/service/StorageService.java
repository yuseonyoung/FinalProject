package kr.or.ddit.storage.service;

import java.util.HashMap;
import java.util.List;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.storage.vo.ItemWareVO;
import kr.or.ddit.storage.vo.StorageVO;

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
 * 2023. 11. 9.      유선영      조회,상세조회,수정,등록,미사용 등록
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 

public interface StorageService {
	/**
	 * 창고 전체조회
	 * 
	 * @return
	 */
	public List<StorageVO> retrieveStorageList();
	
	/**
	 * 
	 * 창고 상세조회
	 * 
	 * @param storageCd
	 * @return
	 */
	public StorageVO retrieveStorageDetail(String wareCd);
	
	/**
	 * 
	 * 창고 등록
	 * 
	 * @param storageVO
	 * @return
	 */
	public ServiceResult createStorage(StorageVO storageVO);
	
	/**
	 * 
	 * 창고 수정
	 * 
	 * @param storageVO
	 * @return
	 */
	public ServiceResult modifyStorage(StorageVO storageVO);
	
	/**
	 * 
	 * 미사용 처리
	 * @param wareCode
	 * @return
	 */
	public ServiceResult modifyUnUseStorage(String wareCode);
	
	/**
	 * 
	 * 창고별 구역 조회
	 * 
	 * @param wareCd
	 * @return
	 */
	public List<StorageVO> retrieveStorageSectorList(String wareCd);
	
	/**
	 * 창고조회에 구역의 유무까지
	 * 
	 * @return
	 */
	public List<HashMap<String, Object>> retrieveStorageSecList();
	
	/**
	 * 
	 * 사용 처리
	 * @param wareCode
	 * @return
	 */
	public ServiceResult modifyUseStorage(String wareCd);
}
