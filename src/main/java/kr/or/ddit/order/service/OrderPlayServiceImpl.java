package kr.or.ddit.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.order.dao.OrderPlayDAO;
import kr.or.ddit.order.vo.ItemUprcVO;
import kr.or.ddit.order.vo.PurOrdItemVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderPlayServiceImpl implements OrderPlayService{
	
	private final OrderPlayDAO orderPlayDAO;
	
	/*
	 * @Override public List<PurOrdVO> retrieveOrderPlay() { List<PurOrdVO> poList =
	 * orderPlayDAO.selectOrderPlayList(); return poList; }
	 */
	
	@Override
	public List<PurOrdVO> retrieveOrderPlayDetail(String pordCd) {
		List<PurOrdVO> poDetailList = orderPlayDAO.selectOrderPlayDetailList(pordCd);
		return poDetailList;
	}

	@Override
	public List<EmpVO> retrieveResponsibleEmp() {
		List<EmpVO> evoList = orderPlayDAO.selectResponsibleEmp();
		return evoList;
	}


	@Override
	public List<ItemUprcVO> retrieveDealCompany() {
		List<ItemUprcVO> dealComList = orderPlayDAO.selectDealCompanyList();
		return dealComList;
	}

	@Override
	public List<ItemUprcVO> retrieveDealItem() {
		List<ItemUprcVO> dealItemList = orderPlayDAO.selectDealItemList();
		return dealItemList;
	}

	@Override
	public List<ItemUprcVO> retrieveDealItemSpecial(String comCd) {
		List<ItemUprcVO> dealItemSpecialList = orderPlayDAO.selectDealItemSpecialList(comCd);
		return dealItemSpecialList;
	}
	
	//직접 발주 파트입니다.
	@Override
	public ServiceResult createOrder(List<Map<String, String>> rowData) {
		
		ServiceResult result = null;
		
		PurOrdVO povo = new PurOrdVO();
		
		povo.setPordDate(rowData.get(0).get("pordDate"));
		povo.setDueDate(rowData.get(0).get("dueDate"));
		povo.setEmpCd(rowData.get(0).get("empCd"));
		result =createOrderPlay(povo);
		
		for (int i = 0; i < rowData.size(); i++) {
			PurOrdItemVO poivo = new PurOrdItemVO();
			poivo.setComCd(rowData.get(i).get("comCd"));
			poivo.setItemCd(rowData.get(i).get("itemCd"));
			poivo.setPordQty(Integer.parseInt(rowData.get(i).get("pordQty")));
			poivo.setPordUprc(Integer.parseInt(rowData.get(i).get("pordUprc")));
			poivo.setItemInQty(0);
			result =createOrderPlayItem(poivo);
		}
		return result;
	}

	@Override
	public ServiceResult createOrderPlay(PurOrdVO po) {
		ServiceResult result = null;
		
		int aa=orderPlayDAO.insertPurOrd(po);
		if(aa>0) { 
			result = ServiceResult.OK; 
		}else { 
			result = ServiceResult.FAIL; 
			}
		
		return result; 
	}

	@Override
	public ServiceResult createOrderPlayItem(PurOrdItemVO poivo) {
		ServiceResult result = null;
		int aa=orderPlayDAO.insertPurOrdItem(poivo);
		if(aa>0) { 
			result = ServiceResult.OK; 
		}else { 
			result = ServiceResult.FAIL; 
			}
		
		return result; 
	}

	@Override
	public void retrieveOrderPlay(PaginationInfo<PurOrdVO> paging) {
		int totalRecord = orderPlayDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<PurOrdVO> dataList = orderPlayDAO.selectOrderPlayList2(paging);
		paging.setDataList(dataList);
		
	}

	@Override
	public List<Map<String, Object>> orderPlayCurrnetRetrieve(Map<String, Object> orderPlayParam) {
		List<Map<String, Object>> orderPlayList = orderPlayDAO.orderPlayCurrentList(orderPlayParam);
		
		
		return orderPlayList;
	}

	@Override
	public List<Map<String, Object>> orderPlayDetailRetrieve(String pordCd) {
		List<Map<String, Object>> orderPlayDetail = orderPlayDAO.selectOrderPlay(pordCd);
		if(orderPlayDetail != null) {
			return orderPlayDetail;
		}else {
			throw new RuntimeException("해당 발주서가 존재하지 않습니다.");
		}
	}

	@Override
	public List<CompanyVO> retrieveCompany() {
		List<CompanyVO> comList = orderPlayDAO.selectCompanyList();
		return comList;
	}

	
	
}
