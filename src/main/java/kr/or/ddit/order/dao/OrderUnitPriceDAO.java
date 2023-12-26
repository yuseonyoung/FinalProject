package kr.or.ddit.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.order.vo.ComQteItemVO;
import kr.or.ddit.order.vo.ComQteVO;
import kr.or.ddit.order.vo.ItemUprcVO;
import kr.or.ddit.order.vo.OrderUnitPriceItemVO;
import kr.or.ddit.order.vo.OrderUnitPriceVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.vo.PaginationInfo;

@Mapper
public interface OrderUnitPriceDAO {
	
	public List<OrderUnitPriceVO> selectOrderUnitPriceList();
	
	public List<OrderUnitPriceVO> selectOrderUnitPriceDetailList(String upreqCd);
	
	public List<Map<String, Object>> selectOrderUnitPriceDetailList1(String upreqCd);
	
	
	
	
	public int insertUnitPrice(OrderUnitPriceVO unitPriceVO);
	
	public int insertUnitPriceItem(OrderUnitPriceItemVO unitPriceItemVO);
	
	//거래처 견적서 인서트
	public int insertUnitPriceOne(ComQteVO unitPriceOneVO);
	//거래처 견적서 인서트
	public int insertUnitPriceItemOne(ComQteItemVO unitPriceItemOneVO);
	
	//품목별단가 인서트
	public int insertItemUprcOne(ItemUprcVO itemUprcVO);
	
	//단가요청서 수정
	public int modifyOrderUnitPrice(OrderUnitPriceVO unitPriceVO);
	public int modifyOrderUnitPriceItem(OrderUnitPriceItemVO unitPriceItemVO);
	
	//상태변경
	public int updateOrderUnitPrice(String upreqCd);
	
	
	//되냐
    public int selectTotalRecord(PaginationInfo<OrderUnitPriceVO> paging);
    public List<OrderUnitPriceVO> selectOrderUnitPriceList2(PaginationInfo<OrderUnitPriceVO> paging);

	
}
