package kr.or.ddit.storage.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.storage.dao.SectorDAO;
import kr.or.ddit.storage.vo.ItemWareVO;
import kr.or.ddit.storage.vo.WareSecVO;
import lombok.extern.slf4j.Slf4j;

@Service 
public class SectorServiceImpl implements SectorService {
	@Inject
	private SectorDAO sectorDao;
	
	@Override
	public List<WareSecVO> retrieveSelectSectorItem(WareSecVO wareSecVO) {
		
		List<WareSecVO> secList =  sectorDao.selectSectorItemList(wareSecVO);
		
		return secList;
	}

	@Override
	public List<WareSecVO> retrieveSelectSectorItems(WareSecVO wareSecVO) {
		List<WareSecVO> secList =  sectorDao.selectSectorItemsList(wareSecVO);
		
		return secList;
	}
	
	@Override
	public ServiceResult createOrModifySector(List<WareSecVO> wareSecList) {
		ServiceResult result = null;
		
		ArrayList<Integer> results = new ArrayList<Integer>();
		for(WareSecVO wareSecVO : wareSecList) {
			int insertResult = sectorDao.insertWareSector(wareSecVO);
			
			if(insertResult == 0) {
				int updateResult = sectorDao.updateWareSector(wareSecVO);
				results.add(updateResult);
			} 
		}
		if(results.contains(0)) {
			result = ServiceResult.FAIL;
		} else {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public ServiceResult CreateMergeItemWare(List<ItemWareVO> itemWareList) {	
		ServiceResult result = null;
		
		ArrayList<Integer> results = new ArrayList<Integer>();
		
		for(ItemWareVO itemWareVO : itemWareList) {
			int mergeResult = sectorDao.mergeItemWare(itemWareVO);
			results.add(mergeResult);
		}
		
		if(results.contains(0)) {
			result = ServiceResult.FAIL;
		} else {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public ServiceResult removeWareSector(WareSecVO wareSecVO) {
		ServiceResult result = null;
		
		int deleteResult = sectorDao.removeWareSector(wareSecVO);
		
		if(deleteResult == 0 ) {
			result = ServiceResult.NOTEXIST;
		} else {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	
}
