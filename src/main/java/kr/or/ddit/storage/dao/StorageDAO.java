package kr.or.ddit.storage.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.storage.vo.StorageVO;
import kr.or.ddit.util.commcode.vo.CommcodeVO;

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

@Mapper
public interface StorageDAO {
	

	/**
	 * 창고 전체조회
	 * 
	 * @return
	 */
	public List<StorageVO> selectStorageList();
	
	/**
	 * 
	 * 창고 상세조회
	 * 
	 * @param storageCd
	 * @return
	 */
	public StorageVO selectStorage(String wareCd);
	
	/**
	 * 
	 * 창고 등록
	 * 
	 * @param storageVO
	 * @return
	 */
	public int insertStorage(StorageVO storageVO);
	
	/**
	 * 
	 * 창고 수정 , 미사용도 이것으로 처리
	 * 
	 * @param int
	 * @return
	 */
	public int updateStorage(StorageVO storageVO);
	
	/**
	 * 
	 * 창고 담당자 구분 조회 코드
	 * 
	 * @return
	 */
	public CommcodeVO wareGroupList();
	
	/**
	 * 
	 * 창고 미사용 처리
	 * 
	 * @param wareCode
	 * @return
	 */
	public int unUseUpdateStorage(String wareCode);
	
	
	/**
	 * 
	 * 창고별 구역 조회
	 * 
	 * @param wareCd
	 * @return
	 */
	public List<StorageVO> selectStorageSectorList(String wareCd);

	
	/**
	 * sector의 값도 가져오는 storageList
	 * 
	 * @return
	 */
	public List<HashMap<String, Object>> selectStorageSecList();
	/**
	 * 
	 * 창고 사용 처리
	 * 
	 * @param wareCode
	 * @return
	 */
	public int useUpdateStorage(String wareCode);

}
