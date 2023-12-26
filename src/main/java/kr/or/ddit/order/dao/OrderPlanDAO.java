package kr.or.ddit.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.order.vo.OrderPlanVO;
import kr.or.ddit.order.vo.PurOrdVO;
import kr.or.ddit.paging.vo.PaginationInfo;
import kr.or.ddit.purOrderRequest.vo.PurOrderRequestVO;

@Mapper
public interface OrderPlanDAO {
	
	/**
	 * 신규 발주계획서 등록
	 * @param orderPlanVO
	 * @return 등록 성공시(>=1)
	 */
	public int insertOrderPlan(OrderPlanVO orderPlanVO);
	
	/**
	 * 신규 발주계획서 등록시 발주요청서의 상태가 Y로 변환된다!
	 * @param porVO
	 * @return
	 */
	public int updateOrderReq(String preqCd);
	
	/**
	 * 특정 발주계획서 조회
	 * @param pplanCd 검색 조건에 사용될 코드
	 * @return size에 따라 존재 여부 확인?
	 */
	public List<OrderPlanVO> selectOrderPlanList();
	
	/**
	 * 발주계획서  상세 조회
	 * @param pplanCd
	 * @return
	 */
	public List<OrderPlanVO> selectOrderPlanListOne(String pplanCd);
	
	public List<OrderPlanVO> selectOrderPlanListOneUnitPrice(String pplanCd);
	
	public List<OrderPlanVO> selectOrderPlanListOneOrderPlan(String pplanCd);
	
	/**
	 * 발주계획서 등록을 위한 발주요청서 조회
	 * @param preqCd 검색 조건에 사용될 코드
	 * @return size에 따라 존재 여부 확인?
	 */
	public List<PurOrderRequestVO> selectOrderPlanEnrollList();
	
	
	/**
	 * 발주계획서 등록을 위한 발주요청서 상세 조회 
	 * @param preqCd
	 * @return
	 */
	public List<PurOrderRequestVO> selectOrderPlanEnrollOne(String preqCd);
	
	
	/**
	 * 업데이트가 필요할지는 모르겠음 흠 => pplan_stat 이 완료 전 단계에서는 그냥 수정 가능하게 ? 
	 * 그 후로는 가능하지 못하게끔 하긴 해야될듯 
	 * @param orderPlanVO
	 * @return
	 */
	public int updateOrderPlan(OrderPlanVO orderPlanVO);
	
	/**
	 * 
	 * @return
	 * 이렇게 @Param 어노테이션을 붙이면 본인이 원하는 명으로 mapper에서 사용할 수 있다.
	 */
	/* public int deleteOrderPlan(String pplanCd); */
	
	//되냐
    public int selectTotalRecord(PaginationInfo<OrderPlanVO> paging);
    public List<OrderPlanVO> selectOrderPlanList2(PaginationInfo<OrderPlanVO> paging);
    
   

}
