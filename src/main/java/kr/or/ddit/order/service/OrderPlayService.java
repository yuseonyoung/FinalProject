package kr.or.ddit.order.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.employee.vo.EmpVO;
import kr.or.ddit.order.vo.ItemUprcVO;
import kr.or.ddit.order.vo.PurOrdItemVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.vo.PaginationInfo;

public interface OrderPlayService {
	//리스트 조회
	public void retrieveOrderPlay(PaginationInfo<PurOrdVO> paging);
	//List<PurOrdVO> retrieveOrderPlay();
	//상세리스트 조회
	List<PurOrdVO> retrieveOrderPlayDetail(String pordCd);
	//발주넣을 회사 조회
	List<ItemUprcVO> retrieveDealCompany();
	//회사 조회
	List<CompanyVO> retrieveCompany();
	//발주넣을 품목 조회
	List<ItemUprcVO> retrieveDealItem();
	//발주넣을 품목 조회 (거래처 선택된 상태)
	List<ItemUprcVO> retrieveDealItemSpecial(String comCd);
	//발주 책임 사원
	List<EmpVO> retrieveResponsibleEmp();
	//service에서 발주서 만들어주기
	public ServiceResult createOrder(List<Map<String, String>> rowData);
	//insert 발주서
	public ServiceResult createOrderPlay(PurOrdVO po);
	
	public ServiceResult createOrderPlayItem(PurOrdItemVO poi);
	//발주서 현황 조회
	public List<Map<String, Object>> orderPlayCurrnetRetrieve(Map<String, Object> orderPlayParam);
	
	public List<Map<String, Object>> orderPlayDetailRetrieve(String pordCd);
	
	
}
