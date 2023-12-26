package kr.or.ddit.order.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.enumpkg.ServiceResult;
import kr.or.ddit.order.dao.OrderPlayDAO;
import kr.or.ddit.order.dao.OrderUnitPriceDAO;
import kr.or.ddit.order.vo.ComQteItemVO;
import kr.or.ddit.order.vo.ComQteVO;
import kr.or.ddit.order.vo.ItemUprcVO;
import kr.or.ddit.order.vo.OrderUnitPriceItemVO;
import kr.or.ddit.order.vo.OrderUnitPriceVO;
import kr.or.ddit.order.vo.PurOrdItemVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.vo.PaginationInfo;

@Service
public class OrderUnitPriceServiceImpl implements OrderUnitPriceService{
	
	@Inject
	private OrderUnitPriceDAO orderUnitPriceDAO;
	
	@Inject
	private OrderPlayDAO orderPlayDAO;
	
	
	@Override
	public List<OrderUnitPriceVO> retrieveOrderUnitPrice() {
		List<OrderUnitPriceVO> oupList = orderUnitPriceDAO.selectOrderUnitPriceList();
		
		return oupList;
	}
	

	@Override
	public ServiceResult createUnitPrice(OrderUnitPriceVO unitPriceVO) {
		
		
		return null;
	}

	@Override
	public List<OrderUnitPriceVO> retrieveUnitPrice(String upreqCd) {
		List<OrderUnitPriceVO> oupList =orderUnitPriceDAO.selectOrderUnitPriceDetailList(upreqCd);
		return oupList;
	}
	
	


	@Override
	public ServiceResult modifyUnitPrice(OrderUnitPriceVO unitPriceVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult removeUnitPrice(int nooo) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public ServiceResult modifyUnitPriceDetail(List<Map<String, String>> orderUnitPriceData) {
		OrderUnitPriceVO oupvo = new OrderUnitPriceVO();
		
		oupvo.setUpreqCd(orderUnitPriceData.get(0).get("upreqCd"));
		//oupvo.setUpreqDur(orderUnitPriceData.get(0).get("upreqDur"));
		//modifyUnitPriceDetail(oupvo);
		ServiceResult modifyUnitPrice=null;
		
		for(int i = 0; i<orderUnitPriceData.size(); i++) {
			OrderUnitPriceItemVO oupivo = new OrderUnitPriceItemVO();
			oupivo.setUprcItQty(Integer.parseInt(orderUnitPriceData.get(i).get("uprcItQty")));
			oupivo.setUprcItCd(orderUnitPriceData.get(i).get("uprcItCd"));
			oupivo.setUpreqDur(orderUnitPriceData.get(i).get("upreqDur"));
			modifyUnitPrice= modifyUnitPriceDetail(oupivo);
		}
		
		return modifyUnitPrice;
	}


	@Override
	public ServiceResult modifyUnitPriceDetail(OrderUnitPriceVO oup) {
		orderUnitPriceDAO.modifyOrderUnitPrice(oup);
		return null;
	}


	@Override
	public ServiceResult modifyUnitPriceDetail(OrderUnitPriceItemVO oupi) {
		int a = orderUnitPriceDAO.modifyOrderUnitPriceItem(oupi);
		ServiceResult result=null;
		if(a>0) {
			result= ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}


	@Override
	public void retrieveOrderUnitPrice(PaginationInfo<OrderUnitPriceVO> paging) {
		int totalRecord = orderUnitPriceDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<OrderUnitPriceVO> dataList = orderUnitPriceDAO.selectOrderUnitPriceList2(paging);
		paging.setDataList(dataList);
		
	}


	@Override
	public List<Map<String, Object>> retrieveUnitPrice1(String upreqCd) {
		List<Map<String, Object>> oupList =orderUnitPriceDAO.selectOrderUnitPriceDetailList1(upreqCd);
		return oupList;
	}

	//거래처 단가 입력 ! 
	@Override
	public ServiceResult createUnitPriceOne(List<Map<String, String>> createUnitPriceOne) {
		ServiceResult result = null;
		
		ComQteVO cq = new ComQteVO();
		
		cq.setComCd(createUnitPriceOne.get(0).get("comCd")); //회사코드
		cq.setUpreqCd(createUnitPriceOne.get(0).get("upreqCd")); //단가요청서코드 
		//insert 문!
		orderUnitPriceDAO.insertUnitPriceOne(cq);
		for(int i=0; i<createUnitPriceOne.size(); i++) {
			ComQteItemVO cqi = new ComQteItemVO();
			
			cqi.setCqteItQty(Integer.parseInt(createUnitPriceOne.get(i).get("cqteItQty")));
			cqi.setCqteItUprc(Integer.parseInt(createUnitPriceOne.get(i).get("cqteItUprc")));
			cqi.setItemCd(createUnitPriceOne.get(i).get("itemCd"));
			orderUnitPriceDAO.insertUnitPriceItemOne(cqi);
			ItemUprcVO iu = new ItemUprcVO();
			
			iu.setItemCd(createUnitPriceOne.get(i).get("itemCd"));
			iu.setUprcConf(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
			iu.setUprcEdate(createUnitPriceOne.get(i).get("uprcEdate"));
			iu.setInUprc(Integer.parseInt(createUnitPriceOne.get(i).get("cqteItUprc")));
			orderUnitPriceDAO.insertItemUprcOne(iu);
		}
		
		PurOrdVO povo = new PurOrdVO();
		
		povo.setPordDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		povo.setDueDate(createUnitPriceOne.get(0).get("upreqValDate"));
		povo.setEmpCd(createUnitPriceOne.get(0).get("empCd"));
		result =createOrderPlay(povo);
		for (int i = 0; i < createUnitPriceOne.size(); i++) {
			PurOrdItemVO poivo = new PurOrdItemVO();
			poivo.setComCd(createUnitPriceOne.get(0).get("comCd"));
			poivo.setItemCd(createUnitPriceOne.get(i).get("itemCd"));
			poivo.setPordQty(Integer.parseInt(createUnitPriceOne.get(i).get("cqteItQty")));
			poivo.setPordUprc(Integer.parseInt(createUnitPriceOne.get(i).get("cqteItUprc")));
			poivo.setItemInQty(Integer.parseInt(createUnitPriceOne.get(i).get("cqteItQty")));
			result =createOrderPlayItem(poivo);
		}
		
		int aa = orderUnitPriceDAO.updateOrderUnitPrice(createUnitPriceOne.get(0).get("upreqCd"));
		
		if(aa>0) { 
			result = ServiceResult.OK; 
		}else { 
			result = ServiceResult.FAIL; 
			}
		
		
		return result;
	}
	
	@Override
	public ServiceResult createOrderPlay(PurOrdVO po) {
		ServiceResult result = null;
		
		int aa=orderPlayDAO.insertPurOrd2(po);
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


	

	
	
}
