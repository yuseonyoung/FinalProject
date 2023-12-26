package kr.or.ddit.order.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.order.vo.OrderUnitPriceItemVO;
import kr.or.ddit.order.vo.OrderUnitPriceVO;
import kr.or.ddit.order.vo.PurOrdItemVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.vo.PaginationInfo;

public interface OrderUnitPriceService {
	//조회 ! 
	List<OrderUnitPriceVO> retrieveOrderUnitPrice();
	//조회 ! 
	public void retrieveOrderUnitPrice(PaginationInfo<OrderUnitPriceVO> paging);
	//상세조회 ! 
	List<OrderUnitPriceVO> retrieveUnitPrice(String upreqCd);
	
	
	List<Map<String, Object>> retrieveUnitPrice1(String upreqCd);
	
	//insert 발주서
	public ServiceResult createOrderPlay(PurOrdVO po);
	
	public ServiceResult createOrderPlayItem(PurOrdItemVO poi);
	
	
	ServiceResult createUnitPrice(OrderUnitPriceVO unitPriceVO);
	
	//단가요청서 거래기간 및 수량 수정
	ServiceResult modifyUnitPriceDetail( List<Map<String, String>> orderUnitPriceData);
	ServiceResult createUnitPriceOne( List<Map<String, String>> createUnitPriceOne);
	
	ServiceResult modifyUnitPriceDetail(OrderUnitPriceVO oup);
	
	ServiceResult modifyUnitPriceDetail(OrderUnitPriceItemVO oupi);
	
	//끝
	ServiceResult modifyUnitPrice(OrderUnitPriceVO unitPriceVO);
	
	ServiceResult removeUnitPrice(int nooo); // 삭제기능의 유무 
	
}
